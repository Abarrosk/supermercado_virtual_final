<?php

/*start_secure_session() configura a sessão com opções mais seguras (strict mode, HttpOnly, SameSite=Lax e Secure quando há HTTPS).
send_csp_headers() gera um nonce aleatório e constrói um cabeçalho Content Security Policy detalhado.
Limita script-src e style-src a self, ao nonce e a CDNs específicas (jsDelivr, jQuery, etc.).
Restringe imagens, fontes, ligações de rede e frame-ancestors, além de definir object-src 'none'.
Devolve o nonce para que possa ser usado nas tags <script> inline das páginas.
*/

function start_secure_session(): void {
  if (session_status() === PHP_SESSION_NONE) {
    ini_set('session.use_strict_mode', '1');
    ini_set('session.cookie_httponly', '1');
    ini_set('session.cookie_samesite', 'Lax');
    if (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') {
      ini_set('session.cookie_secure', '1');
    }
    session_start();
  }
}
function send_csp_headers(): string {
  $nonce = base64_encode(random_bytes(16));
  $script = "'self' 'nonce-{$nonce}' https://cdn.jsdelivr.net https://code.jquery.com";
  $img    = "'self' data: blob: https:";
  $style  = "'self' 'unsafe-inline' https://cdn.jsdelivr.net https://fonts.googleapis.com https://cdnjs.cloudflare.com https://unpkg.com";
  $font   = "'self' https://fonts.gstatic.com https://cdnjs.cloudflare.com https://unpkg.com data:";
  $connect= "'self'";
  $base   = "'self'";
  $framea = "'self'";
  $csp = "default-src 'self'; "
       . "script-src {$script}; "
       . "style-src {$style}; "
       . "img-src {$img}; "
       . "font-src {$font}; "
       . "connect-src {$connect}; "
       . "base-uri {$base}; "
       . "frame-ancestors {$framea}; "
       . "object-src 'none';";

  header("Content-Security-Policy: {$csp}");
  return $nonce;
}
