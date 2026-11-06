
<?php

/*Aceita apenas pedidos POST, respondendo 405 para outros métodos.
Limpa o carrinho de sessão através da função cart_clear().
Não usa JSON: apenas redirecciona o utilizador de volta para a página de origem (HTTP_REFERER) ou homepage.php.
É o “esvaziar carrinho” simples, sem lógica de cálculo adicional.
Usa o bootstrap para garantir sessão e funções auxiliares disponíveis.*/

require __DIR__ . '/../config/bootstrap.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
  http_response_code(405);
  exit('Método não permitido');
}

cart_clear();

$back = $_SERVER['HTTP_REFERER'] ?? '../homepage.php';
header('Location: ' . $back);
exit;
