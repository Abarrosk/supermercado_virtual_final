
<?php

/*Recebe pedidos POST e valida o token CSRF (corpo ou header) antes de prosseguir.
Verifica o produto_id; se for inválido responde 400 com JSON { ok: false, erro: 'Produto inválido.' }.
Remove o produto do carrinho com cart_remove() e recalcula subtotal, desconto e total com base nas promoções activas.
Devolve em JSON os novos totais (bruto, desconto, portes e total) tanto em número como formatados (money() . '€').
Indica também se o carrinho ficou vazio (cart_vazio) para permitir ao front-end reagir (por exemplo, esconder a tabela).*/

require __DIR__ . '/../config/bootstrap.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
  http_response_code(405);
  exit('Método não permitido');
}

$token = $_POST['csrf'] ?? ($_SERVER['HTTP_X_CSRF_TOKEN'] ?? '');
csrf_verify($token);

$produtoId = (int)($_POST['produto_id'] ?? 0);
if ($produtoId < 1) {
  http_response_code(400);
  header('Content-Type: application/json');
  echo json_encode([
    'ok'   => false,
    'erro' => 'Produto inválido.',
  ]);
  exit;
}
$cart = cart_remove($produtoId);

$agora    = new DateTimeImmutable('now');
$subtotal = 0.0;
$desconto = 0.0;
$portes   = 0.0;

foreach ($cart as $item) {
  $produto = product_by_id($item['id']);
  if (!$produto) {
    continue;
  }

  $precoBase  = (float)$produto['preco'];
  $qty        = (int)$item['qty'];

  $promoAtiva = ((int)$produto['promocao'] === 1)
    && (empty($produto['promocao_ate']) || new DateTimeImmutable($produto['promocao_ate']) >= $agora);

  $precoFinal = ($promoAtiva && $produto['preco_com_promocao'] !== null)
    ? (float)$produto['preco_com_promocao']
    : $precoBase;

  $subtotal += $precoBase * $qty;

  $descontoUnit = max(0.0, $precoBase - $precoFinal);
  $desconto    += $descontoUnit * $qty;
}

$total = $subtotal - $desconto + $portes;

header('Content-Type: application/json');
echo json_encode([
  'ok'                 => true,
  'cart_vazio'         => empty($cart),
  'subtotal'           => $subtotal,
  'subtotal_formatado' => money($subtotal) . '€',
  'desconto'           => $desconto,
  'desconto_formatado' => money($desconto) . '€',
  'portes'             => $portes,
  'portes_formatado'   => money($portes) . '€',
  'total'              => $total,
  'total_formatado'    => money($total) . '€',
]);
exit;
