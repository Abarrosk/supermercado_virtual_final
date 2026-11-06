// Usa uma IIFE com jQuery para isolar o código e activar "use strict".
// initPreloader() adiciona uma classe ao <body> enquanto a página carrega e remove após o window.load, escondendo o preloader.
// initSwiper() inicializa um Swiper principal para o carrossel de categorias (.category-carousel) com slidesPerView variável por breakpoint.
// Ainda em initSwiper(), percorre cada .products-carousel e cria um Swiper independente com número de slides por vista ajustável ao tamanho do ecrã.
// No $(document).ready(), chama initPreloader() e initSwiper(), activando assim animações e carrosséis da homepage.

(function ($) {
  "use strict";
  var initPreloader = function () {
    $(document).ready(function ($) {
      var Body = $("body");
      Body.addClass("preloader-site");
    });
    $(window).on("load", function () {
      $(".preloader-wrapper").fadeOut();
      $("body").removeClass("preloader-site");
    });
  };
  var initSwiper = function () {
    var category_swiper = new Swiper(".category-carousel", {
      slidesPerView: 8,
      spaceBetween: 30,
      speed: 500,
      navigation: {
        nextEl: ".category-carousel-next",
        prevEl: ".category-carousel-prev",
      },
      breakpoints: {
        0: {
          slidesPerView: 2,
        },
        768: {
          slidesPerView: 3,
        },
        991: {
          slidesPerView: 5,
        },
        1500: {
          slidesPerView: 8,
        },
      },
    });
    $(".products-carousel").each(function () {
      var $el_id = $(this).attr("id");
      var products_swiper = new Swiper("#" + $el_id + " .swiper", {
        slidesPerView: 5,
        spaceBetween: 30,
        speed: 500,
        navigation: {
          nextEl: "#" + $el_id + " .products-carousel-next",
          prevEl: "#" + $el_id + " .products-carousel-prev",
        },
        breakpoints: {
          0: {
            slidesPerView: 1,
          },
          768: {
            slidesPerView: 3,
          },
          991: {
            slidesPerView: 4,
          },
          1500: {
            slidesPerView: 5,
          },
        },
      });
    });
  };
  $(document).ready(function () {
    initPreloader();
    initSwiper();
  });
})(jQuery);
