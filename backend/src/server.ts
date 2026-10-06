// src/server.ts
import express, { type Request, type Response } from 'express';
import cors from 'cors';
import { Pool } from 'pg';
import dotenv from 'dotenv';

// Carrega as variáveis de ambiente
dotenv.config();

const app = express();
const port = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(express.json());

// Configuração do Pool de conexão do PostgreSQL
const pool = new Pool({
    host: process.env.DB_HOST,
    port: parseInt(process.env.DB_PORT || '5432'),
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
});

// Endpoint 1: Buscar todos os produtos (Catálogo)
app.get('/api/products', async (req: Request, res: Response) => {
    try {
        // Consulta SQL direta para buscar os produtos disponíveis
        const result = await pool.query(
            'SELECT id, name, description, price, stock, image_url FROM products WHERE stock > 0 ORDER BY id ASC'
        );
        
        res.status(200).json(result.rows);
    } catch (error) {
        console.error('Erro ao buscar produtos:', error);
        res.status(500).json({ error: 'Erro interno do servidor ao carregar o catálogo.' });
    }
});

// Endpoint bônus: Buscar um produto específico pelo ID
app.get('/api/products/:id', async (req: Request, res: Response) => {
    const { id } = req.params;
    
    try {
        const result = await pool.query(
            'SELECT id, name, description, price, stock, image_url FROM products WHERE id = $1',
            [id]
        );

        if (result.rows.length === 0) {
            return res.status(404).json({ error: 'Produto não encontrado.' });
        }

        res.status(200).json(result.rows[0]);
    } catch (error) {
        console.error('Erro ao buscar o produto:', error);
        res.status(500).json({ error: 'Erro interno do servidor.' });
    }
});

// Inicialização do servidor
app.listen(port, () => {
    console.log(`Servidor rodando na porta ${port}`);
});