$ErrorActionPreference = 'Stop'

$backendRoot = $PSScriptRoot
$databaseName = 'velas_artesanais_db'
$envPath = Join-Path $backendRoot '.env'
$sqlPath = Join-Path $backendRoot 'database\sql_bamira.sql'

if (Test-Path $envPath) {
    throw "O arquivo $envPath já existe. Preserve-o e configure o banco manualmente ou remova-o conscientemente antes de continuar."
}

if (-not (Test-Path $sqlPath)) {
    throw "Arquivo SQL não encontrado: $sqlPath"
}

$psql = (Get-Command psql.exe -ErrorAction SilentlyContinue).Source
if (-not $psql) {
    $installRoot = Join-Path $env:ProgramFiles 'PostgreSQL'
    if (Test-Path $installRoot) {
        $psql = Get-ChildItem $installRoot -Directory |
            Where-Object { $_.Name -match '^\d+(\.\d+)*$' } |
            Sort-Object { [version]$_.Name } -Descending |
            ForEach-Object {
                $candidate = Join-Path $_.FullName 'bin\psql.exe'
                if (Test-Path $candidate) { $candidate }
            } |
            Select-Object -First 1
    }
}

if (-not $psql) {
    throw 'psql.exe não foi encontrado. Instale os utilitários de linha de comando do PostgreSQL ou adicione psql.exe ao PATH.'
}

$dbHost = Read-Host 'Host PostgreSQL [localhost]'
if ([string]::IsNullOrWhiteSpace($dbHost)) { $dbHost = 'localhost' }
if ($dbHost -notmatch '^[A-Za-z0-9.-]+$' -and $dbHost -notmatch '^[A-Fa-f0-9:]+$') {
    throw 'Host inválido. Informe um nome de host ou endereço IP sem porta.'
}

$dbPort = Read-Host 'Porta PostgreSQL [5432]'
if ([string]::IsNullOrWhiteSpace($dbPort)) { $dbPort = '5432' }
if ($dbPort -notmatch '^\d+$' -or [int]$dbPort -lt 1 -or [int]$dbPort -gt 65535) {
    throw 'Porta inválida.'
}

$adminUser = Read-Host 'Usuário administrativo PostgreSQL [postgres]'
if ([string]::IsNullOrWhiteSpace($adminUser)) { $adminUser = 'postgres' }

$securePassword = Read-Host 'Senha administrativa PostgreSQL (entrada oculta)' -AsSecureString
$passwordPointer = [IntPtr]::Zero
$plainPassword = $null
$createdDatabase = $false
$previousPgPassword = [Environment]::GetEnvironmentVariable('PGPASSWORD', 'Process')

try {
    $passwordPointer = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($securePassword)
    $plainPassword = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($passwordPointer)
    if ([string]::IsNullOrEmpty($plainPassword)) {
        throw 'A senha administrativa não pode estar vazia.'
    }

    $env:PGPASSWORD = $plainPassword
    $adminArgs = @('-h', $dbHost, '-p', $dbPort, '-U', $adminUser, '-v', 'ON_ERROR_STOP=1')

    $databaseExists = & $psql @adminArgs -d postgres -tAc "SELECT 1 FROM pg_database WHERE datname = '$databaseName'"
    if ($LASTEXITCODE -ne 0) {
        throw 'Não foi possível conectar ao PostgreSQL com as credenciais fornecidas.'
    }

    if (([string]$databaseExists).Trim() -eq '1') {
        $tableExists = & $psql @adminArgs -d $databaseName -tAc "SELECT 1 FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'products'"
        if ($LASTEXITCODE -ne 0) {
            throw "Não foi possível inspecionar o banco existente '$databaseName'."
        }
        if (([string]$tableExists).Trim() -eq '1') {
            throw "A tabela public.products já existe no banco '$databaseName'. O script SQL não é idempotente e não será reaplicado."
        }
        Write-Host "Usando banco existente '$databaseName' sem tabela products."
    }
    else {
        & $psql @adminArgs -d postgres -c "CREATE DATABASE `"$databaseName`""
        if ($LASTEXITCODE -ne 0) {
            throw "Não foi possível criar o banco '$databaseName'."
        }
        $createdDatabase = $true
    }

    & $psql @adminArgs -d $databaseName -1 -f $sqlPath
    if ($LASTEXITCODE -ne 0) {
        throw 'A aplicação do arquivo sql_bamira.sql falhou; as alterações SQL foram executadas em uma transação.'
    }

    $randomBytes = New-Object byte[] 32
    $randomGenerator = [Security.Cryptography.RandomNumberGenerator]::Create()
    try {
        $randomGenerator.GetBytes($randomBytes)
    }
    finally {
        $randomGenerator.Dispose()
    }
    $appPassword = [BitConverter]::ToString($randomBytes).Replace('-', '').ToLowerInvariant()
    $appUser = 'velas_app_' + $appPassword.Substring(0, 8)

    $roleSql = "CREATE ROLE `"$appUser`" LOGIN PASSWORD '$appPassword' NOSUPERUSER NOCREATEDB NOCREATEROLE NOREPLICATION; GRANT CONNECT ON DATABASE `"$databaseName`" TO `"$appUser`"; GRANT USAGE ON SCHEMA public TO `"$appUser`"; GRANT SELECT ON TABLE public.products TO `"$appUser`";"
    & $psql @adminArgs -d $databaseName -c $roleSql
    if ($LASTEXITCODE -ne 0) {
        throw 'Não foi possível criar o usuário restrito da aplicação e conceder acesso de leitura.'
    }

    $envContent = @(
        'PORT=3000'
        "DB_HOST=$dbHost"
        "DB_PORT=$dbPort"
        "DB_USER=$appUser"
        "DB_PASSWORD=$appPassword"
        "DB_NAME=$databaseName"
        ''
    ) -join "`n"
    [System.IO.File]::WriteAllText($envPath, $envContent, [System.Text.UTF8Encoding]::new($false))

    Write-Host "Configuração concluída: banco '$databaseName', catálogo importado e credenciais gravadas em backend\.env."
    Write-Host 'O usuário da aplicação tem somente acesso de leitura à tabela products.'
}
catch {
    if ($createdDatabase) {
        Write-Warning "O banco '$databaseName' foi criado, mas o bootstrap não terminou. Verifique o erro acima antes de tentar novamente."
    }
    throw
}
finally {
    [Environment]::SetEnvironmentVariable('PGPASSWORD', $previousPgPassword, 'Process')
    if ($passwordPointer -ne [IntPtr]::Zero) {
        [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($passwordPointer)
    }
    if ($securePassword) {
        $securePassword.Dispose()
    }
}
