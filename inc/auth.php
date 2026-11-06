<?php

/*Define a classe Auth responsável pelo login, logout, registo, acesso ao utilizador actual e alteração de password.
No login, aplica rate limiting (bloqueio após várias tentativas falhadas) e usa password_verify() sobre hashes seguros (Argon2id ou bcrypt).
requireLogin() força autenticação, redireccionando para login.php se não houver utilizador em sessão, e userRow() vai buscar os dados completos do utilizador.
Inclui um método de registo (registerUser, ou equivalente) que cria utilizadores na base de dados com password_hash() e timestamps.
Implementa política de password e mudança de password com nova hash, session_regenerate_id() e rate limiting específico para essa operação.*/

class Auth {
  public static function login(string $email, string $password): bool {
    self::rateLimitGate('login', 5, 600);
    $stmt = db()->prepare('SELECT id, password, is_admin, nome, apelido FROM utilizadores WHERE email = ? LIMIT 1');
    $stmt->execute([$email]);
    $u = $stmt->fetch();
    if ($u && password_verify($password, $u['password'])) {
      session_regenerate_id(true);
      $_SESSION['user'] = [
        'id' => (int)$u['id'],
        'nome' => $u['nome'],
        'apelido' => $u['apelido'],
        'is_admin' => (int)$u['is_admin'],
      ];
      self::rateLimitClear('login');
      return true;
    }
    self::rateLimitBump('login');
    return false;
  }
  public static function logout(): void {
    $_SESSION = [];
    if (ini_get('session.use_cookies')) {
      $params = session_get_cookie_params();
      setcookie(session_name(), '', time() - 42000, $params['path'], $params['domain'], $params['secure'], $params['httponly']);
    }
    session_destroy();
  }
  private static function rateLimitGate(string $key, int $max, int $windowSeconds): void {
    $now = time();
    $_SESSION['rl'][$key] = array_filter($_SESSION['rl'][$key] ?? [], fn($t) => $t > $now - $windowSeconds);
    if (count($_SESSION['rl'][$key]) >= $max) {
      http_response_code(429);
      exit('Demasiadas tentativas. Tenta mais tarde.');
    }
  }
  private static function rateLimitBump(string $key): void {
    $_SESSION['rl'][$key][] = time();
  }
  private static function rateLimitClear(string $key): void {
    unset($_SESSION['rl'][$key]);
  }
  public static function register(array $dados): int {
    $nome    = trim($dados['nome']    ?? '');
    $apelido = trim($dados['apelido'] ?? '');
    $email   = trim(mb_strtolower($dados['email'] ?? ''));
    $pass    = (string)($dados['password'] ?? '');
    if ($nome === '' || $apelido === '' || $email === '' || $pass === '') {
      throw new InvalidArgumentException('Faltam campos obrigatórios.');
    }
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
      throw new InvalidArgumentException('E-mail inválido.');
    }
    $st = db()->prepare('SELECT 1 FROM utilizadores WHERE email = ? LIMIT 1');
    $st->execute([$email]);
    if ($st->fetch()) {
      throw new RuntimeException('Esse e-mail já está registado.');
    }
    $alg  = defined('PASSWORD_ARGON2ID') ? PASSWORD_ARGON2ID : PASSWORD_DEFAULT;
    $opts = ($alg === PASSWORD_DEFAULT)
      ? ['cost' => 12]
      : ['memory_cost' => 1<<17, 'time_cost' => 4, 'threads' => 2];
    $hash = password_hash($pass, $alg, $opts);
    $ins = db()->prepare('INSERT INTO utilizadores (nome, apelido, email, password, created_at) VALUES (?, ?, ?, ?, NOW())');
    $ins->execute([$nome, $apelido, $email, $hash]);
    return (int) db()->lastInsertId();
  }
  public static function currentUser(): ?array {
    return $_SESSION['user'] ?? null;
  }
  public static function requireLogin(): int {
    if (empty($_SESSION['user']['id'])) {
      header('Location: login.php');
      exit;
    }
    return (int) $_SESSION['user']['id'];
  }
  public static function userRow(int $id): ?array {
  $st = db()->prepare('
      SELECT id,
             nome,
             apelido,
             telefone,
             data_nascimento,
             morada_linha1,
             morada_linha2,
             cod_postal,
             localidade,
             distrito,
             pais,
             email,
             is_admin
      FROM utilizadores
      WHERE id = ?
      LIMIT 1
  ');
  $st->execute([$id]);
  $row = $st->fetch();
  return $row ?: null;
}

private static function assertPasswordPolicy(string $pass): void {
  if (strlen($pass) < 8) throw new InvalidArgumentException('A password deve ter pelo menos 8 caracteres.');
  if (!preg_match('/[A-Za-z]/', $pass)) throw new InvalidArgumentException('A password deve ter pelo menos uma letra.');
  if (!preg_match('/\d/', $pass)) throw new InvalidArgumentException('A password deve ter pelo menos um número.');
}
public static function changePassword(int $userId, string $current, string $new): void {
  self::rateLimitGate('chpass', 5, 600);
  $st = db()->prepare('SELECT password FROM utilizadores WHERE id = ? LIMIT 1');
  $st->execute([$userId]);
  $row = $st->fetch();
  if (!$row || !password_verify($current, $row['password'])) {
    self::rateLimitBump('chpass');
    throw new RuntimeException('A password atual está incorreta.');
  }
  self::assertPasswordPolicy($new);
  $alg  = defined('PASSWORD_ARGON2ID') ? PASSWORD_ARGON2ID : PASSWORD_DEFAULT;
  $opts = ($alg === PASSWORD_DEFAULT) ? ['cost' => 12] : ['memory_cost' => 1<<17, 'time_cost' => 4, 'threads' => 2];
  $hash = password_hash($new, $alg, $opts);
  $up = db()->prepare('UPDATE utilizadores SET password = ?, updated_at = NOW() WHERE id = ?');
  $up->execute([$hash, $userId]);
  session_regenerate_id(true);
  self::rateLimitClear('chpass');
}
}
