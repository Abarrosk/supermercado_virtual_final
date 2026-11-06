
<?php

/*Garante que o utilizador está autenticado e é administrador (is_admin = 1), caso contrário responde com 403.
Define helpers internos como parse_money_input() (para converter “18,50” em float) e funções para gerar e garantir uniformização de slugs de produtos.
Trata pedidos POST para acções administrativas: apagar utilizadores, apagar produtos e criar/actualizar produtos (com validações básicas).
Usa csrf_verify() em todas as acções e redirecciona de volta para a secção relevante (users, products, orders).
No HTML, carrega dinamicamente uma das secções (section_users.php, section_products.php, section_orders.php) consoante o parâmetro sec.*/

require __DIR__ . '/config/bootstrap.php';

$userId = Auth::requireLogin();
$user   = Auth::userRow($userId);

if (!$user || (int)($user['is_admin'] ?? 0) !== 1) {
  http_response_code(403);
  exit('Acesso reservado a administradores.');
}

$sec = $_GET['sec'] ?? 'home';

if (!function_exists('parse_money_input')) {
  function parse_money_input(string $s): float {
    $s = str_replace(["\xc2\xa0", ' '], '', $s);
    $s = str_replace(',', '.', $s);
    return (float)$s;
  }
}

if (!function_exists('gerar_slug_basico')) {
  function gerar_slug_basico(string $texto): string {
    $t = iconv('UTF-8', 'ASCII//TRANSLIT//IGNORE', $texto);
    $t = preg_replace('/[^a-zA-Z0-9]+/', '-', $t);
    $t = trim($t, '-');
    $t = strtolower($t);
    if ($t === '') {
      $t = 'produto';
    }
    return $t;
  }
}

