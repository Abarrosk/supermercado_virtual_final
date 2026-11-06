

<?php

/*Inclui o bootstrap da aplicação e aceita apenas pedidos POST (senão responde 405).
Valida o token CSRF recebido no corpo do pedido ou no header X-CSRF-Token.
Lê produto_id e quantidade, chama cart_add() para adicionar ao carrinho em sessão.
Se o pedido for AJAX (XMLHttpRequest), responde em JSON com os itens do carrinho e o total de itens.
Caso contrário, adiciona uma flash message de sucesso em sessão e redirecciona para a página anterior ou para comprar.php.*/

require __DIR__ . '/../config/bootstrap.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') { http_response_code(405); exit; }

$token = $_POST['csrf'] ?? ($_SERVER['HTTP_X_CSRF_TOKEN'] ?? '');
csrf_verify($token);

$produtoId = (int)($_POST['produto_id'] ?? 0);
$qty       = (int)($_POST['quantidade'] ?? 1);

$cart = cart_add($produtoId, $qty);

$isAjax = (isset($_SERVER['HTTP_X_REQUESTED_WITH']) && strtolower($_SERVER['HTTP_X_REQUESTED_WITH']) === 'xmlhttprequest');

if ($isAjax) {
  header('Content-Type: application/json');
  echo json_encode([
    'ok' => true,
    'items' => array_values($cart),
    'total_itens' => array_sum(array_column($cart, 'qty')),
  ]);
  exit;
}

$_SESSION['flash'][] = ['tipo' => 'success', 'msg' => 'Produto adicionado ao carrinho.'];
$back = $_SERVER['HTTP_REFERER'] ?? '../comprar.php';
header('Location: ' . $back);
exit;
