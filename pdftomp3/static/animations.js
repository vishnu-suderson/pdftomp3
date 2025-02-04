document.addEventListener("DOMContentLoaded", function () {
    const links = document.querySelectorAll(".transition-link");

    links.forEach(link => {
        link.addEventListener("click", function (e) {
            e.preventDefault(); // Prevent default navigation
            document.body.classList.add("fade-out"); // Add fade-out animation
            
            setTimeout(() => {
                window.location.href = this.href;
            }, 40); // Delay matches animation duration
        });
    });
});
