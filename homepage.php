<?php

/*Carrega o bootstrap e render_card.php, lê um eventual termo de pesquisa (q) e, se existir, executa search_products_by_name().
Obtém vários blocos de produtos: mais vendidos, destaque, populares e recentes, usando as funções de inc/products.php.
Renderiza a página inicial, categorias em destaque, carrosséis de produtos e secções “Ver tudo” ligadas a comprar.php.
Usa cards de produto reutilizáveis e classes que são animadas pelo homepage.js via Swiper e preloader.
É a entrada principal da loja, misturando promoções, pesquisa rápida e acesso às categorias.*/

require __DIR__ . '/config/bootstrap.php';
require_once __DIR__ . '/inc/render_card.php';

$searchTerm    = trim($_GET['q'] ?? '');
$searchResults = [];
if ($searchTerm !== '') {
  $searchResults = search_products_by_name($searchTerm, 12);
}

$maisVendidos    = products_mais_vendidos(5);
$produtosDestaque= products_destaque(5);
$maisPopulares   = products_populares(5);
$recemChegados   = products_recentes(5);
?>
<!DOCTYPE html>
<html lang="pt">
    <head>
      <meta charset="utf-8" />
      <title>Orgânicos - Loja de Produtos Naturais - Homepage</title>
      <link rel="icon" type="image/x-icon" href="images/icons/favicon.ico" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <meta name="format-detection" content="telephone=no" />
      <meta name="apple-mobile-web-app-capable" content="yes" />
      <meta name="author" content="Andre Barros" />
      <meta name="robots" content="index, follow" />
      <meta name="keywords" content="Orgânicos, supermercado online, produtos naturais, frutas, legumes, lacticínios, 
        ovos, mercearias, carne, peixe, marisco, padaria, pastelaria, conservas, massa, 
        arroz, bebidas, especiarias, temperos, alimentação saudável homepage" />
      <meta name="description" content="Compre online frutas, legumes, carne, peixe, padaria, 
        lacticínios e muito mais. Produtos orgânicos e frescos entregues em sua casa, em todo o país." />
      <link rel="canonical" href="http://localhost/projecto_final/homepage.php" />
      <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
        rel="stylesheet"
        integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
        crossorigin="anonymous"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css"
    />
    <link rel="stylesheet" href="css/homepage.css" />
    <link
      href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&family=Open+Sans:ital,wght@0,400;0,700;1,400;1,700&display=swap"
      rel="stylesheet"
    />
  </head>
  <body>
    <div class="preloader-wrapper">
      <div class="preloader"></div>
    </div>

    <!-- Barra lateral direita do carrinho -->
    <div
      class="offcanvas offcanvas-end"
      data-bs-scroll="true"
      tabindex="-1"
      id="offcanvasCart">
      <div class="offcanvas-header justify-content-center">
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="offcanvas"
          aria-label="Close"
        ></button>
      </div>
      <div class="offcanvas-body">
        <div class="order-md-last">
          <?php
            $cart = cart_get();
            $total_itens = $cart ? array_sum(array_column($cart, 'qty')) : 0;
            $total = 0.0;
            ?>
        <h4 class="d-flex justify-content-between align-items-center mb-3">
          <span class="text-primary">O seu carrinho</span>
          <span class="badge bg-primary rounded-pill"><?= $total_itens ?></span>
        </h4>
        <ul class="list-group mb-3">
          <?php if (empty($cart)): ?>
            <li class="list-group-item d-flex justify-content-between lh-sm">
              <div><small class="text-body-secondary">O carrinho está vazio.</small></div>
            </li>
          <?php else: ?>
          <?php foreach ($cart as $item): ?>
          <?php $linha = $item['preco'] * $item['qty']; $total += $linha; ?>
          <li class="list-group-item d-flex justify-content-between lh-sm">
            <div>
              <h6 class="my-0"><?= htmlspecialchars($item['nome']) ?></h6>
              <small class="text-body-secondary">
                <?= (int)$item['qty'] ?> × <?= number_format($item['preco'], 2, ',', ' ') ?>€
              </small>
            </div>
            <span class="text-body-secondary"><?= number_format($linha, 2, ',', ' ') ?>€</span>
          </li>
          <?php endforeach; ?>
          <li class="list-group-item d-flex justify-content-between">
            <span>Total (EUR)</span>
            <strong><?= number_format($total, 2, ',', ' ') ?>€</strong>
          </li>
        <?php endif; ?>
        </ul>
          <a href="checkout.php" class="w-100 btn btn-primary btn-lg">
            Continuar para o pagamento
          </a>
           <?php if (!empty($cart)): ?>
            <form method="post" action="api/cart_clear.php" class="mt-2">
              <button class="w-100 btn btn-outline-secondary" type="submit">
                Esvaziar carrinho
              </button>
            </form>
          <?php endif; ?>
        </div>
      </div>
    </div>
    <!-- --------------------------------------------------------- -->

    <!-- Barra lateral esquerda de navegação -->
    <div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasNavbar">
      <div class="offcanvas-header justify-content-between">
        <h4 class="fw-normal text-uppercase fs-6">Menu</h4>
        <button
          type="button"
          class="btn-close"
          data-bs-dismiss="offcanvas"
          aria-label="Close"
        ></button>
      </div>

      <div class="offcanvas-body">
        <ul
          class="navbar-nav justify-content-end menu-list list-unstyled d-flex gap-md-3 mb-0"
        >
          <li class="nav-item border-dashed active">
            <a
              href="comprar.php?tipo=categoria&slug=frutas_legumes&ver=tudo"
              class="nav-link d-flex align-items-center gap-3 text-dark p-2"
            >
              <svg width="24" height="24" viewBox="0 0 24 24">
                <use xlink:href="images/icons.svg#fruits"></use>
              </svg>
              <span>Frutas e Legumes</span>
            </a>
          </li>
          <li class="nav-item border-dashed">
            <a
              href="comprar.php?tipo=categoria&slug=lacticinios_ovos&ver=tudo"
              class="nav-link d-flex align-items-center gap-3 text-dark p-2"
            >
              <svg width="24" height="24" viewBox="0 0 24 24">
                <use xlink:href="images/icons.svg#dairy"></use>
              </svg>
              <span>Lacticínios e Ovos</span>
            </a>
          </li>
          <li class="nav-item border-dashed">
            <a
              href="comprar.php?tipo=categoria&slug=carnes_aves&ver=tudo"
              class="nav-link d-flex align-items-center gap-3 text-dark p-2"
            >
              <svg width="24" height="24" viewBox="0 0 24 24">
                <use xlink:href="images/icons.svg#meat"></use>
              </svg>
              <span>Carnes e Aves</span>
            </a>
          </li>
          <li class="nav-item border-dashed">
            <a
              href="comprar.php?tipo=categoria&slug=peixe_marisco&ver=tudo"
              class="nav-link d-flex align-items-center gap-3 text-dark p-2"
            >
              <svg width="24" height="24" viewBox="0 0 24 24">
                <use xlink:href="images/icons.svg#seafood"></use>
              </svg>
              <span>Peixe e Marisco</span>
            </a>
          </li>
          <li class="nav-item border-dashed">
            <a
              href="comprar.php?tipo=categoria&slug=padaria_pastelaria&ver=tudo"
              class="nav-link d-flex align-items-center gap-3 text-dark p-2"
            >
              <svg width="24" height="24" viewBox="0 0 24 24">
                <use xlink:href="images/icons.svg#bakery"></use>
              </svg>
              <span>Pastelaria e Pão</span>
            </a>
          </li>
          <li class="nav-item border-dashed">
            <a
              href="comprar.php?tipo=categoria&slug=conservas&ver=tudo"
              class="nav-link d-flex align-items-center gap-3 text-dark p-2"
            >
              <svg width="24" height="24" viewBox="0 0 24 24">
                <use xlink:href="images/icons.svg#canned"></use>
              </svg>
              <span>Conservas</span>
            </a>
          </li>
          <li class="nav-item border-dashed">
            <a
              href="comprar.php?tipo=categoria&slug=massa_arroz&ver=tudo"
              class="nav-link d-flex align-items-center gap-3 text-dark p-2"
            >
              <svg width="24" height="24" viewBox="0 0 24 24">
                <use xlink:href="images/icons.svg#pasta"></use>
              </svg>
              <span>Massa e Arroz</span>
            </a>
          </li>
          <li class="nav-item border-dashed">
            <a
              href="comprar.php?tipo=categoria&slug=bebidas&ver=tudo"
              class="nav-link d-flex align-items-center gap-3 text-dark p-2"
            >
              <svg width="24" height="24" viewBox="0 0 24 24">
                <use xlink:href="images/icons.svg#beverages"></use>
              </svg>
              <span>Bebidas</span>
            </a>
          </li>
          <li class="nav-item border-dashed">
            <a
              href="comprar.php?tipo=categoria&slug=especiarias_temperos&ver=tudo"
              class="nav-link d-flex align-items-center gap-3 text-dark p-2"
            >
              <svg width="24" height="24" viewBox="0 0 24 24">
                <use xlink:href="images/icons.svg#spices"></use>
              </svg>
              <span>Especiarias e Temperos</span>
            </a>
          </li>
        </ul>
      </div>
    </div>
    <!-- --------------------------------------------------------- -->

    <header class="fixed-top bg-white">
      <!-- Barra superior -->
      <div class="container-fluid">
        <div class="row py-3 border-bottom">
          <!-- Logo Marca, lado esquerdo -->
          <div
            class="col-sm-4 col-lg-2 text-center text-sm-start d-flex gap-3 justify-content-center justify-content-md-start"
          >
            <div class="d-flex align-items-center my-3 my-sm-0">
              <a href="homepage.php">
                <img src="images/logo.svg" alt="logo" class="img-fluid" />
              </a>
            </div>
            <button
              class="navbar-toggler"
              type="button"
              data-bs-toggle="offcanvas"
              data-bs-target="#offcanvasNavbar"
              aria-controls="offcanvasNavbar"
            >
              <svg width="24" height="24" viewBox="0 0 24 24">
                <use xlink:href="images/icons.svg#menu"></use>
              </svg>
            </button>
          </div>
          <!-- --------------------------------------------------------- -->

          <!-- Barra de procura -->
          <div class="col-sm-6 offset-sm-2 offset-md-0 col-lg-4">
              <div class="col-12 col-md-7">
                <form
  id="search-form"
  action="homepage.php#resultados-pesquisa"
  method="get"
  class="position-relative"
