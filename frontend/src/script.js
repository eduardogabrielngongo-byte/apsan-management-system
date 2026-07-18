// Script principal do frontend APSAN

document.addEventListener('DOMContentLoaded', function() {
    console.log('✅ APSAN Frontend loaded');
    
    // Smooth scroll para links de navegação
    const navLinks = document.querySelectorAll('.nav-links a');
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            const href = this.getAttribute('href');
            if (href.startsWith('#')) {
                e.preventDefault();
                const target = document.querySelector(href);
                if (target) {
                    target.scrollIntoView({ behavior: 'smooth' });
                }
            }
        });
    });

    // Botão "Começar Agora"
    const btnPrimary = document.querySelector('.btn-primary');
    if (btnPrimary) {
        btnPrimary.addEventListener('click', function() {
            console.log('Clicou em Começar Agora');
            // Redirecionar para login ou dashboard
            window.location.href = '#login';
        });
    }

    // Verificar autenticação
    checkAuthentication();
});

// Função para verificar autenticação
function checkAuthentication() {
    const token = localStorage.getItem('authToken');
    if (token) {
        console.log('✅ Usuário autenticado');
        // Atualizar UI para usuário autenticado
        updateAuthenticatedUI();
    } else {
        console.log('❌ Usuário não autenticado');
    }
}

// Atualizar UI para usuário autenticado
function updateAuthenticatedUI() {
    const btnLogin = document.querySelector('.btn-login');
    if (btnLogin) {
        btnLogin.textContent = 'Logout';
        btnLogin.addEventListener('click', function(e) {
            e.preventDefault();
            logout();
        });
    }
}

// Função de logout
function logout() {
    localStorage.removeItem('authToken');
    console.log('✅ Logout realizado');
    window.location.reload();
}

// Função para fazer requisições à API
async function apiCall(endpoint, options = {}) {
    const baseURL = process.env.REACT_APP_API_URL || 'http://localhost:3001';
    const token = localStorage.getItem('authToken');

    const headers = {
        'Content-Type': 'application/json',
        ...options.headers,
    };

    if (token) {
        headers['Authorization'] = `Bearer ${token}`;
    }

    try {
        const response