if (!function_exists('gerar_slug_produto_unico')) {
  function gerar_slug_produto_unico(string $nome, ?int $idAtual = null): string {
    $base = gerar_slug_basico($nome);
    $slug = $base;
    $pdo  = db();
    $i    = 1;

    while (true) {
      if ($idAtual) {
        $stmt = $pdo->prepare('SELECT id FROM produtos WHERE slug = ? AND id <> ? LIMIT 1');
        $stmt->execute([$slug, $idAtual]);
      } else {
        $stmt = $pdo->prepare('SELECT id FROM produtos WHERE slug = ? LIMIT 1');
        $stmt->execute([$slug]);
      }

      if (!$stmt->fetchColumn()) {
        return $slug;
      }

      $slug = $base . '-' . $i;
      $i++;
    }
  }
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  $action = $_POST['do'] ?? '';

  csrf_verify($_POST['csrf'] ?? null);

  if ($action === 'delete_user') {
  $id = (int)($_POST['id'] ?? 0);

  if ($id > 0 && $id !== (int)$userId) {
    $stmt = db()->prepare('UPDATE utilizadores SET is_deleted = 1 WHERE id = ? AND is_admin = 0');
    $stmt->execute([$id]);
  }

  header('Location: admin_dashboard.php?sec=users');
  exit;
}

  if ($action === 'delete_product') {
    $id = (int)($_POST['id'] ?? 0);

    if ($id > 0) {
      $stmt = db()->prepare('SELECT COUNT(*) FROM encomendas_itens WHERE produto_id = ?');
      $stmt->execute([$id]);
      $usos = (int)$stmt->fetchColumn();

      if ($usos === 0) {
        $del = db()->prepare('DELETE FROM produtos WHERE id = ?');
        $del->execute([$id]);
      }
    }

    header('Location: admin_dashboard.php?sec=products');
    exit;
  }

  if ($action === 'save_product') {
    $id                   = (int)($_POST['id'] ?? 0);
    $nome                 = trim($_POST['nome'] ?? '');
    $slug                 = trim($_POST['slug'] ?? '');
    $categoria_id         = (int)($_POST['categoria_id'] ?? 0);
    $descricao_curta      = trim($_POST['descricao_curta'] ?? '');
    $descricao_detalhada  = trim($_POST['descricao_detalhada'] ?? '');
    $precoStr             = trim($_POST['preco'] ?? '0');
    $preco                = parse_money_input($precoStr);
    $tipo_venda           = $_POST['tipo_venda'] ?? 'unidade';
    $temPromocao          = !empty($_POST['promocao']);
    $valorPromoStr        = trim($_POST['valor_promocao'] ?? '');
    $valorPromo           = $valorPromoStr !== '' ? parse_money_input($valorPromoStr) : 0.0;
    $promoAteRaw          = trim($_POST['promocao_ate'] ?? '');
    $quantidade_em_stock  = (int)($_POST['quantidade_em_stock'] ?? 0);
    $caminho_imagem       = trim($_POST['caminho_imagem'] ?? '');

    if (
      $nome === '' ||
      $categoria_id <= 0 ||
      $descricao_curta === '' ||
      $descricao_detalhada === '' ||
      $preco <= 0 ||
      $tipo_venda === '' ||
      $quantidade_em_stock < 0
    ) {
      header('Location: admin_dashboard.php?sec=products');
      exit;
    }

    if ($temPromocao) {
      if ($valorPromoStr === '' || $promoAteRaw === '') {
        header('Location: admin_dashboard.php?sec=products');
        exit;
      }
    }

    if ($slug === '') {
      $slug = gerar_slug_produto_unico($nome, $id > 0 ? $id : null);
    }

    $ficheiroImagem = $_FILES['imagem_ficheiro'] ?? null;

    if ($id === 0) {
      if (
        !$ficheiroImagem ||
        !is_array($ficheiroImagem) ||
        $ficheiroImagem['error'] !== UPLOAD_ERR_OK
      ) {
        header('Location: admin_dashboard.php?sec=products');
        exit;
      }
    }

    if (
      $ficheiroImagem &&
      is_array($ficheiroImagem) &&
      $ficheiroImagem['error'] === UPLOAD_ERR_OK
    ) {
      $nomeOriginal = $ficheiroImagem['name'];
      $tmpName      = $ficheiroImagem['tmp_name'];

      $stmtCat = db()->prepare('SELECT slug FROM categorias WHERE id = ?');
      $stmtCat->execute([$categoria_id]);
      $catSlug = $stmtCat->fetchColumn();

      if (!$catSlug) {
        $catSlug = 'outros';
      }

      $pastaRelativa = 'images/' . $catSlug . '/';
      $pastaFS       = __DIR__ . '/' . $pastaRelativa;

      if (!is_dir($pastaFS)) {
        @mkdir($pastaFS, 0777, true);
      }

      $nomeLimpo = preg_replace('/[^a-zA-Z0-9._-]/', '_', $nomeOriginal);
      if ($nomeLimpo === '') {
        $nomeLimpo = 'imagem_produto_' . time() . '.jpg';
      }

      $destinoFS   = $pastaFS . $nomeLimpo;
      $destinoRel  = $pastaRelativa . $nomeLimpo;

      if (move_uploaded_file($tmpName, $destinoFS)) {
        $caminho_imagem = $destinoRel;
      }
    } else {
      if ($id > 0) {
        $stmtImg = db()->prepare('SELECT caminho_imagem FROM produtos WHERE id = ?');
        $stmtImg->execute([$id]);
        $actual = $stmtImg->fetchColumn();
        if ($actual) {
          $caminho_imagem = $actual;
        }
      }
    }

    if ($id === 0 && $caminho_imagem === '') {
      header('Location: admin_dashboard.php?sec=products');
      exit;
    }

    $promocao            = 0;
    $promocao_ate        = null;
    $valor_promocao      = null;
    $preco_com_promocao  = null;

    if ($temPromocao && $valorPromo > 0) {
      $promocao       = 1;
      $valor_promocao = $valorPromo;

      if ($promoAteRaw !== '') {
        $dt = DateTime::createFromFormat('Y-m-d\TH:i', $promoAteRaw);
        if ($dt !== false) {
          $promocao_ate = $dt->format('Y-m-d H:i:s');
        }
      }

      $preco_com_promocao = round($preco * (1 - $valorPromo / 100), 2);
    }

    if ($id > 0) {
      $sql = "UPDATE produtos
                 SET nome = ?,
                     slug = ?,
                     categoria_id = ?,
                     descricao_curta = ?,
                     descricao_detalhada = ?,
                     preco = ?,
                     tipo_venda = ?,
                     promocao = ?,
                     promocao_ate = ?,
                     valor_promocao = ?,
                     preco_com_promocao = ?,
                     quantidade_em_stock = ?,
                     caminho_imagem = ?
               WHERE id = ?";
      $stmt = db()->prepare($sql);
      $stmt->execute([
        $nome,
        $slug,
        $categoria_id,
        $descricao_curta !== '' ? $descricao_curta : null,
        $descricao_detalhada !== '' ? $descricao_detalhada : null,
        $preco,
        $tipo_venda,
        $promocao,
        $promocao_ate,
        $valor_promocao,
        $preco_com_promocao,
        $quantidade_em_stock,
        $caminho_imagem !== '' ? $caminho_imagem : null,
        $id,
      ]);
    } else {
      $sql = "INSERT INTO produtos
                (nome, slug, categoria_id, descricao_curta, descricao_detalhada,
                 preco, tipo_venda, promocao, promocao_ate,
                 valor_promocao, preco_com_promocao, quantidade_em_stock, caminho_imagem)
              VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";
      $stmt = db()->prepare($sql);
      $stmt->execute([
        $nome,
        $slug,
        $categoria_id,
        $descricao_curta !== '' ? $descricao_curta : null,
        $descricao_detalhada !== '' ? $descricao_detalhada : null,
        $preco,
        $tipo_venda,
        $promocao,
        $promocao_ate,
        $valor_promocao,
        $preco_com_promocao,
        $quantidade_em_stock,
        $caminho_imagem !== '' ? $caminho_imagem : null,
      ]);
    }

    header('Location: admin_dashboard.php?sec=products');
    exit;
  }
}
?>
<!DOCTYPE html>
<html lang="pt">
  <head>
    <meta charset="utf-8" />
    <title>Orgânicos - Loja de Produtos Naturais - Página de Gestão da Plataforma</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="author" content="Andre Barros" />
    <meta name="robots" content="index, nofollow" />
    <meta name="keywords" content="Orgânicos, supermercado online, produtos naturais, frutas, legumes, lacticínios, 
      ovos, mercearias, carne, peixe, marisco, padaria, pastelaria, conservas, massa, 
      arroz, bebidas, especiarias, temperos, alimentação saudável fwstão da plataforma" />
    <meta name="description" content="Compre online frutas, legumes, carne, peixe, padaria, 
      lacticínios e muito mais. Produtos orgânicos e frescos entregues em sua casa, em todo o país." />
    <link rel="canonical" href="http://localhost/projecto_final/admin_dashboard.php" />
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
    <link rel="stylesheet" href="css/admin_dashboard.css" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
    />
  </head>
  <body>
    <a href="homepage.php" class="home-icon">
      <i class="fas fa-home"></i>
    </a>

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
    <div class="admin-dashboard-page">
      <header class="bg-white">
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
          </div>
        </div>
      </header>

      <main class="admin-dashboard-container l-bg-orange-dark">
        <?php if ($sec === 'home'): ?>
          <div class="container py-5">
            <div class="row g-4 justify-content-center">
              <div class="col-xl-6 col-lg-6">
                <a
                  href="admin_dashboard.php?sec=users"
                  class="text-decoration-none text-reset"
                >
                  <div class="card l-bg-cherry">
                    <div class="card-statistic-3 p-4">
                      <div class="mb-4">
                        <h5 class="card-title mb-0 text-center">
                          Editar Utilizadores
                        </h5>
                      </div>
                    </div>
                  </div>
                </a>
              </div>
              <div class="col-xl-6 col-lg-6">
                <a
                  href="admin_dashboard.php?sec=products"
                  class="text-decoration-none text-reset"
                >
                  <div class="card l-bg-blue-dark">
                    <div class="card-statistic-3 p-4">
                      <div class="mb-4">
                        <h5 class="card-title mb-0 text-center">
                          Editar Produtos
                        </h5>
                      </div>
                    </div>
                  </div>
                </a>
              </div>
              <div class="col-xl-6 col-lg-6">
                <a
                  href="admin_dashboard.php?sec=orders"
                  class="text-decoration-none text-reset"
                >
                  <div class="card l-bg-green-dark">
                    <div class="card-statistic-3 p-4">
                      <div class="mb-4">
                        <h5 class="card-title mb-0 text-center">
                          Editar Encomendas
                        </h5>
                      </div>
                    </div>
                  </div>
                </a>
              </div>
            </div>
          </div>

        <?php elseif ($sec === 'users'): ?>
          <div class="container py-4">
            <?php require __DIR__ . '/admin/section_users.php'; ?>
          </div>

        <?php elseif ($sec === 'products'): ?>
          <div class="container py-4">
            <?php require __DIR__ . '/admin/section_products.php'; ?>
          </div>

        <?php elseif ($sec === 'orders'): ?>
          <div class="container py-4">
            <?php require __DIR__ . '/admin/section_orders.php'; ?>
          </div>
        <?php endif; ?>
      </main>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
      crossorigin="anonymous"
    ></script>
  </body>
</html>