>
  <input
    type="text"
    name="q"
    class="form-control border-0 bg-transparent ps-3 pe-5"
    placeholder="Pesquise por produtos"
    value="<?= e($searchTerm) ?>"
  />
  <button
    type="submit"
    class="position-absolute top-50 end-0 translate-middle-y me-2 border-0 bg-transparent p-0"
    aria-label="Procurar"
  >
    <svg width="20" height="20">
      <use xlink:href="images/icons.svg#search"></use>
    </svg>
  </button>
</form>

            </div>
          </div>
          <!-- --------------------------------------------------------- -->

          <!-- Ícones do lado direito, login do user e check-out -->
          <div
            class="col-sm-8 col-lg-2 d-flex gap-5 align-items-center justify-content-end ms-auto"
          >
            <ul class="d-flex justify-content-end list-unstyled m-0">
              <?php
              $user    = $_SESSION['user'] ?? null;
              $isAdmin = ((int)($user['is_admin'] ?? 0) === 1);
              ?>
              <?php if (!$user): ?>
              <li>
                <a href="login.php" class="p-2 mx-1" title="Entrar">
                  <svg width="24" height="24"><use xlink:href="images/icons.svg#user"></use></svg>
                </a>
              </li>
              <?php else: ?>
              <li class="nav-item dropdown">
                <a class="p-2 mx-1" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false" title="Conta">
                  <svg width="24" height="24"><use xlink:href="images/icons.svg#user"></use></svg>
                </a>
                <ul class="dropdown-menu dropdown-menu-end">
                  <?php if ($isAdmin): ?>
                    <li><a class="dropdown-item" href="userProfile.php">Editar o meu perfil</a></li>
                    <li><a class="dropdown-item" href="admin_dashboard.php">Editar a plataforma</a></li>
                  <?php else: ?>
                    <li><a class="dropdown-item" href="userProfile.php">Editar o meu perfil</a></li>
                  <?php endif; ?>

                  <li><hr class="dropdown-divider"></li>
                  <li>
                    <form method="post" action="logout.php" class="px-3">
                      <?= csrf_field() ?>
                      <button type="submit" class="dropdown-item p-0">Terminar sessão</button>
                    </form>
                  </li>
                </ul>
              </li>
              <?php endif; ?>
              <li>
                <a
                  href="#"
                  class="p-2 mx-1"
                  data-bs-toggle="offcanvas"
                  data-bs-target="#offcanvasCart"
                  aria-controls="offcanvasCart"
                >
                  <svg width="24" height="24">
                    <use xlink:href="images/icons.svg#shopping-bag"></use>
                  </svg>
                </a>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </header>

    <!-- Primeira secção quando se chega ao site -->
    <section
      style="
        background-image: url('images/banner_homepage.jpg');
        background-repeat: no-repeat;
        background-size: cover;">
      <div class="container-lg">
        <div class="row">
          <div class="col-lg-6 pt-5 mt-5">
            <h2 class="display-1 ls-1">
              <span class="fw-bold text-primary">Alimentos</span> Orgânicos à
              sua
              <span class="fw-bold">Porta</span>
            </h2>
            <p class="fs-4">Colhidos da horta diretamente para a sua casa.</p>
            <div class="d-flex gap-3">
              <a
                href="comprar.php?tipo=random"
                class="btn btn-primary text-uppercase fs-6 rounded-pill px-4 py-3 mt-3"
              >
                Começar a Comprar
              </a>
              <a
                href="registar.php"
                class="btn btn-dark text-uppercase fs-6 rounded-pill px-4 py-3 mt-3"
                >Junte-se a Nós</a
              >
            </div>
            <div class="row my-5">
              <div class="col">
                <div class="row text-dark">
                  <div class="col-auto">
                    <p class="fs-1 fw-bold lh-sm mb-0">500</p>
                  </div>
                  <div class="col">
                    <p class="text-uppercase lh-sm mb-0">
                      Variedades de Produtos
                    </p>
                  </div>
                </div>
              </div>
              <div class="col">
                <div class="row text-dark">
                  <div class="col-auto">
                    <p class="fs-1 fw-bold lh-sm mb-0">10k+</p>
                  </div>
                  <div class="col">
                    <p class="text-uppercase lh-sm mb-0">
                      Clientes Satisfeitos
                    </p>
                  </div>
                </div>
              </div>
              <div class="col">
                <div class="row text-dark">
                  <div class="col-auto">
                    <p class="fs-1 fw-bold lh-sm mb-0">18</p>
                  </div>
                  <div class="col">
                    <p class="text-uppercase lh-sm mb-0">
                      Lojas espalhadas pelo País
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div
          class="row row-cols-1 row-cols-sm-3 row-cols-lg-3 g-0 justify-content-center"
        >
          <div class="col">
            <div class="card border-0 bg-primary rounded-0 p-4 text-light">
              <div class="row">
                <div class="col-md-3 text-center">
                  <svg width="60" height="60">
                    <use xlink:href="images/icons.svg#fresh"></use>
                  </svg>
                </div>
                <div class="col-md-9">
                  <div class="card-body p-0">
                    <h5 class="text-light">Fresco da Quinta</h5>
                    <p class="card-text">
                      Diretamente do produtor para a sua mesa, garantindo
                      frescura máxima.
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col">
            <div class="card border-0 bg-secondary rounded-0 p-4 text-light">
              <div class="row">
                <div class="col-md-3 text-center">
                  <svg width="60" height="60">
                    <use xlink:href="images/icons.svg#organic"></use>
                  </svg>
                </div>
                <div class="col-md-9">
                  <div class="card-body p-0">
                    <h5 class="text-light">100% Biológico</h5>
                    <p class="card-text">
                      Produtos frescos sem químicos nocivos, aditivos ou
                      fertilizantes indesejáveis.
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="col">
            <div class="card border-0 bg-danger rounded-0 p-4 text-light">
              <div class="row">
                <div class="col-md-3 text-center">
                  <svg width="60" height="60">
                    <use xlink:href="images/icons.svg#delivery"></use>
                  </svg>
                </div>
                <div class="col-md-9">
                  <div class="card-body p-0">
                    <h5 class="text-light">Entrega Gratuita</h5>
                    <p class="card-text">
                      Em compras superiores a 50€, oferecemos entrega gratuita
                      num raio de 30km.
                    </p>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- --------------------------------------------------------- -->

    <!-- Categorias -->
    <section class="py-5 overflow-hidden">
      <div class="container-lg">
        <div class="row">
          <div class="col-md-12">
            <div
              class="section-header d-flex flex-wrap justify-content-between mb-5"
            >
              <h2 class="section-title">Categoria</h2>

              <div class="d-flex align-items-center">
                <div class="swiper-buttons">
                  <button
                    class="swiper-prev category-carousel-prev btn btn-yellow"
                  >
                    ❮
                  </button>
                  <button
                    class="swiper-next category-carousel-next btn btn-yellow"
                  >
                    ❯
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div class="category-carousel swiper">
              <div class="swiper-wrapper">
                <a
                  href="comprar.php?tipo=categoria&slug=frutas_legumes&ver=tudo"
                  class="nav-link swiper-slide text-center"
                >
                  <img
                    src="images/frutas_legumes.jpg"
                    class="rounded-circle"
                    alt="Miniatura da Categoria"
                  />
                  <h4 class="fs-6 mt-3 fw-normal category-title">
                    Frutas e Legumes
                  </h4>
                </a>
                <a
                  href="comprar.php?tipo=categoria&slug=lacticinios_ovos&ver=tudo"
                  class="nav-link swiper-slide text-center"
                >
                  <img
                    src="images/ovos.jpg"
                    class="rounded-circle"
                    alt="Miniatura da Categoria"
                  />
                  <h4 class="fs-6 mt-3 fw-normal category-title">
                    Lacticínios e Ovos
                  </h4>
                </a>
                <a
                  href="comprar.php?tipo=categoria&slug=carnes_aves&ver=tudo"
                  class="nav-link swiper-slide text-center"
                >
                  <img
                    src="images/bife.jpg"
                    class="rounded-circle"
                    alt="Miniatura da Categoria"
                  />
                  <h4 class="fs-6 mt-3 fw-normal category-title">
                    Carnes e Aves
                  </h4>
                </a>
                <a
                  href="comprar.php?tipo=categoria&slug=peixe_marisco&ver=tudo"
                  class="nav-link swiper-slide text-center"
                >
                  <img
                    src="images/marisco.jpg"
                    class="rounded-circle"
                    alt="Miniatura da Categoria"
                  />
                  <h4 class="fs-6 mt-3 fw-normal category-title">
                    Peixe e Marisco
                  </h4>
                </a>
                <a
                  href="comprar.php?tipo=categoria&slug=padaria_pastelaria&ver=tudo"
                  class="nav-link swiper-slide text-center"
                >
                  <img
                    src="images/pastelaria.jpg"
                    class="rounded-circle"
                    alt="Miniatura da Categoria"
                  />
                  <h4 class="fs-6 mt-3 fw-normal category-title">
                    Pastelaria e Padaria
                  </h4>
                </a>
                <a
                  href="comprar.php?tipo=categoria&slug=conservas&ver=tudo"
                  class="nav-link swiper-slide text-center"
                >
                  <img
                    src="images/conservas.jpg"
                    class="rounded-circle"
                    alt="Miniatura da Categoria"
                  />
                  <h4 class="fs-6 mt-3 fw-normal category-title">Conservas</h4>
                </a>
                <a
                  href="comprar.php?tipo=categoria&slug=massa_arroz&ver=tudo"
                  class="nav-link swiper-slide text-center"
                >
                  <img
                    src="images/massa.jpeg"
                    class="rounded-circle"
                    alt="Miniatura da Categoria"
                  />
                  <h4 class="fs-6 mt-3 fw-normal category-title">
                    Massa e Arroz
                  </h4>
                </a>
                <a
                  href="comprar.php?tipo=categoria&slug=bebidas&ver=tudo"
                  class="nav-link swiper-slide text-center"
                >
                  <img
                    src="images/vinho.jpg"
                    class="rounded-circle"
                    alt="Miniatura da Categoria"
                  />
                  <h4 class="fs-6 mt-3 fw-normal category-title">Bebidas</h4>
                </a>
                <a
                  href="comprar.php?tipo=categoria&slug=especiarias_temperos&ver=tudo"
                  class="nav-link swiper-slide text-center"
                >
                  <img
                    src="images/especiarias.jpg"
                    class="rounded-circle"
                    alt="Miniatura da Categoria"
                  />
                  <h4 class="fs-6 mt-3 fw-normal category-title">
                    Especiarias e Temperos
                  </h4>
                </a>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- --------------------------------------------------------- -->

    <!-- Produtos mais vendidos -->
    <section class="pb-5">
      <div class="container-lg">
        <div class="row">
          <div class="col-md-12">
            <div class="section-header d-flex flex-wrap justify-content-between my-4">
              <h2 class="section-title">Produtos mais vendidos</h2>
              <div class="d-flex align-items-center">
                <a href="comprar.php?tipo=mais_vendidos&ver=tudo" class="btn btn-primary rounded-1">Ver Tudo</a>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div class="product-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-3 row-cols-xl-4 row-cols-xxl-5">
              <?php foreach ($maisVendidos as $p) { render_card_produto($p); } ?>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Artigos em promoção -->
    <section class="py-3">
      <div class="container-lg">
        <div class="row">
          <div class="col-md-12">
            <div class="banner-blocks">
              <div
                class="banner-ad d-flex align-items-center large bg-info block-1"
                style="
                  background: url('images/banner_artigos_promocao.jpg')
                    no-repeat;
                  background-size: cover;
                "
              >
                <div class="banner-content p-5">
                  <div class="content-wrapper text-light">
                    <h3 class="banner-title text-light">Artigos em Promoção</h3>
                    <p>Descontos até 30%</p>
                    <a
                      href="comprar.php?tipo=promocao"
                      class="btn-link text-white"
                      >Comprar Agora</a
                    >
                  </div>
                </div>
              </div>

              <div
                class="banner-ad bg-success-subtle block-2"
                style="
                  background: url('images/banner_ofertas_combo.jpg') no-repeat;
                  background-size: cover;
                "
              >
                <div class="banner-content align-items-center p-5">
                  <div class="content-wrapper text-light">
                    <h3 class="banner-title text-light">Ofertas Combo</h3>
                    <p>Descontos até 50%</p>
                    <a href="comprar.php?tipo=combo" class="btn-link text-white"
                      >Comprar Agora</a
                    >
                  </div>
                </div>
              </div>

              <div
                class="banner-ad bg-danger block-3"
                style="
                  background: url('images/banner_cupoes_desconto.jpg') no-repeat;
                  background-size: cover;
                "
              >
                <div class="banner-content align-items-center p-5">
                  <div class="content-wrapper text-light">
                    <h3 class="banner-title text-light">Cupões de Desconto</h3>
                    <p>Descontos até 40%</p>
                    <a href=pagina_default.html class="btn-link text-white">Comprar Agora</a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- --------------------------------------------------------- -->

    <?php if ($searchTerm !== ''): ?>
    <section id="resultados-pesquisa" class="py-5 bg-light">
      <div class="container-lg">
        <h2 class="section-title">
          Resultados da pesquisa para "<?= e($searchTerm) ?>"
        </h2>
        <?php if ($searchResults): ?>
          <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
            <?php foreach ($searchResults as $p): ?>
              <?php render_card_produto($p); ?>
            <?php endforeach; ?>
          </div>
        <?php else: ?>
          <p class="text-muted mb-0">
            Não foram encontrados produtos para esta pesquisa.
          </p>
        <?php endif; ?>
      </div>
    </section>
    <!-- --------------------------------------------------------- -->
