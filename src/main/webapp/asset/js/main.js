// asset/js/main.js

document.addEventListener('DOMContentLoaded', function() {
    
    const hamburgerBtn = document.getElementById('hamburger-btn');
    const mobileMenu = document.getElementById('mobile-menu');
    const closeMenuBtn = document.getElementById('close-menu-btn');

    if (hamburgerBtn && mobileMenu && closeMenuBtn) {
        
        // 햄버거 버튼 클릭 시: 메뉴를 보여줌
        hamburgerBtn.addEventListener('click', function() {
            mobileMenu.classList.add('active');
        });

        // 닫기(X) 버튼 클릭 시: 메뉴를 숨김
        closeMenuBtn.addEventListener('click', function() {
            mobileMenu.classList.remove('active');
        });
    }

});