# Frontend - Velas Artesanais

Arquivos do frontend da aplicação de loja de velas artesanais.

## 📁 Estrutura

```
frontend/
├── index/
│   └── index.html          # Página principal (HTML5 semântico)
├── style/
│   └── styles.css          # Estilos CSS
└── scripts/
    └── script.js           # Lógica JavaScript
```

## 📄 Descrição dos Arquivos

### index.html
- Estrutura HTML5 semântica
- Header com logo e barra de pesquisa
- Grid de produtos com cards
- Footer com links sociais
- Totalmente responsivo

### styles.css
- Estilização completa da página
- Design responsivo (Desktop, Tablet, Mobile)
- Paleta de cores: tons de marrom e dourado
- Animações e efeitos hover
- Grid CSS moderna

### script.js
- Controle de quantidade (+ e -)
- Validação de entrada (1-99)
- Feedback visual ao adicionar ao carrinho
- Função de busca com Enter
- Console logs para debug

## 🚀 Como Usar

1. Abra `index/index.html` em um navegador
2. Interaja com os produtos
3. Customize conforme necessário

## 🎨 Customizações Comuns

### Mudar cores
Edite as cores em `style/styles.css`:
- `#8b6f47` - Marrom principal
- `#d4a574` - Marrom claro
- `#2c2c2c` - Cinza escuro

### Adicionar novos produtos
Copie um `<article class="product-card">` em `index/index.html`

### Atualizar informações
- Logo: edite `.site-logo` em index.html
- Preços: edite `.product-price` em cada card
- Links sociais: atualize URLs em `.social-link`

## 🔗 Integração com Backend

Quando o backend estiver pronto:

1. Atualize as URLs de busca em `script.js`
2. Implemente requisições fetch/axios para:
   - Buscar produtos do servidor
   - Carregar dinâmicamente os cards
   - Adicionar ao carrinho
   - Processar pagamentos

3. Exemplo de integração:
```javascript
fetch('/api/products')
  .then(res => res.json())
  .then(products => renderProducts(products))
```

---

**Frontend pronto para integração com backend!**
