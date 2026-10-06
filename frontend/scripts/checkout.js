const checkoutCart = typeof Cart !== 'undefined' ? new Cart() : null;
const summaryItems = document.getElementById('summary-items');
const summaryEmpty = document.getElementById('summary-empty');
const summaryProducts = document.getElementById('summary-products');
const summaryShipping = document.getElementById('summary-shipping');
const summaryTotal = document.getElementById('summary-total');
const shippingOptions = document.querySelectorAll('input[name="shipping"]');
const paymentOptions = document.querySelectorAll('input[name="payment"]');
const paymentPreview = document.getElementById('payment-preview');
const cepInput = document.getElementById('cep');
const cepHint = document.getElementById('cep-hint');
const calculateShippingButton = document.getElementById('calculate-shipping');
const placeOrderButton = document.getElementById('place-order-button');

function renderSummary() {
    if (!checkoutCart || !summaryItems || !summaryProducts || !summaryShipping || !summaryTotal) return;

    const items = checkoutCart.getItems();
    const productsTotal = checkoutCart.getTotalPrice();
    const shippingTotal = getSelectedShippingValue();

    summaryItems.innerHTML = '';
    summaryEmpty.classList.toggle('hidden', items.length > 0);

    items.forEach(item => {
        const row = document.createElement('div');
        row.className = 'summary-item';
        row.innerHTML = `
            <div>
                <strong>${escapeHtml(item.nome)}</strong>
                <span>${item.quantidade} unidade${item.quantidade > 1 ? 's' : ''}</span>
            </div>
            <b>${formatPrice(item.preco * item.quantidade)}</b>
        `;
        summaryItems.appendChild(row);
    });

    summaryProducts.textContent = formatPrice(productsTotal);
    summaryShipping.textContent = formatPrice(items.length ? shippingTotal : 0);
    summaryTotal.textContent = formatPrice(productsTotal + (items.length ? shippingTotal : 0));
    placeOrderButton.disabled = items.length === 0;
}

function getSelectedShippingValue() {
    const selected = document.querySelector('input[name="shipping"]:checked');
    return selected ? Number(selected.value) : 0;
}

function updateSelectedCards(options, selectedClass) {
    options.forEach(option => {
        option.closest('label').classList.toggle(selectedClass, option.checked);
    });
}

function updatePaymentPreview() {
    const payment = document.querySelector('input[name="payment"]:checked')?.value;
    if (!paymentPreview) return;

    if (payment === 'boleto') {
        paymentPreview.innerHTML = `
            <i class="fas fa-barcode"></i>
            <div>
                <strong>Boleto bancário selecionado</strong>
                <p>O boleto será gerado depois da confirmação visual do pedido.</p>
            </div>
        `;
        return;
    }

    paymentPreview.innerHTML = `
        <i class="fas fa-qrcode"></i>
        <div>
            <strong>Pagamento por Pix selecionado</strong>
            <p>O QR Code será exibido depois da confirmação visual do pedido.</p>
        </div>
    `;
}

function formatCep(value) {
    const numbers = value.replace(/\D/g, '').slice(0, 8);
    if (numbers.length <= 5) return numbers;
    return `${numbers.slice(0, 5)}-${numbers.slice(5)}`;
}

function showShippingFeedback() {
    const cep = cepInput.value.trim();
    if (cep.length < 9) {
        cepHint.textContent = 'Informe um CEP completo para simular o frete.';
        cepHint.classList.add('warning');
        return;
    }

    cepHint.textContent = `Fretes simulados para o CEP ${cep}.`;
    cepHint.classList.remove('warning');
}

function escapeHtml(value) {
    return String(value)
        .replace(/&/g, '&amp;')
        .replace(/</g, '&lt;')
        .replace(/>/g, '&gt;')
        .replace(/"/g, '&quot;')
        .replace(/'/g, '&#039;');
}

function formatPrice(value) {
    return value.toLocaleString('pt-BR', {
        style: 'currency',
        currency: 'BRL',
    });
}

shippingOptions.forEach(option => {
    option.addEventListener('change', () => {
        updateSelectedCards(shippingOptions, 'selected');
        renderSummary();
    });
});

paymentOptions.forEach(option => {
    option.addEventListener('change', () => {
        updateSelectedCards(paymentOptions, 'selected');
        updatePaymentPreview();
    });
});

if (cepInput) {
    cepInput.addEventListener('input', () => {
        cepInput.value = formatCep(cepInput.value);
    });
}

if (calculateShippingButton) {
    calculateShippingButton.addEventListener('click', showShippingFeedback);
}

if (placeOrderButton) {
    placeOrderButton.addEventListener('click', () => {
        placeOrderButton.innerHTML = '<i class="fas fa-check"></i> Pedido visual confirmado';
        placeOrderButton.classList.add('confirmed');
    });
}

renderSummary();
updateSelectedCards(shippingOptions, 'selected');
updateSelectedCards(paymentOptions, 'selected');
updatePaymentPreview();
