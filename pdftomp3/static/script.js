document.addEventListener('DOMContentLoaded', function() {
    // Sidebar Toggle
    const sidebar = document.getElementById('sidebar');
    const sidebarToggle = document.getElementById('sidebarToggle');
    const content = document.getElementById('content');

    sidebarToggle.addEventListener('click', function() {
        sidebar.classList.toggle('hidden');
    });

    // Dark Mode Toggle
    const darkModeToggle = document.getElementById('darkModeToggle');
    const darkModeIcon = darkModeToggle.querySelector('i');
    
    // Check for saved theme preference or default to light
    const savedTheme = localStorage.getItem('theme') || 'light';
    document.documentElement.setAttribute('data-theme', savedTheme);
    updateDarkModeIcon(savedTheme === 'dark');

    darkModeToggle.addEventListener('click', function() {
        const currentTheme = document.documentElement.getAttribute('data-theme');
        const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
        
        document.documentElement.setAttribute('data-theme', newTheme);
        localStorage.setItem('theme', newTheme);
        updateDarkModeIcon(newTheme === 'dark');
    });

    function updateDarkModeIcon(isDark) {
        darkModeIcon.className = isDark ? 'bi bi-sun' : 'bi bi-moon';
    }
});