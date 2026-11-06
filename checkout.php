
<?php

/*Garante que o utilizador está autenticado e que o carrinho não está vazio (senão redirecciona para comprar.php?tipo=random).
Inclui inc/orders.php e inc/shipping.php para criar a encomenda e tratar de portes no momento do checkout.
Em POST, valida CSRF, lê e valida dados de facturação (nome, email, telefone, morada, código postal, localidade, distrito, etc.).
Actualiza os dados do utilizador na tabela utilizadores com a morada introduzida e depois chama orders_create_from_cart() para gravar a encomenda.
Guarda o ID da encomenda em sessão, limpa o carrinho e apresenta um resumo/alerta de sucesso antes de redireccionar (controlado também por checkout.js)*/

require __DIR__ . '/config/bootstrap.php';
$userId = Auth::requireLogin();
$u      = Auth::userRow($userId);
if (!$u) {
  Auth::logout();
  header('Location: login.php');
  exit;
}
$cart = cart_get();
if (empty($cart)) {
  header('Location: comprar.php?tipo=random');
  exit;
}
require_once __DIR__ . '/inc/orders.php';
require_once __DIR__ . '/inc/shipping.php';
$erros          = [];
$orderCreatedId = null;
$agora            = new DateTimeImmutable('now');
$subtotal         = 0.0;
$desconto         = 0.0;
$produtosCarrinho = [];
foreach ($cart as $item) {
  $produto = product_by_id($item['id']);
  if (!$produto) {
    continue;
  }
  $produtosCarrinho[$item['id']] = $produto;
  $precoBase  = (float)$produto['preco'];
  $qty        = (int)$item['qty'];
   $stockDisponivel = (int)($produto['quantidade_em_stock'] ?? 0);

  if ($stockDisponivel <= 0) {
    $erros[] = 'O produto "' . ($produto['nome'] ?? 'Desconhecido') . '" está sem stock disponível.';
  } elseif ($qty > $stockDisponivel) {
    $erros[] = 'A quantidade pedida para "' . ($produto['nome'] ?? 'Desconhecido') .
               '" (' . $qty . ') é superior ao stock disponível (' . $stockDisponivel . ').';
  }
  $promoAtiva = ((int)$produto['promocao'] === 1)
    && (empty($produto['promocao_ate']) || new DateTimeImmutable($produto['promocao_ate']) >= $agora);
  $precoFinal = ($promoAtiva && $produto['preco_com_promocao'] !== null)
    ? (float)$produto['preco_com_promocao']
    : $precoBase;
  $subtotal += $precoBase * $qty;
  $descontoUnit = max(0.0, $precoBase - $precoFinal);
  $desconto    += $descontoUnit * $qty;
}
$destPartes = array_filter([
  $u['morada_linha1'] ?? '',
  $u['cod_postal']    ?? '',
  $u['localidade']    ?? '',
  $u['distrito']      ?? '',
  $u['pais']          ?? 'Portugal',
]);
$moradaCompletaActual = implode(', ', $destPartes);
$portes       = 0.0;
$distanciaKm  = null;
if ($moradaCompletaActual !== '') {
  try {
    $resPortes   = calcular_portes_para_morada($moradaCompletaActual);
    $portes      = (float)($resPortes['portes'] ?? 0.0);
    $distanciaKm = $resPortes['distancia_km'] ?? null;
  } catch (\Throwable $e) {
    $portes      = 0.0;
    $distanciaKm = null;
  }
}
$total = $subtotal - $desconto + $portes;
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  csrf_verify($_POST['csrf'] ?? null);
  $billingName    = trim($_POST['billing_name'] ?? '');
  $billingEmail   = trim($_POST['billing_email'] ?? '');
  $billingPhone   = trim($_POST['billing_phone'] ?? '');
  $billingBirthdate  = trim($_POST['billing_birthdate'] ?? '');
  $billingAddr1   = trim($_POST['billing_address1'] ?? '');
  $billingAddr2   = trim($_POST['billing_address2'] ?? '');
  $billingDist    = trim($_POST['billing_distrito'] ?? '');
  $billingLoc     = trim($_POST['billing_localidade'] ?? '');
  $billingZip     = trim($_POST['zip_code'] ?? '');
  if ($billingName === '')   { $erros[] = 'Preenche o nome.'; }
  if ($billingEmail === '')  { $erros[] = 'Preenche o email.'; }
  if ($billingPhone === '')  { $erros[] = 'Preenche o telefone.'; }
  if ($billingAddr1 === '')  { $erros[] = 'Preenche a morada (linha 1).'; }
  if ($billingDist === '')   { $erros[] = 'Preenche o distrito.'; }
  if ($billingLoc === '')    { $erros[] = 'Preenche a localidade.'; }
  if ($billingZip === '')    { $erros[] = 'Preenche o código postal.'; }
    if ($billingBirthdate === '') {
    $erros[] = 'Preenche a data de nascimento.';
  } else {
    try {
      $dob  = new DateTimeImmutable($billingBirthdate);
      $hoje = new DateTimeImmutable('today');
      if ($dob > $hoje) {
        $erros[] = 'Data de nascimento inválida.';
      } else {
        $idade = $dob->diff($hoje)->y;
        if ($idade < 18) {
          $erros[] = 'Tens de ter pelo menos 18 anos para concluir a compra.';
        }
      }
    } catch (Throwable $e) {
      $erros[] = 'Data de nascimento inválida.';
    }
  }
  if ($billingEmail !== '' && !filter_var($billingEmail, FILTER_VALIDATE_EMAIL)) {
    $erros[] = 'O email não é válido.';
  }
   if (!$erros) {
    $partesNome = preg_split('/\s+/', $billingName, 2);
    $nome       = $partesNome[0] ?? '';
    $apelido    = $partesNome[1] ?? '';
    $morada1    = $billingAddr1;
    $morada2    = $billingAddr2;
    $dataNascimentoDb = $billingBirthdate !== '' ? $billingBirthdate : null;

    $pdo  = db();
    $stmt = $pdo->prepare(
      'UPDATE utilizadores
         SET nome            = :nome,
             apelido         = :apelido,
             email           = :email,
             telefone        = :telefone,
             data_nascimento = :data_nascimento,
             morada_linha1   = :morada1,
             morada_linha2   = :morada2,
             cod_postal      = :cod_postal,
             localidade      = :localidade,
             distrito        = :distrito,
             pais            = :pais,
             updated_at      = NOW()
       WHERE id = :id'
    );
    $stmt->execute([
      ':nome'            => $nome,
      ':apelido'         => $apelido,
      ':email'           => $billingEmail,
      ':telefone'        => $billingPhone,
      ':data_nascimento' => $dataNascimentoDb,
      ':morada1'         => $morada1,
      ':morada2'         => $morada2,
      ':cod_postal'      => $billingZip,
      ':localidade'      => $billingLoc,
      ':distrito'        => $billingDist,
      ':pais'            => $u['pais'] ?? 'Portugal',
      ':id'              => $userId,
    ]);
    $u = Auth::userRow($userId);
    $destPartesPost = array_filter([
      $morada1,
      $billingZip,
      $billingLoc,
      $billingDist,
      $u['pais'] ?? 'Portugal',
    ]);
    $moradaCompletaPost = implode(', ', $destPartesPost);
    $portes      = 0.0;
    $distanciaKm = null;
    if ($moradaCompletaPost !== '') {
      try {
        $resPortes   = calcular_portes_para_morada($moradaCompletaPost);
        $portes      = (float)($resPortes['portes'] ?? 0.0);
        $distanciaKm = $resPortes['distancia_km'] ?? null;
      } catch (\Throwable $e) {
        $portes      = 0.0;
        $distanciaKm = null;
      }
    }
    $total = $subtotal - $desconto + $portes;
    $orderCreatedId = orders_create_from_cart(
      $userId,
      [
        'nome'             => $nome,
        'apelido'          => $apelido,
        'telefone'         => $billingPhone,
        'morada_linha1'    => $morada1,
        'morada_linha2'    => $morada2,
        'cod_postal'       => $billingZip,
        'localidade'       => $billingLoc,
        'distrito'         => $billingDist,
        'pais'             => $u['pais'] ?? 'Portugal',
      ],
      $cart,
      $subtotal,
      $desconto,
      $portes,
      $total
    );
    $_SESSION['checkout_order_id'] = $orderCreatedId;
    cart_clear();
  }
}
$orderId = $_SESSION['checkout_order_id'] ?? null;
?>
  <!DOCTYPE html>
    <html lang="pt">
    <head>
      <meta charset="utf-8" />
      <title>Orgânicos - Loja de Produtos Naturais - Checkout</title>
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <meta name="format-detection" content="telephone=no" />
      <meta name="apple-mobile-web-app-capable" content="yes" />
      <meta name="author" content="Andre Barros" />
      <meta name="robots" content="index, nofollow" />
      <meta name="keywords" content="Orgânicos, supermercado online, produtos naturais, frutas, legumes, lacticínios, 
        ovos, mercearias, carne, peixe, marisco, padaria, pastelaria, conservas, massa, 
        arroz, bebidas, especiarias, temperos, alimentação saudável checkout" />
      <meta name="description" content="Compre online frutas, legumes, carne, peixe, padaria, 
        lacticínios e muito mais. Produtos orgânicos e frescos entregues em sua casa, em todo o país." />
      <meta name="csrf-token" content="<?= e(csrf_token()) ?>">
      <link rel="canonical" href="http://localhost/projecto_final/checkout.php" />
      <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/css/bootstrap.min.css"
        rel="stylesheet"
      />
      <link
        rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/MaterialDesign-Webfont/5.3.45/css/materialdesignicons.css"
        integrity="sha256-NAxhqDvtY0l4xn+YVa6WjAcmd94NNfttjNsDmNatFVc="
        crossorigin="anonymous"
      />
      <link href="css/checkout.css" rel="stylesheet" type="text/css" />
      <link
        href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css"
        rel="stylesheet"
      />
    </head>
  <body>
    <div class="container">
      <?php if (!empty($erros)): ?>
        <div class="alert alert-danger mt-3">
          <ul class="mb-0">
            <?php foreach ($erros as $msg): ?>
              <li><?= e($msg) ?></li>
            <?php endforeach; ?>
          </ul>
        </div>
      <?php elseif (!empty($orderCreatedId)): ?>
        <div class="alert alert-success mt-3">
          Encomenda #<?= e((string)$orderCreatedId) ?> registada com sucesso.
        </div>
      <?php endif; ?>
      <div class="row">
        <div class="col-xl-8">
          <div class="card">
            <div class="card-body">
              <form method="post" action="checkout.php" id="checkout-form">
                <input type="hidden" name="csrf" value="<?= e(csrf_token()) ?>">
                <ol class="activity-checkout mb-0 px-4 mt-3">
                  <li class="checkout-item">
                    <div class="avatar checkout-icon p-1">
                      <div class="avatar-title rounded-circle bg-primary">
                        <i class="bx bxs-receipt text-white font-size-20"></i>
                      </div>
                    </div>
                    <div class="feed-item-list">
                      <div>
                        <h5 class="font-size-16 mb-1">Faturação e envio</h5>
                        <p class="text-muted text-truncate mb-4">
                          Utilize este formulário para confirmar ou alterar os seus dados de envio e faturação.
                        </p>
                        <div class="mb-3">
                          <div>
                            <div class="row">
                              <div class="col-lg-4">
                                <div class="mb-3">
                                  <label class="form-label" for="billing-name">Nome</label>
                                  <input
                                    type="text"
                                    class="form-control"
                                    id="billing-name"
                                    name="billing_name"
                                    placeholder="Nome do cliente"
                                    value="<?= e(($u['nome'] ?? '') . ' ' . ($u['apelido'] ?? '')) ?>"
                                  />
                                </div>
                              </div>
                              <div class="col-lg-4">
                                <div class="mb-3">
                                  <label class="form-label" for="billing-email-address">
                                    Endereço de email
                                  </label>
                                  <input
                                    type="email"
                                    class="form-control"
                                    id="billing-email-address"
                                    name="billing_email"
                                    placeholder="Endereço do cliente"
                                    value="<?= e($u['email'] ?? '') ?>"
                                  />
                                </div>
                              </div>
                              <div class="col-lg-4">
                                <div class="mb-3">
                                  <label class="form-label" for="billing-phone">Telefone</label>
                                  <input
                                    type="text"
                                    class="form-control"
                                    id="billing-phone"
                                    name="billing_phone"
                                    placeholder="Telefone do cliente"
                                    value="<?= e($u['telefone'] ?? '') ?>"
                                  />
                                </div>
                              </div>
                            </div>
                            <div class="row">
                              <div class="col-lg-4">
                                <div class="mb-3">
                                  <label class="form-label" for="billing-birthdate">Data de nascimento</label>
                                  <input
                                    type="date"
                                    class="form-control"
                                    id="billing-birthdate"
                                    name="billing_birthdate"
                                    value="<?= e($u['data_nascimento'] ?? '') ?>"
                                  />
                                </div>
                              </div>
                            </div>

                            <div class="row">
                              <div class="col-lg-6">
                                <div class="mb-3">
                                  <label class="form-label" for="billing-address1">Morada (linha 1)</label>
                                  <input
                                    type="text"
                                    class="form-control"
                                    id="billing-address1"
                                    name="billing_address1"
                                    placeholder="Arruamento, Avenida, Travessa, etc..."
                                    value="<?= e($u['morada_linha1'] ?? '') ?>"
                                  />
                                </div>
                              </div>
                              <div class="col-lg-6">
                                <div class="mb-3">
                                  <label class="form-label" for="billing-address2">Morada (linha 2)</label>
                                  <input
                                    type="text"
                                    class="form-control"
                                    id="billing-address2"
                                    name="billing_address2"
                                    placeholder="Número, Andar, Bloco, Apartamento, etc..."
                                    value="<?= e($u['morada_linha2'] ?? '') ?>"
                                  />
                                </div>
                              </div>
                            </div>
                            <div class="row">
                              <div class="col-lg-4">
                                <div class="mb-4 mb-lg-0">
                                  <label class="form-label" for="billing-distrito">Distrito</label>
                                  <input
                                    type="text"
                                    class="form-control"
                                    id="billing-distrito"
                                    name="billing_distrito"
                                    placeholder="Distrito do cliente"
                                    value="<?= e($u['distrito'] ?? '') ?>"
                                  />
                                </div>
                              </div>
                              <div class="col-lg-4">
                                <div class="mb-4 mb-lg-0">
                                  <label class="form-label" for="billing-localidade">Localidade</label>
                                  <input
                                    type="text"
                                    class="form-control"
                                    id="billing-localidade"
                                    name="billing_localidade"
                                    placeholder="Localidade do cliente"
                                    value="<?= e($u['localidade'] ?? '') ?>"
                                  />
                                </div>
                              </div>
                              <div class="col-lg-4">
                                <div class="mb-0">
                                  <label class="form-label" for="zip-code">Código Postal</label>
                                  <input
                                    type="text"
                                    class="form-control"
                                    id="zip-code"
                                    name="zip_code"
                                    placeholder="Código Postal do cliente"
                                    value="<?= e($u['cod_postal'] ?? '') ?>"
                                  />
                                </div>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </li>
                  <li class="checkout-item">
                    <div class="avatar checkout-icon p-1">
                      <div class="avatar-title rounded-circle bg-primary">
                        <i class="bx bxs-wallet-alt text-white font-size-20"></i>
                      </div>
                    </div>
                    <div class="feed-item-list">
                      <div>
                        <h5 class="font-size-16 mb-1">Informações de pagamento</h5>
                        <p class="text-muted text-truncate mb-4">
                          Escolhe o teu método de pagamento preferido.
                        </p>
                      </div>
                      <div>
                        <h5 class="font-size-14 mb-3">Método de pagamento :</h5>
                        <div class="row">
                          <div class="col-lg-3 col-sm-6">
                            <div data-bs-toggle="collapse">
                              <label class="card-radio-label">
                                <input
                                  type="radio"
                                  name="pay_method"
                                  id="pay-methodoption1"
                                  class="card-radio-input"
                                  value="cartao"
                                />
                                <span class="card-radio py-3 text-center text-truncate">
                                  <i class="bx bx-credit-card d-block h2 mb-3"></i>
                                  Cartão de Crédito
                                </span>
                              </label>
                            </div>
                          </div>
                          <div class="col-lg-3 col-sm-6">
                            <div>
                              <label class="card-radio-label">
                                <input
                                  type="radio"
                                  name="pay_method"
                                  id="pay-methodoption2"
                                  class="card-radio-input"
                                  value="paypal"
                                />
                                <span class="card-radio py-3 text-center text-truncate">
                                  <i class="bx bxl-paypal d-block h2 mb-3"></i>
                                  Paypal
                                </span>
                              </label>
                            </div>
                          </div>
                          <div class="col-lg-3 col-sm-6">
                            <div>
                              <label class="card-radio-label">
                                <input
                                  type="radio"
                                  name="pay_method"
                                  id="pay-methodoption3"
                                  class="card-radio-input"
                                  value="mbway"
                                  checked=""
                                />
                                <span class="card-radio py-3 text-center text-truncate">
                                  <span class="d-block h2 mb-3 mbway-logo">MBWay</span>
                                  <span>MBWay</span>
                                </span>
                              </label>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </li>
                </ol>
              </form>
            </div>
          </div>
          <div class="row my-4">
            <div class="col">
              <a href="comprar.php?tipo=random" class="btn btn-link text-muted">
                <i class="mdi mdi-arrow-left me-1"></i> Continuar a comprar
              </a>
            </div>
            <div class="col">
              <div class="text-end mt-2 mt-sm-0">
                <button
                  type="submit"
                  form="checkout-form"
                  class="btn btn-success"
                  id="btn-finalizar"
                >
                  <i class="mdi mdi-cart-outline me-1"></i> Finalizar compra
                </button>
              </div>
            </div>
          </div>
        </div>
        <div class="col-xl-4">
          <div class="card checkout-order-summary">
            <div class="card-body">
              <div class="p-3 bg-light mb-3">
                <h5 class="font-size-16 mb-0">
                  Resumo da compra
                  <span class="float-end ms-2">
                    <?= $orderId ? '#'.$orderId : '' ?>
                  </span>
                </h5>
              </div>
              <div class="table-responsive">
                <table class="table table-centered mb-0 table-nowrap">
                  <thead>
                    <tr>
                      <th class="border-top-0" style="width: 110px" scope="col">
                        Produto
                      </th>
                      <th class="border-top-0" scope="col">Descrição do produto</th>
                      <th class="border-top-0" scope="col">Preço</th>
                    </tr>
                  </thead>
                  <tbody>
                    <?php foreach ($cart as $item): ?>
                      <?php
                        $produto   = $produtosCarrinho[$item['id']] ?? null;
                        $img       = $item['imagem'] ?? ($produto['caminho_imagem'] ?? 'images/placeholder.jpg');
                        $descCurta = $produto['descricao_curta'] ?? '';
                        $qty       = (int)$item['qty'];

                        if ($produto) {
                          $precoBase  = (float)$produto['preco'];
                          $promoAtiva = ((int)$produto['promocao'] === 1)
                            && (empty($produto['promocao_ate']) || new DateTimeImmutable($produto['promocao_ate']) >= $agora);

                          $precoFinal = ($promoAtiva && $produto['preco_com_promocao'] !== null)
                            ? (float)$produto['preco_com_promocao']
                            : $precoBase;
                        } else {
                          $precoFinal = (float)$item['preco'];
                        }
                        $linha = $precoFinal * $qty;
                      ?>
                      <tr>
                        <th scope="row">
                          <img
                            src="<?= e($img) ?>"
                            alt="<?= e($item['nome']) ?>"
                            title="<?= e($item['nome']) ?>"
                            class="avatar-lg rounded"
                          />
                        </th>
                        <td>
                          <h5 class="font-size-16 text-truncate">
                            <a href="#" class="text-dark">
                              <?= e($item['nome']) ?>
                            </a>
                          </h5>
                          <p class="text-muted mb-0">
                            <?= e($descCurta) ?>
                          </p>
                          <p class="text-muted mb-0 mt-1">
                            <?= $qty ?> × <?= money($precoFinal) ?>€
                          </p>
                        </td>
                        <td>
                          <?= money($linha) ?>€
                          <button
                            type="button"
                            class="btn btn-link btn-sm text-danger ms-2 cart-remove"
                            data-id="<?= (int)$item['id'] ?>"
                            aria-label="Remover produto"
                          >
                            <i class="bx bx-trash"></i>
                          </button>
                        </td>
                      </tr>
                    <?php endforeach; ?>
                    <tr>
                      <td colspan="2">
                        <h5 class="font-size-14 m-0">Sub Total :</h5>
                      </td>
                      <td><span id="checkout-subtotal"><?= money($subtotal) ?>€</span></td>
                    </tr>
                    <tr>
                      <td colspan="2">
                        <h5 class="font-size-14 m-0">Desconto :</h5>
                      </td>
                      <td><span id="checkout-desconto"><?= money($desconto) ?>€</span></td>
                    </tr>
                    <tr>
                      <td colspan="2">
                        <h5 class="font-size-14 m-0">
                          Taxas de envio
                          <span
                            class="ms-1 shipping-tooltip"
                            data-bs-toggle="tooltip"
                            data-bs-placement="left"
                            title="Se a diferença entre as moradas for 30km ou menos, não paga taxas de envio. Se for superior, são 2€ por cada 5km adicionais."
                          >
                            <i class="bx bx-info-circle align-middle"></i>
                          </span>
                          :
                        </h5>
                      </td>
                      <td><span id="checkout-portes"><?= money($portes) ?>€</span></td>
                    </tr>
                    <tr class="bg-light">
                      <td colspan="2">
                        <h5 class="font-size-14 m-0">Total:</h5>
                      </td>
                      <td><span id="checkout-total"><?= money($total) ?>€</span></td>
                    </tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/checkout.js?v=3"<?php
      if (isset($cspNonce)) {
        echo ' nonce="'.e($cspNonce).'"';
      }
    ?>></script>
  </body>
</html>
