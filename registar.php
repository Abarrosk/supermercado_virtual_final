
<?php 

/*Inclui o bootstrap e inicializa variáveis de erro/mensagens para o processo de registo.
Define a função normaliza_nome() que formata nomes próprios com capitais correctas e trata partículas como “de”, “da”, “dos”, etc.
Em POST, valida CSRF, recolhe e valida campos (nome, apelido, email, telefone, password, confirmação, aceitação de termos, etc.).
Quando os dados são válidos, cria o utilizador na base de dados com password hash segura, e pode fazer login automático ou redireccionar.
Na parte de HTML/JS, inclui lógica para mostrar/ocultar password através de botões “olho”, ligada por wirePeek().
*/

require __DIR__ . '/config/bootstrap.php'; 
$erro = null;
$erros = [];
function normaliza_nome(string $s): string {
  $s = trim($s);
  if ($s === '') return '';
  $s = mb_convert_case(mb_strtolower($s, 'UTF-8'), MB_CASE_TITLE, 'UTF-8');
  $minusculas = ['De','Da','Do','Dos','Das','E'];
  $partes = preg_split('/\s+/', $s);
  foreach ($partes as $i => $p) {
    if ($i > 0 && in_array($p, $minusculas, true)) $partes[$i] = mb_strtolower($p, 'UTF-8');
  }
  return implode(' ', $partes);
}
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  csrf_verify($_POST['csrf'] ?? null);
  $dados = [
    'nome'     => normaliza_nome($_POST['nome'] ?? ''),
    'apelido'  => normaliza_nome($_POST['apelido'] ?? ''),
    'email'    => trim($_POST['email'] ?? ''),
    'password' => (string)($_POST['password'] ?? ''),
  ];
  foreach (['nome','apelido','email','password'] as $campo) {
    if ($dados[$campo] === '') { $erros[] = "O campo {$campo} é obrigatório."; }
  }
  if ($dados['email'] !== '' && !filter_var($dados['email'], FILTER_VALIDATE_EMAIL)) {
    $erros[] = 'E-mail inválido.';
  }
  if ($dados['password'] !== '') {
    if (strlen($dados['password']) < 8)                { $erros[] = 'A password deve ter pelo menos 8 caracteres.'; }
    if (!preg_match('/[A-Za-z]/', $dados['password'])) { $erros[] = 'A password deve ter pelo menos uma letra.'; }
    if (!preg_match('/\d/', $dados['password']))       { $erros[] = 'A password deve ter pelo menos um número.'; }
  }
  if (($_POST['password'] ?? '') !== ($_POST['password2'] ?? '')) {
    $erros[] = 'As passwords não coincidem.';
  }

  if (empty($erros)) {
    try {
      $id = Auth::register($dados);
      Auth::login($dados['email'], $dados['password']);
      header('Location: homepage.php');
      exit;
    } catch (Throwable $e) {
      $erro = $e->getMessage();
    }
  }
}
?>
<!DOCTYPE html>
<html lang="pt">
  <head>
    <meta charset="utf-8" />
    <title>Orgânicos - Loja de Produtos Naturais - Registar Utilizador</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="author" content="Andre Barros" />
    <meta name="robots" content="index, follow" />
    <meta
      name="keywords"
      content="Orgânicos, supermercado online, produtos naturais, frutas, legumes, lacticínios, 
        ovos, mercearias, carne, peixe, marisco, padaria, pastelaria, conservas, massa, 
        arroz, bebidas, especiarias, temperos, alimentação saudável registar"
    />
    <meta
      name="description"
      content="Compre online frutas, legumes, carne, peixe, padaria, 
        lacticínios e muito mais. Produtos orgânicos e frescos entregues em sua casa, em todo o país."
    />
    <link
      rel="canonical"
      href="http://localhost/projecto_final/registar.php"
    />
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"
      crossorigin="anonymous" referrerpolicy="no-referrer">
    <link rel="stylesheet" type="text/css" href="css/registar.css" />
  </head>
  <body>
    <a href="homepage.php" class="home-icon" aria-label="Ir para a homepage">
      <i class="fas fa-home"></i>
    </a>
    <section class="min-vh-100 d-flex align-items-center justify-content-center">
      <div class="container py-4">
        <div class="row justify-content-center">
          <div class="col-12 col-md-8 col-lg-6 col-xl-5">
            <div class="card glass-effect shadow-5">
              <div class="card-body p-5">
                <h2 class="fw-bold mb-4 text-center">Registe-se agora</h2>
                <?php if (!empty($erros)): ?>
                  <div class="alert alert-danger">
                    <ul class="mb-0">
                      <?php foreach ($erros as $e): ?>
                        <li><?= htmlspecialchars($e) ?></li>
                      <?php endforeach; ?>
                    </ul>
                  </div>
                <?php elseif (!empty($erro)): ?>
                  <div class="alert alert-danger"><?= htmlspecialchars($erro) ?></div>
                <?php endif; ?>
                <form method="post" action="registar.php" novalidate>
                  <?= csrf_field() ?>
                  <div class="row">
                    <div class="col-md-6 mb-3">
                      <label class="form-label" for="formNome">Nome</label>
                      <input
                        type="text"
                        id="formNome"
                        class="form-control"
                        name="nome"
                        value="<?= htmlspecialchars($dados['nome'] ?? '') ?>"
                        required
                      />
                    </div>
                    <div class="col-md-6 mb-3">
                      <label class="form-label" for="formApelido">Apelido</label>
                      <input
                        type="text"
                        id="formApelido"
                        class="form-control"
                        name="apelido"
                        value="<?= htmlspecialchars($dados['apelido'] ?? '') ?>"
                        required
                      />
                    </div>
                  </div>
                  <div class="mb-3">
                    <label class="form-label" for="formEmail">E-mail</label>
                    <input
                      type="email"
                      id="formEmail"
                      class="form-control"
                      name="email"
                      value="<?= htmlspecialchars($dados['email'] ?? '') ?>"
                      required
                    />
                  </div>
                  <div class="mb-3">
                    <label class="form-label" for="formPass">Palavra-passe</label>
                    <div class="position-relative">
                      <input
                        type="password"
                        id="formPass"
                        class="form-control pe-5"
                        name="password"
                        required
                        minlength="8"
                        autocomplete="new-password"
                      />
                      <button
                        type="button"
                        id="togglePass"
                        class="btn btn-link p-0 border-0 position-absolute top-50 end-0 translate-middle-y me-3"
                        aria-label="Mostrar/ocultar password">
                        <i class="fa-regular fa-eye" aria-hidden="true"></i>
                      </button>
                    </div>
                  </div>
                  <div class="mb-4">
                    <label class="form-label" for="formPass2">Confirmar palavra-passe</label>
                    <div class="position-relative">
                      <input
                        type="password"
                        id="formPass2"
                        class="form-control pe-5"
                        name="password2"
                        required
                        minlength="8"
                        autocomplete="new-password"
                      />
                      <button
                        type="button"
                        id="togglePass2"
                        class="btn btn-link p-0 border-0 position-absolute top-50 end-0 translate-middle-y me-3"
                        aria-label="Mostrar/ocultar password">
                        <i class="fa-regular fa-eye" aria-hidden="true"></i>
                      </button>
                    </div>
                  </div>
                  <button type="submit" class="btn btn-primary w-100 mt-2">Registar</button>
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>
    <script nonce="<?= htmlspecialchars($cspNonce) ?>">
      function wirePeek(btnId, inputId) {
        const btn = document.getElementById(btnId);
        const inp = document.getElementById(inputId);
        const ico = btn?.querySelector('i');
        if (!btn || !inp || !ico) return;
        const show = () => {
          inp.type = 'text';
          ico.classList.remove('fa-eye');
          ico.classList.add('fa-eye-slash');
        };
        const hide = () => {
          inp.type = 'password';
          ico.classList.remove('fa-eye-slash');
          ico.classList.add('fa-eye');
        };
        ['pointerdown','touchstart','mousedown'].forEach(ev => btn.addEventListener(ev, show));
        ['pointerup','pointercancel','touchend','touchcancel','mouseup','mouseleave','blur']
          .forEach(ev => btn.addEventListener(ev, hide));
        btn.addEventListener('keydown', e => {
          if (e.key === ' ' || e.key === 'Enter') { e.preventDefault(); show(); }
        });
        btn.addEventListener('keyup', hide);
      }
      wirePeek('togglePass',  'formPass');
      wirePeek('togglePass2', 'formPass2');
    </script>
  </body>
</html>