<?php endif; ?>


    <!-- Produtos em destaque -->
    <section id="featured-products" class="products-carousel">
      <div class="container-lg">
        <div class="row">
          <div class="col-md-12">
            <div class="section-header d-flex flex-wrap justify-content-between my-4">
              <h2 class="section-title">Produtos em destaque</h2>
              <div class="d-flex align-items-center">
                <a href="comprar.php?tipo=destaque&ver=tudo" class="btn btn-primary rounded-1">Ver Tudo</a>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div class="product-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-3 row-cols-xl-4 row-cols-xxl-5">
              <?php foreach ($produtosDestaque as $p) { render_card_produto($p); } ?>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- --------------------------------------------------------- -->

    <!-- Obtenha 25% desconto -->
    <section>
      <div class="container-lg">
        <div
          class="bg-secondary text-light py-5 my-5"
          style="
            background: url('images/banner-newsletter.jpg') no-repeat;
            background-size: cover;
          "
        >
          <div class="container">
            <div class="row justify-content-center">
              <div class="col-md-5 p-3">
                <div class="section-header">
                  <h2 class="section-title display-5 text-light">
                    Obtenha 25% de Desconto na sua primeira compra
                  </h2>
                </div>
                <p>Basta Registar-se agora para se tornar membro.</p>
              </div>
              <div class="col-md-5 p-3">
                <form>
                  <div class="mb-3">
                    <label for="name" class="form-label d-none">Nome</label>
                    <input
                      type="text"
                      class="form-control form-control-md rounded-0"
                      name="name"
                      id="name"
                      placeholder="Nome"
                    />
                  </div>
                  <div class="mb-3">
                    <label for="email" class="form-label d-none">E-mail</label>
                    <input
                      type="email"
                      class="form-control form-control-md rounded-0"
                      name="email"
                      id="email"
                      placeholder="Endereço de E-mail"
                    />
                  </div>
                  <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-dark btn-md rounded-0">
                      Enviar
                    </button>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- --------------------------------------------------------- -->

    <!-- Produtos mais populares -->
    <section id="popular-products" class="products-carousel">
      <div class="container-lg">
        <div class="row">
          <div class="col-md-12">
            <div class="section-header d-flex flex-wrap justify-content-between my-4">
              <h2 class="section-title">Produtos mais populares</h2>
              <div class="d-flex align-items-center">
                <a href="comprar.php?tipo=populares&ver=tudo" class="btn btn-primary rounded-1">Ver Tudo</a>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div class="product-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-3 row-cols-xl-4 row-cols-xxl-5">
              <?php foreach ($maisPopulares as $p) { render_card_produto($p); } ?>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- --------------------------------------------------------- -->

    <!-- Recém-chegados -->
    <section id="latest-products" class="products-carousel">
      <div class="container-lg">
        <div class="row">
          <div class="col-md-12">
            <div class="section-header d-flex flex-wrap justify-content-between my-4">
              <h2 class="section-title">Recém-chegados</h2>
              <div class="d-flex align-items-center">
                <a href="comprar.php?tipo=recentes&ver=tudo" class="btn btn-primary rounded-1">Ver Tudo</a>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-md-12">
            <div class="product-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-3 row-cols-xl-4 row-cols-xxl-5">
              <?php foreach ($recemChegados as $p) { render_card_produto($p); } ?>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- --------------------------------------------------------- -->

    <!-- Descarregar aplicacao -->
    <section class="pb-4 my-4">
      <div class="container-lg">
        <div class="bg-warning pt-5 rounded-5">
          <div class="container">
            <div class="row justify-content-center align-items-center">
              <div class="col-md-4">
                <h2 class="mt-5">Descarregue a aplicação Orgânicos</h2>
                <p>Encomendas online de forma fácil, rápida e fiável</p>
                <div class="d-flex gap-2 flex-wrap mb-5">
                  <a
                    href="https://apps.apple.com/pt/iphone/apps"
                    title="App Store"
                    target="_blank"
                    rel="noopener noreferrer"
                    ><img src="images/app-store.png" alt="app-store"
                  /></a>
                  <a
                    href="https://play.google.com/store/apps"
                    title="Google Play"
                    target="_blank"
                    rel="noopener noreferrer"
                    ><img src="images/google-play.png" alt="google-play"
                  /></a>
                </div>
              </div>
              <div class="col-md-5">
                <img
                  src="images/banner-online_app.png"
                  alt="phone"
                  class="img-fluid"
                />
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- --------------------------------------------------------- -->

    <!-- Entrega gratuita / Pagamento seguros / Garantia de qualidade / Poupança garantida / Ofertas diárias -->
    <section class="py-5">
      <div class="container-lg">
        <div class="row row-cols-1 row-cols-sm-3 row-cols-lg-5">
          <div class="col">
            <div class="card mb-3 border border-dark-subtle p-3">
              <div class="text-dark mb-3">
                <svg width="32" height="32">
                  <use xlink:href="images/icons.svg#package"></use>
                </svg>
              </div>
              <div class="card-body p-0">
                <h5>Entrega Gratuita</h5>
                <p class="card-text">
                  Em compras superiores a 50€, oferecemos entrega gratuita num
                  raio de 30km.
                </p>
              </div>
            </div>
          </div>
          <div class="col">
            <div class="card mb-3 border border-dark-subtle p-3">
              <div class="text-dark mb-3">
                <svg width="32" height="32">
                  <use xlink:href="images/icons.svg#secure"></use>
                </svg>
              </div>
              <div class="card-body p-0">
                <h5>Pagamento 100% Seguro</h5>
                <p class="card-text">
                  Utilizamos as mais recentes tecnologias de encriptação para
                  garantir a segurança dos seus dados.
                </p>
              </div>
            </div>
          </div>
          <div class="col">
            <div class="card mb-3 border border-dark-subtle p-3">
              <div class="text-dark mb-3">
                <svg width="32" height="32">
                  <use xlink:href="images/icons.svg#quality"></use>
                </svg>
              </div>
              <div class="card-body p-0">
                <h5>Garantia de Qualidade</h5>
                <p class="card-text">
                  Todos os produtos são testados regularmente para garantir a
                  maior frescura, livre de pesticidas.
                </p>
              </div>
            </div>
          </div>
          <div class="col">
            <div class="card mb-3 border border-dark-subtle p-3">
              <div class="text-dark mb-3">
                <svg width="32" height="32">
                  <use xlink:href="images/icons.svg#savings"></use>
                </svg>
              </div>
              <div class="card-body p-0">
                <h5>Poupança Garantida</h5>
                <p class="card-text">
                  Produtos diretamente do produtor para o consumidor, evitando
                  intermediários e garantido preços mais acessíveis.
                </p>
              </div>
            </div>
          </div>
          <div class="col">
            <div class="card mb-3 border border-dark-subtle p-3">
              <div class="text-dark mb-3">
                <svg width="32" height="32">
                  <use xlink:href="images/icons.svg#offers"></use>
                </svg>
              </div>
              <div class="card-body p-0">
                <h5>Ofertas Diárias</h5>
                <p class="card-text">
                  Dezenas de produtos em promoção todos os dias para que possa
                  poupar ainda mais.
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <!-- --------------------------------------------------------- -->

    <!-- Rodapé -->
    <footer class="py-5">
      <div class="container-lg">
        <div class="row">
          <div class="col-lg-3 col-md-6 col-sm-6">
            <div class="footer-menu">
              <img src="images/logo.svg" width="240" height="70" alt="logo" />
              <div class="social-links mt-3">
                <ul class="d-flex list-unstyled gap-2">
                  <li>
                    <a
                      href="https://www.facebook.com/"
                      target="_blank"
                      rel="noopener noreferrer"
                      class="btn btn-outline-light"
                    >
                      <svg width="16" height="16">
                        <use xlink:href="images/icons.svg#facebook"></use>
                      </svg>
                    </a>
                  </li>
                  <li>
                    <a
                      href="https://x.com/"
                      target="_blank"
                      rel="noopener noreferrer"
                      class="btn btn-outline-light"
                    >
                      <svg width="16" height="16" aria-hidden="true">
                        <use
                          href="images/icons.svg?v=2#x-logo"
                          xlink:href="images/icons.svg?v=2#x-logo"
                        ></use>
                      </svg>
                    </a>
                  </li>
                  <li>
                    <a
                      href="https://www.youtube.com/"
                      target="_blank"
                      rel="noopener noreferrer"
                      class="btn btn-outline-light"
                    >
                      <svg width="16" height="16">
                        <use xlink:href="images/icons.svg#youtube"></use>
                      </svg>
                    </a>
                  </li>
                  <li>
                    <a
                      href="https://www.instagram.com/"
                      target="_blank"
                      rel="noopener noreferrer"
                      class="btn btn-outline-light"
                    >
                      <svg width="16" height="16">
                        <use xlink:href="images/icons.svg#instagram"></use>
                      </svg>
                    </a>
                  </li>
                  <li>
                    <a
                      href="https://www.amazon.com/"
                      target="_blank"
                      rel="noopener noreferrer"
                      class="btn btn-outline-light"
                    >
                      <svg width="16" height="16">
                        <use xlink:href="images/icons.svg#amazon"></use>
                      </svg>
                    </a>
                  </li>
                </ul>
              </div>
            </div>
          </div>

          <div class="col-md-2 col-sm-6">
            <div class="footer-menu">
              <h5 class="widget-title">Organic</h5>
              <ul class="menu-list list-unstyled">
                <li class="menu-item">
                  <a href=pagina_default.html class="nav-link">Sobre nós</a>
                </li>
                <li class="menu-item">
                  <a href=pagina_default.html class="nav-link">Condições</a>
                </li>
                <li class="menu-item">
                  <a href=pagina_default.html class="nav-link">Os Nossos Jornais</a>
                </li>
                <li class="menu-item">
                  <a href=pagina_default.html class="nav-link">Carreiras</a>
                </li>
                <li class="menu-item">
                  <a href=pagina_default.html class="nav-link">Programa de Afiliados</a>
                </li>
                <li class="menu-item">
                  <a href=pagina_default.html class="nav-link">Imprensa Ultras</a>
                </li>
              </ul>
            </div>
          </div>
          <div class="col-md-2 col-sm-6">
            <div class="footer-menu">
              <h5 class="widget-title">Links Rápidos</h5>
              <ul class="menu-list list-unstyled">
                <li class="menu-item">
                  <a href=pagina_default.html class="nav-link">Ofertas</a>
                </li>
                <li class="menu-item">
                  <a href=pagina_default.html class="nav-link">Cupões de Desconto</a>
                </li>
                <li class="menu-item">
                  <a href=pagina_default.html class="nav-link">Lojas</a>
                </li>
                <li class="menu-item">
                  <a href=pagina_default.html class="nav-link">Seguir Encomenda</a>
                </li>
                <li class="menu-item">
                  <a href=pagina_default.html class="nav-link">Loja</a>
                </li>
                <li class="menu-item">
                  <a href=pagina_default.html class="nav-link">Informações</a>
                </li>
              </ul>
            </div>
          </div>
          <div class="col-md-2 col-sm-6">
            <div class="footer-menu">
              <h5 class="widget-title">Apoio ao Cliente</h5>
              <ul class="menu-list list-unstyled">
                <li class="menu-item">
                  <a href=pagina_default.html class="nav-link">FAQ</a>
                </li>
                <li class="menu-item">
                  <a href=pagina_default.html class="nav-link">Contacto</a>
                </li>
                <li class="menu-item">
                  <a href=pagina_default.html class="nav-link">Política de Privacidade</a>
                </li>
                <li class="menu-item">
                  <a href=pagina_default.html class="nav-link">Devoluções e Reembolsos</a>
                </li>
                <li class="menu-item">
                  <a href=pagina_default.html class="nav-link">Política de Cookies</a>
                </li>
                <li class="menu-item">
                  <a href=pagina_default.html class="nav-link">Informações de Entrega</a>
                </li>
              </ul>
            </div>
          </div>
          <div class="col-lg-3 col-md-6 col-sm-6">
            <div class="footer-menu">
              <h5 class="widget-title">Subscreva-nos</h5>
              <p>
                Subscreva a nossa newsletter para receber atualizações sobre as
                nossas grandes ofertas.
              </p>
              <form class="d-flex mt-3 gap-0" action="homepage.php">
                <input
                  class="form-control rounded-start rounded-0 bg-light"
                  type="email"
                  placeholder="Endereço de Email"
                  aria-label="Endereço de Email"
                />
                <button
                  class="btn btn-dark rounded-end rounded-0"
                  type="submit"
                >
                  Subscrever
                </button>
              </form>
            </div>
          </div>
        </div>
      </div>
    </footer>
    <!-- --------------------------------------------------------- -->

    <!-- Rodapé do rodapé -->
    <div id="footer-bottom">
      <div class="container-lg">
        <div class="row">
          <div class="col-md-6 copyright">
            <p>© 2025 Orgânicos. Todos os direitos reservados.</p>
          </div>
        </div>
      </div>
    </div>
    <!-- --------------------------------------------------------- -->

    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
    <script src="js/homepage.js"></script>
  </body>
</html>
