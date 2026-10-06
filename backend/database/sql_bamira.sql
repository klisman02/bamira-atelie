-- Criação da tabela de produtos
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price NUMERIC(10, 2) NOT NULL,
    stock INTEGER NOT NULL DEFAULT 0,
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE INDEX idx_products_name ON products(name);


-- Produtos do catálogo do site Bamira
INSERT INTO products (name, description, price, stock, image_url) VALUES
('Vela de Massagem Relaxante', 'Kit de autocuidado com vela corporal, chá e escalda-pés para um ritual de pausa.', 80.00, 15, '/CATALOGO_BAMIRA/MASSAGEM/WhatsApp Image 2026-07-06 at 15.07.42.jpeg'),
('Vela Aromática Verbena', 'Vela verde em copo de vidro, com presença fresca e leve para iluminar a rotina.', 45.00, 20, '/CATALOGO_BAMIRA/VERBENA/vela_verbena_medio.jpg'),
('Latinha Orixás', 'Vela em latinha com arte simbólica e acabamento dedicado às forças dos Orixás.', 40.00, 25, '/CATALOGO_BAMIRA/ORIXAS/WhatsApp Image 2026-07-22 at 16.03.47.jpeg'),
('Latinha Flor de Maracujá', 'Vela compacta de flor de maracujá, pronta para perfumar pequenos momentos.', 35.00, 30, '/CATALOGO_BAMIRA/LATINHA/IMG_1988.JPEG'),
('Vela Oceano e Erva-Doce', 'Copo azul translúcido com conchas e pedrinhas, inspirado na calmaria do mar.', 65.00, 18, '/CATALOGO_BAMIRA/OCEANO - ERVA DOCE/oceano_erva_doce3.jpeg'),
('Kit Morango', 'Conjunto de velas em formato de morango, vibrante e feito para presentear.', 80.00, 12, '/CATALOGO_BAMIRA/KIT_MORANGO/slide_tela_principal_morango.png'),
('Kit Trio Mini', 'Trio de velas delicadas com formas de cacto, flor e coração em embalagem presenteável.', 70.00, 16, '/CATALOGO_BAMIRA/VELAS TRIO MINI/kit_vela_trio_dentro_da_caixa_cacto_flor_coracao.jpeg'),
('Vela Gourmet Flor de Maracujá', 'Vela cremosa em copo de vidro, decorada como uma sobremesa tropical e luminosa.', 60.00, 22, '/CATALOGO_BAMIRA/GOUTMET_MARACUJA/gourmet_maracuja_slide_pagina_principal.png'),
('Mini Vela Floral', 'Mini velas aromáticas em copo, com flores em cera e cores marcantes.', 45.00, 28, '/CATALOGO_BAMIRA/MINI VELAS/vela_flor_maracuja.JPEG'),
('Vela Suculenta e Cacto', 'Velas esculturais em vasinhos, inspiradas em um pequeno jardim desértico.', 75.00, 14, '/CATALOGO_BAMIRA/SUCULENTA E CACTO/suculenta_e_cacto1.png'),
('Vela Gourmet Café', 'Vela em xícara com grãos decorativos, criada para lembrar uma pausa de café recém-passado.', 65.00, 19, '/CATALOGO_BAMIRA/GOUTMET_CAFÉ/vela_cafe_mesa.png'),
('Vela Concha Algodão', 'Vela azul com concha e flores em cera, combinando leveza, textura e fantasia marinha.', 55.00, 17, '/CATALOGO_BAMIRA/CONCHA  - ALGODAO/concha_algodao2.jpeg'),
('Vela Ameixa Negra Flutuante', 'Vela aromática em copo duplo, com tom de ameixa intenso e acabamento elegante.', 65.00, 21, '/CATALOGO_BAMIRA/AMEIXA NEGRA - COPO FLUTUANTE/vela_ameixa_negra1.jpeg'),
('Vela Gourmet Canela', 'Vela aromática de canela com acabamento artesanal e proposta acolhedora.', 55.00, 24, '/CATALOGO_BAMIRA/GOURMET_CANELA/vela_prosperidade_transparente01.png');

