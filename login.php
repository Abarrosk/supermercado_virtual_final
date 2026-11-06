
<?php

/*Carrega o bootstrap e, se já existir utilizador em sessão, redirecciona directamente para homepage.php.
Em POST, valida o token CSRF, lê email e password e chama Auth::login().
Em caso de sucesso, redirecciona para a homepage; em caso de falha, define a mensagem Credenciais inválidas..
Renderiza o formulário de login com campos para email e password, botão de submissão e o token CSRF.
Inclui js/login.js e usa uma imagem de fundo (images/login.jpg) na metade lateral da página para um layout mais apelativo.*/

require __DIR__ . '/config/bootstrap.php';
if (!empty($_SESSION['user'])) {
  header('Location: homepage.php');
  exit;
}
$erro = null;
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
  csrf_verify($_POST['csrf'] ?? null);
  $email = trim($_POST['email'] ?? '');
  $pass  = $_POST['password'] ?? '';
  if ($email !== '' && $pass !== '' && Auth::login($email, $pass)) {
    header('Location: homepage.php');
    exit;
  }
  $erro = 'Credenciais inválidas.';
}
?>
<!DOCTYPE html>
<html lang="pt">
    <head>
      <meta charset="utf-8" />
      <title>Orgânicos - Loja de Produtos Naturais - Login</title>
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <meta name="format-detection" content="telephone=no" />
      <meta name="apple-mobile-web-app-capable" content="yes" />
      <meta name="author" content="Andre Barros" />
      <meta name="robots" content="index, nofollow" />
      <meta name="keywords" content="Orgânicos, supermercado online, produtos naturais, frutas, legumes, lacticínios, 
        ovos, mercearias, carne, peixe, marisco, padaria, pastelaria, conservas, massa, 
        arroz, bebidas, especiarias, temperos, alimentação saudável login" />
      <meta name="description" content="Compre online frutas, legumes, carne, peixe, padaria, 
        lacticínios e muito mais. Produtos orgânicos e frescos entregues em sua casa, em todo o país." />
      <link rel="canonical" href="http://localhost/projecto_final/login.php" />
    <link rel="icon" type="image/png" href="images/icons/favicon.ico" />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
    />
    <link rel="stylesheet" type="text/css" href="css/login.css" />
  </head>
  <body style="background-color: #666666">
    <a href="homepage.php" class="home-icon">
      <i class="fas fa-home"></i>
    </a>
    <div class="limiter">
      <div class="container-login100">
        <div class="wrap-login100">
          <form class="login100-form validate-form" method="post" action="login.php">
            <?= csrf_field() ?>
            <span class="login100-form-title p-b-43">
              Faça login para continuar
            </span>
            <?php if (!empty($erro)): ?>
              <div class="alert alert-danger" role="alert"><?= htmlspecialchars($erro) ?></div>
            <?php endif; ?>
            <div id="recuperacao-msg" style="display:none;"></div>
            <div
              class="wrap-input100 validate-input"
              data-validate="É necessário um e-mail válido: ex@abc.xyz"
            >
              <input class="input100" type="email" name="email" />
              <span class="focus-input100"></span>
              <span class="label-input100">E-mail</span>
            </div>
            <div
              class="wrap-input100 validate-input"
              data-validate="É necessária a palavra-passe"
            >
              <input class="input100" type="password" name="password" />
              <span class="focus-input100"></span>
              <span class="label-input100">Palavra-passe</span>
            </div>
            <div class="flex-sb-m w-full p-t-3 p-b-32">
              <div>
                <a href="javascript:void(0)" class="txt1" id="link-esqueci">
                  Esqueci-me da password 
                </a>
              </div>
            </div>
            <div class="container-login100-form-btn">
              <button class="login100-form-btn" type="submit">Login</button>
            </div>
            <div class="text-center p-t-46 p-b-20">
              <a href="registar.php" class="txt2">Ou registre-se</a>
            </div>
          </form>
          <div
            class="login100-more"
            style="
              background-image: url('images/login.jpg');
              background-size: cover;
              background-position: center center;
              background-repeat: no-repeat;
            "
          ></div>
        </div>
      </div>
    </div>
    <script src="js/login.js?v=2"></script>
  </body>
</html>
