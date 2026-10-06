mkdir backend-velas
cd backend-velas
npm init -y

# Dependências principais
npm install express pg cors dotenv

# Dependências de desenvolvimento (TypeScript)
npm install -D typescript @types/express @types/pg @types/cors ts-node-dev

# Inicializar configuração do TypeScript
npx tsc --init