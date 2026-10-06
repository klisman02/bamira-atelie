# Backend - Velas Artesanais

Pasta reservada para os arquivos do backend da aplicação.

## 🧱 Estrutura atual

A organização foi feita apenas com as pastas que fazem sentido para o estado atual do projeto, sem criar camadas extras desnecessárias antes da aplicação crescer.

```
backend/
├── README.md
├── package.json
├── gemini-code-1790253435233.sh   # script auxiliar de setup
├── src/
│   └── server.ts                  # servidor e endpoints da API
├── config/
│   └── .env.example               # variáveis de ambiente
├── database/
│   └── sql_bamira.sql             # estrutura do banco e dados iniciais
└── .gitignore                     # opcional, quando necessário
```

## ✅ Princípios adotados

- `src/` para o código da aplicação.
- `config/` para arquivos de configuração e ambiente.
- `database/` para scripts SQL e migrações.
- Sem criar `models`, `routes`, `controllers` e `services` enquanto o backend ainda não possui a estrutura real da aplicação.

## 🔧 Tecnologias do projeto

- Node.js + Express
- PostgreSQL
- TypeScript

## 🚀 Próximos passos

1. Definir o restante da arquitetura da API conforme a aplicação crescer
2. Criar módulos adicionais apenas quando houver necessidade real
3. Implementar autenticação, pedidos e catálogo em módulos específicos
4. Conectar o backend ao frontend
