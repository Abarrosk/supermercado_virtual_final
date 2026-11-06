
<?php

/*Inclui o bootstrap e render_card.php para apresentar produtos em formato de “card” reutilizável.
Se houver parâmetro q, entra em modo pesquisa e usa search_products_by_name() para obter todos os resultados.
Caso contrário, decide a origem dos produtos com base no tipo (categoria, mais_vendidos, destaque, populares, recentes, random) e no slug.
Controla o modo “Ver tudo” através de ver=tudo, definindo o limite de produtos ou mostrando apenas um conjunto reduzido.
Renderiza a página de listagem com navegação por categorias (links pré-montados) e cartões de produto com botão de adicionar ao carrinho.*/

require __DIR__ . '/config/bootstrap.php';
require_once __DIR__ . '/inc/render_card.php';

$searchTerm = trim($_GET['q'] ?? '');
$verTudo    = false;

if ($searchTerm !== '') {
  $produtos    = search_products_by_name($searchTerm, null);
  $tituloSecao = 'Resultados da pesquisa';
  $verTudo     = true;
} else {
  $tipo    = $_GET['tipo'] ?? null;
  $slug    = $_GET['slug'] ?? null;
  $verTudo = (($_GET['ver'] ?? '') === 'tudo');
  $limite  = $verTudo ? null : 7;

  if ($tipo === 'categoria' && $slug) {
    $produtos    = products_by_category_slug($slug, $limite);
    $tituloSecao = 'Produtos da categoria';
  } else {
    switch ($tipo) {
      case 'mais_vendidos':
        $produtos    = products_mais_vendidos($limite);
        $tituloSecao = 'Mais vendidos';
        break;
      case 'destaque':
        $produtos    = products_destaque($limite);
        $tituloSecao = 'Em destaque';
        break;
      case 'populares':
        $produtos    = products_populares($limite);
        $tituloSecao = 'Mais populares';
        break;
      case 'recentes':
        $produtos    = products_recentes($limite);
        $tituloSecao = 'Recém-chegados';
        break;
      case 'random':
      case 'todos':
        $produtos    = products_random($limite);
        $tituloSecao = $verTudo
          ? 'Todos os produtos (ordem aleatória)'
          : 'Sugestões para ti';
        break;
      default:
        $produtos    = products_random(7);
        $tituloSecao = 'Sugestões para ti';
    }
  }
}
?>
<!DOCTYPE html>
    <html lang="pt">
    <head>
      <meta charset="utf-8" />
      <title>Orgânicos - Loja de Produtos Naturais - Comprar Produtos</title>
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <meta name="format-detection" content="telephone=no" />
      <meta name="apple-mobile-web-app-capable" content="yes" />
      <meta name="author" content="Andre Barros" />
      <meta name="robots" content="index, follow" />
      <meta name="keywords" content="Orgânicos, supermercado online, produtos naturais, frutas, legumes, lacticínios, 
        ovos, mercearias, carne, peixe, marisco, padaria, pastelaria, conservas, massa, 
        arroz, bebidas, especiarias, temperos, alimentação saudável comprar" />
      <meta name="description" content="Compre online frutas, legumes, carne, peixe, padaria, 
        lacticínios e muito mais. Produtos orgânicos e frescos entregues em sua casa, em todo o país." />
      <link rel="canonical" href="http://localhost/projecto_final/comprar.php" />

      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" 
      rel="stylesheet" 
      integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ" 
      crossorigin="anonymous"/>
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css"/>
      <link rel="stylesheet" type="text/css" href="css/homepage.css" />
      <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&family=Open+Sans:ital,wght@0,400;0,700;1,400;1,700&display=swap" 
      rel="stylesheet"/>
  </head>
  <body>
    <div class="preloader-wrapper">
      <div class="preloader">
      </div>
    </div>
    <div
      class="offcanvas offcanvas-end"
      data-bs-scroll="true"
      tabindex="-1"
      id="offcanvasCart"
    >
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
    <header class="fixed-top bg-white">
      <div class="container-fluid">
        <div class="row py-3 border-bottom">
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
          <div class="col-sm-6 offset-sm-2 offset-md-0 col-lg-4">
              <div class="col-12 col-md-7">
                <form
  id="search-form"
  action="comprar.php#resultados-pesquisa"
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
    <section
      style="
        background-image: url('images/banner_homepage.jpg');
        background-repeat: no-repeat;
        background-size: cover;
      "
    >
      <div class="container-lg">
        <div class="row">
          <div class="col-lg-6 pt-5 mt-5">
            <h2 class="display-1 ls-1">
              <span class="fw-bold text-primary">Alimentos</span> Orgânicos à
              sua
              <span class="fw-bold">Porta</span>
            </h2>
            <p class="fs-4">Colhidos da horta diretamente para a sua casa.</p>
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
    <section id="resultados-pesquisa" class="py-5">
      <div class="container-lg">
        <div class="row">
          <div class="col-md-12">
            <div class="product-grid row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-3 row-cols-xl-4 row-cols-xxl-5">
              <?php foreach ($produtos as $p) { render_card_produto($p); } ?>
            </div>
            <?php if (!$verTudo): ?>
              <div class="text-center mt-4">
                <a class="btn btn-primary" href="comprar.php?<?= http_build_query(array_merge($_GET, ['ver'=>'tudo'])) ?>">
                  Ver tudo
                </a>
              </div>
            <?php endif; ?>
          </div>
        </div>
      </div>
    </section>
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
    <div id="footer-bottom">
      <div class="container-lg">
        <div class="row">
          <div class="col-md-6 copyright">
            <p>© 2025 Orgânicos. Todos os direitos reservados.</p>
          </div>
        </div>
      </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous"></script>
    <script src="js/homepage.js"></script>
  </body>
</html>
