# Loja de Velas Artesanais - Site

Estrutura HTML5 completa para uma página inicial de uma loja de velas artesanais com design responsivo e interativo.

## 📋 Estrutura do Projeto

```
site-vendas-velas/
├── frontend/
│   ├── index/
│   │   └── index.html          # Estrutura HTML5
│   ├── style/
│   │   └── styles.css          # Estilos e responsividade
│   └── scripts/
│       └── script.js           # Interatividade e eventos
├── backend/                    # Pasta para arquivos backend (futuros)
├── README.md                   # Este arquivo
└── .gitignore                  # (opcional)
```

## 🎨 Características

### Header
- **Logo**: Posicionado no lado direito com ícone de fogo
- **Barra de Pesquisa**: No lado esquerdo com input search e botão de busca
- **Sticky**: Fica fixo no topo ao rolar a página

### Seção de Produtos
- **Grid Responsivo**: Adaptável a diferentes tamanhos de tela
- **Cards de Produtos**: Com imagem, título, preço e controles
- **Seletor de Quantidade**: Botões + e - com visor numérico
- **Botão Adicionar ao Carrinho**: Com ícone de carrinho
- **Efeitos Hover**: Animações suaves nos cards

### Footer
- **Links Sociais**: Instagram e WhatsApp com ícones
- **Gradientes**: Estilos especiais para cada rede social
- **Responsivo**: Adapta-se ao tamanho da tela

## 🎯 Classes Semânticas Utilizadas

### HTML
- `<header>`, `<nav>`, `<main>`, `<section>`, `<article>`, `<footer>`
- `<article class="product-card">` para cada produto
- `role` e `aria-label` para acessibilidade

### CSS Classes
- `.site-header` - Container do cabeçalho
- `.navigation-bar` - Barra de navegação
- `.search-container` - Container da busca
- `.search-input`, `.search-button` - Elementos de busca
- `.logo-container`, `.site-logo` - Logo da marca
- `.products-section` - Seção de produtos
- `.products-grid` - Grid dos cards
- `.product-card` - Card individual de produto
- `.product-image-container`, `.product-image` - Imagem do produto
- `.product-info` - Informações do produto
- `.product-title`, `.product-price` - Título e preço
- `.quantity-selector`, `.quantity-button`, `.quantity-display` - Seletor de quantidade
- `.add-to-cart-button` - Botão adicionar ao carrinho
- `.site-footer` - Rodapé
- `.social-links`, `.social-link` - Links sociais

## 🚀 Como Usar

1. **Abra o arquivo** `frontend/index/index.html` no seu navegador
2. **Interaja com os produtos**:
   - Use os botões + e - para alterar a quantidade
   - Digite diretamente no campo de quantidade (1-99)
   - Clique em "Adicionar ao Carrinho" para adicionar um produto

3. **Teste a responsividade**:
   - Redimensione a janela do navegador
   - A página se adapta perfeitamente em dispositivos móveis

4. **Use a barra de pesquisa**:
   - Digite um termo e pressione Enter ou clique no botão de busca

## 📱 Responsividade

A página é totalmente responsiva com breakpoints em:
- **Desktop**: 1200px e acima
- **Tablet**: 768px a 1199px
- **Mobile**: Até 480px

## 🎨 Paleta de Cores

- **Marrom Principal**: #8b6f47 (logo, botão adicionar)
- **Marrom Claro**: #d4a574 (acentos, preço)
- **Branco**: #fff (fundo cards)
- **Cinza Claro**: #f9f7f4 (fundo page)
- **Cinza Escuro**: #2c2c2c (footer)
- **Verde**: #25d366 (WhatsApp)
- **Roxo/Azul**: #667eea (Instagram)

## 🔧 Funcionalidades JavaScript

- ✅ Aumentar/Diminuir quantidade
- ✅ Validação de entrada (1-99)
- ✅ Adição ao carrinho com feedback visual
- ✅ Busca com Enter
- ✅ Console logs para debug

## 📦 Dependências

- **Font Awesome 6.4.0** - Para os ícones (carregado via CDN)
- Navegador moderno com suporte HTML5

## 📁 Organização de Pastas

### Frontend (`/frontend`)
- **`index/`** - Contém o arquivo HTML principal
- **`style/`** - Contém os arquivos CSS de estilização
- **`scripts/`** - Contém os arquivos JavaScript de interatividade

### Backend (`/backend`)
- Pasta reservada para arquivos de backend (Node.js, Python, etc.)
- Será utilizada para APIs, modelos de dados e lógica de servidor

## 🌐 Ícones Utilizados

- 🔥 Fire - Logo
- 🔍 Search - Busca
- 🛒 Shopping Cart - Carrinho
- 📱 Instagram - Rede social
- 💬 WhatsApp - Mensageria
- ✓ Check - Feedback

## 🛠️ Próximas Melhorias

- Integração com backend para persistência de dados
- Carrinho de compras funcional
- Filtros e categorias de produtos
- Sistema de avaliações de produtos
- Checkout com pagamento
- Autenticação de usuários

## 📄 Licença

Criado para fins educacionais. Sinta-se livre para usar e modificar conforme necessário.

---

**Desenvolvido com ♥️ para Velas Artesanais**
