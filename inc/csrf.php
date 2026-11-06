
<?php

/*Gera um token CSRF aleatório por sessão (csrf_token()), com 32 bytes convertidos em hex.
Disponibiliza um helper csrf_field() para inserir um <input type="hidden" name="csrf" ...> nos formulários HTML.
csrf_verify() valida o token recebido, comparando com o valor em sessão através de hash_equals() para evitar timing attacks.
Em caso de falha, responde com HTTP 419 e termina imediatamente a execução.
É usado tanto em formulários normais como em pedidos AJAX (via header X-CSRF-Token).*/

function csrf_token(): string {
  if (empty($_SESSION['csrf'])) {
    $_SESSION['csrf'] = bin2hex(random_bytes(32));
  }
  return $_SESSION['csrf'];
}
function csrf_field(): string {
  return '<input type="hidden" name="csrf" value="'.htmlspecialchars(csrf_token(), ENT_QUOTES).'">';
}
function csrf_verify(?string $token): void {
  if (!$token || !hash_equals($_SESSION['csrf'] ?? '', $token)) {
    http_response_code(419);
    exit('CSRF inválido.');
  }
}
