const CART_STORAGE_KEY = 'bamiraCart';

class Cart {
    constructor() {
        this.items = new Map();
        this.load();
    }

    load() {
        const raw = localStorage.getItem(CART_STORAGE_KEY);
        if (!raw) return;
        try {
            const savedItems = JSON.parse(raw);
            if (!Array.isArray(savedItems)) throw new Error('Formato inválido do carrinho');
            let migrated = false;
            savedItems.forEach((item) => {
                const normalized = this.normalizeItem(item);
                if (!normalized) return;
                migrated = migrated || !Object.hasOwn(item, 'nome') || !Object.hasOwn(item, 'preco') || !Object.hasOwn(item, 'quantidade') || !Object.hasOwn(item, 'imagem');
                this.items.set(normalized.id, normalized);
            });
            if (migrated) this.save();
        } catch (error) {
            console.warn('Falha ao carregar o carrinho do localStorage:', error);
            this.items.clear();
            this.save();
        }
    }

    normalizeItem(item) {
        const nome = item && (item.nome || item.name);
        const preco = item && Number(item.preco ?? item.price);
        const quantidade = this.normalizeQuantity(item && (item.quantidade ?? item.quantity));
        if (!item || typeof item.id !== 'string' || typeof nome !== 'string' || !Number.isFinite(preco) || preco < 0 || quantidade < 1) return null;
        return { id: item.id, nome, preco, imagem: typeof item.imagem === 'string' ? item.imagem : '', quantidade };
    }

    save() {
        localStorage.setItem(CART_STORAGE_KEY, JSON.stringify(this.getItems()));
    }

    getItems() {
        return Array.from(this.items.values());
    }

    getTotalQuantity() {
        return this.getItems().reduce((total, item) => total + item.quantidade, 0);
    }

    getTotalPrice() {
        return this.getItems().reduce((total, item) => total + item.preco * item.quantidade, 0);
    }

    addItem(product) {
        const normalized = this.normalizeItem(product);
        if (!normalized) return;
        const existing = this.items.get(normalized.id);
        if (existing) {
            existing.quantidade = this.normalizeQuantity(existing.quantidade + normalized.quantidade);
            this.items.set(existing.id, existing);
        } else {
            this.items.set(normalized.id, normalized);
        }
        this.save();
    }

    updateQuantity(id, quantity) {
        const item = this.items.get(id);
        if (!item) return;
        const normalized = this.normalizeQuantity(quantity);
        if (normalized < 1) this.items.delete(id);
        else {
            item.quantidade = normalized;
            this.items.set(id, item);
        }
        this.save();
    }

    removeItem(id) {
        if (!this.items.delete(id)) return;
        this.save();
    }

    normalizeQuantity(quantity) {
        const parsed = Number(quantity);
        if (!Number.isFinite(parsed)) return 0;
        return Math.max(0, Math.min(99, Math.floor(parsed)));
    }
}
