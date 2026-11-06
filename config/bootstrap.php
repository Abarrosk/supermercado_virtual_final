<?php
declare(strict_types=1);

/*Liga o sistema de segurança (inc/security.php), envia cabeçalhos de Content Security Policy com nonce e inicia uma sessão.
Inclui os módulos centrais: db.php, csrf.php, auth.php, cart.php, products.php, search.php e shipping.php.
Adiciona cabeçalhos de segurança HTTP adicionais (X-Content-Type-Options, X-Frame-Options, Referrer-Policy).
Define helpers globais: e() para sair do HTML, money() para formatar valores em euros e date_pt() para formatar datas.
É o ponto de arranque comum que todas as páginas PHP usam para ter ambiente, sessão e utilitários configurados.*/

require_once __DIR__ . '/../inc/security.php';
$cspNonce = send_csp_headers();
start_secure_session();

require_once __DIR__ . '/../inc/db.php';
require_once __DIR__ . '/../inc/csrf.php';
require_once __DIR__ . '/../inc/auth.php';
require_once __DIR__ . '/../inc/cart.php';
require_once __DIR__ . '/../inc/products.php';
require_once __DIR__ . '/../inc/search.php';
require_once __DIR__ . '/../inc/shipping.php';

header('X-Content-Type-Options: nosniff');
header('X-Frame-Options: DENY');
header('Referrer-Policy: strict-origin-when-cross-origin');

if (!function_exists('e')) {
  function e(?string $s = ''): string {
    return htmlspecialchars($s ?? '', ENT_QUOTES, 'UTF-8');
  }
}
if (!function_exists('money')) {
  function money(float $n): string {
    return number_format($n, 2, ',', ' ');
  }
}
if (!function_exists('date_pt')) {
  function date_pt(?string $d): string {
    if (!$d) return '';
    $dt = new DateTime($d);
    return $dt->format('Y-m-d H:i');
  }
}
