
<?php

/*Exige login com Auth::requireLogin() e carrega os dados actuais do utilizador com Auth::userRow().
Suporta acções distintas: actualizar perfil (nome, apelido, email, telefone, morada, país, etc.) e alterar password.
Valida os dados recebidos, actualiza a tabela utilizadores via db() e devolve mensagens de sucesso/erro adequadas.
Mostra também o histórico de encomendas do utilizador, recorrendo a orders_for_user() para listar as últimas compras.
A interface é construída com Bootstrap, com secções de “Informações Pessoais” e “Alterar password”, incluindo modais e mensagens de feedback.*/

require __DIR__ . '/config/bootstrap.php';
require_once __DIR__ . '/inc/orders.php';
$userId = Auth::requireLogin();
$u      = Auth::userRow($userId);
if (!$u) {
  Auth::logout();
  header('Location: login.php');
  exit;
}
$ok = null;
$erro = null;
$erros = [];
$okPass = null;
$erroPass = null;
$abrirModalPass = false;
$acao = $_POST['do'] ?? null;
if ($_SERVER['REQUEST_METHOD'] === 'POST' && $acao === 'profile') {
  csrf_verify($_POST['csrf'] ?? null);
  $in = [
    'nome'            => trim($_POST['nome'] ?? ''),
    'apelido'         => trim($_POST['apelido'] ?? ''),
    'telefone'        => trim($_POST['telefone'] ?? ''),
    'data_nascimento' => trim($_POST['data_nascimento'] ?? ''),
    'morada_linha1'   => trim($_POST['morada_linha1'] ?? ''),
    'morada_linha2'   => trim($_POST['morada_linha2'] ?? ''),
    'cod_postal'      => trim($_POST['cod_postal'] ?? ''),
    'localidade'      => trim($_POST['localidade'] ?? ''),
    'distrito'        => trim($_POST['distrito'] ?? ''),
    'pais'            => trim($_POST['pais'] ?? ''),
    'email'           => trim(mb_strtolower($_POST['email'] ?? '')),
  ];
  if ($in['nome'] === '')    { $erros[] = 'O nome é obrigatório.'; }
  if ($in['apelido'] === '') { $erros[] = 'O apelido é obrigatório.'; }
  if ($in['email'] === '')   { $erros[] = 'O e-mail é obrigatório.'; }
  elseif (!filter_var($in['email'], FILTER_VALIDATE_EMAIL)) {
    $erros[] = 'E-mail inválido.';
  }
  if ($in['cod_postal'] !== '' && !preg_match('/^\d{4}-\d{3}$/', $in['cod_postal'])) {
    $erros[] = 'Código-postal deve ser no formato 0000-000.';
  }
  if ($in['telefone'] !== '' && !preg_match('/^[0-9 +()-]{6,20}$/', $in['telefone'])) {
    $erros[] = 'Telefone inválido.';
  }
    if ($in['data_nascimento'] !== '') {
    try {
      $dob = new DateTimeImmutable($in['data_nascimento']);
    } catch (Throwable $e) {
      $erros[] = 'Data de nascimento inválida.';
    }
  }
  if (empty($erros) && $in['email'] !== ($u['email'] ?? '')) {
    $st = db()->prepare('SELECT id FROM utilizadores WHERE email = ? AND id <> ? LIMIT 1');
    $st->execute([$in['email'], $userId]);
    if ($st->fetch()) {
      $erros[] = 'Esse e-mail já está a ser utilizado por outro utilizador.';
    }
  }
  if (empty($erros)) {
    try {
         $up = db()->prepare('
        UPDATE utilizadores
           SET nome = ?, apelido = ?, telefone = ?, data_nascimento = ?, morada_linha1 = ?, morada_linha2 = ?,
               cod_postal = ?, localidade = ?, distrito = ?, pais = ?, email = ?, updated_at = NOW()
         WHERE id = ?
         LIMIT 1
      ');
      $dataNascimentoDb = $in['data_nascimento'] !== '' ? $in['data_nascimento'] : null;
      $up->execute([
        $in['nome'], $in['apelido'], $in['telefone'], $dataNascimentoDb, $in['morada_linha1'], $in['morada_linha2'],
        $in['cod_postal'], $in['localidade'], $in['distrito'], $in['pais'], $in['email'], $userId
      ]);

      $u = Auth::userRow($userId);
      $_SESSION['user']['nome']    = $u['nome']    ?? $_SESSION['user']['nome'];
      $_SESSION['user']['apelido'] = $u['apelido'] ?? $_SESSION['user']['apelido'];
      $ok = 'Perfil atualizado com sucesso.';
    } catch (Throwable $e) {
      $erro = 'Não foi possível atualizar o perfil. Tenta novamente.';
    }
  } else {
    $erro = 'Existem erros no formulário.';
  }
}
if ($_SERVER['REQUEST_METHOD'] === 'POST' && $acao === 'chpass') {
  csrf_verify($_POST['csrf'] ?? null);
  $abrirModalPass = true;
  $curr = (string)($_POST['current_password'] ?? '');
  $new  = (string)($_POST['new_password'] ?? '');
  $conf = (string)($_POST['confirm_password'] ?? '');
  try {
    if ($new !== $conf) {
      throw new InvalidArgumentException('As novas passwords não coincidem.');
    }
    Auth::changePassword($userId, $curr, $new);
    $okPass = 'Password alterada com sucesso.';
  } catch (Throwable $e) {
    $erroPass = $e->getMessage() ?: 'Falha ao alterar a password.';
  }
}
$v = ($_SERVER['REQUEST_METHOD'] === 'POST' && $acao === 'profile')
  ? array_merge($u, $in ?? [])
  : $u;
$encomendas = orders_for_user($userId, 10);
?>
<!DOCTYPE html>
<html lang="pt">
  <head>
    <meta charset="utf-8" />
    <title>Orgânicos - Loja de Produtos Naturais - Perfil do utilizador</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="format-detection" content="telephone=no" />
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="author" content="Andre Barros" />
    <meta name="robots" content="index, follow" />
    <meta
      name="keywords"
      content="Orgânicos, supermercado online, produtos naturais, frutas, legumes, lacticínios, 
        ovos, mercearias, carne, peixe, marisco, padaria, pastelaria, conservas, massa, 
        arroz, bebidas, especiarias, temperos, alimentação saudável perfil do utilizador"
    />
    <meta
      name="description"
      content="Compre online frutas, legumes, carne, peixe, padaria, 
        lacticínios e muito mais. Produtos orgânicos e frescos entregues em sua casa, em todo o país."
    />
    <link
      rel="canonical"
      href="http://localhost/projecto_final/userProfile.php"
    />
    <link
  href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
  rel="stylesheet"
  integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
  crossorigin="anonymous"
/>
    <link rel="stylesheet" href="css/userProfile.css?v=2">

    <link
  rel="stylesheet"
  href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"
/>
  </head>
  <body>
    <a href="homepage.php" class="home-icon" aria-label="Ir para a homepage">
  <i class="fas fa-home"></i>
</a>
    <div class="container rounded bg-white mt-1 mb-1">
      <div class="row">
        <div class="col-md-3 border-right">
          <div class="d-flex flex-column align-items-center text-center p-3 py-5">
            <img
              class="rounded-circle mt-5"
              width="150px"
              src="https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg"
            />
          </div>
        </div>
        <div class="col-md-5 border-right">
          <div class="p-3 py-5">
            <div class="d-flex justify-content-between align-items-center mb-3">
              <h4 class="text-right">Definições de perfil</h4>
            </div>
            <?php if ($ok): ?>
              <div class="alert alert-success py-2"><?= e($ok) ?></div>
            <?php elseif ($erro): ?>
              <div class="alert alert-danger py-2">
                <?= e($erro) ?>
                <?php if (!empty($erros)): ?>
                  <ul class="mb-0 mt-2">
                    <?php foreach ($erros as $eMsg): ?>
                      <li><?= e($eMsg) ?></li>
                    <?php endforeach; ?>
                  </ul>
                <?php endif; ?>
              </div>
            <?php endif; ?>
            <form method="post" action="userProfile.php" novalidate>
              <?= csrf_field() ?>
              <input type="hidden" name="do" value="profile">
              <div class="row mt-2">
                <div class="col-md-6">
                  <label class="labels">Nome</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="Nome próprio"
                    name="nome"
                    value="<?= e($v['nome'] ?? '') ?>"
                  />
                </div>
                <div class="col-md-6">
                  <label class="labels">Apelido</label>
                  <input
                    type="text"
                    class="form-control"
                    name="apelido"
                    value="<?= e($v['apelido'] ?? '') ?>"
                    placeholder="Apelidos"
                  />
                </div>
              </div>
              <div class="row mt-3">
                <div class="col-md-12">
                  <label class="labels">Telefone</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="Introduza o seu telefone"
                    name="telefone"
                    value="<?= e($v['telefone'] ?? '') ?>"
                  />
                </div>
                 <div class="col-md-12">
                  <label class="labels">Data de nascimento</label>
                  <input
                    type="date"
                    class="form-control"
                    name="data_nascimento"
                    value="<?= e($v['data_nascimento'] ?? '') ?>"
                  />
                </div>
                <div class="col-md-12">
                  <label class="labels">Morada</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="Introduza a sua morada"
                    name="morada_linha1"
                    value="<?= e($v['morada_linha1'] ?? '') ?>"
                  />
                </div>
                <div class="col-md-12">
                  <label class="labels">Morada restante</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="Introduza a restante morada"
                    name="morada_linha2"
                    value="<?= e($v['morada_linha2'] ?? '') ?>"
                  />
                </div>
                <div class="col-md-12">
                  <label class="labels">Código-postal</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="Introduza o seu código postal"
                    name="cod_postal"
                    value="<?= e($v['cod_postal'] ?? '') ?>"
                  />
                </div>
                <div class="col-md-12">
                  <label class="labels">Localidade</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="Introduza a localidade onde reside"
                    name="localidade"
                    value="<?= e($v['localidade'] ?? '') ?>"
                  />
                </div>
                <div class="col-md-12">
                  <label class="labels">Email</label>
                  <input
                    type="email"
                    class="form-control"
                    placeholder="Email do utilizador"
                    name="email"
                    value="<?= e($v['email'] ?? '') ?>"
                  />
                </div>
              </div>
              <div class="row mt-3">
                <div class="col-md-6">
                  <label class="labels">País</label>
                  <input
                    type="text"
                    class="form-control"
                    placeholder="País"
                    name="pais"
                    value="<?= e($v['pais'] ?? '') ?>"
                  />
                </div>
                <div class="col-md-6">
                  <label class="labels">Distrito</label>
                  <input
                    type="text"
                    class="form-control"
                    name="distrito"
                    value="<?= e($v['distrito'] ?? '') ?>"
                    placeholder="Distrito"
                  />
                </div>
              </div>
            <div class="mt-5 d-flex justify-content-between align-items-center w-100" style="max-width:520px;margin:0 auto;">
              <button class="btn btn-primary profile-button" type="submit">Guardar alterações</button>
              <button class="btn btn-secondary profile-button" type="button" data-bs-toggle="modal" data-bs-target="#modalPassword">Alterar Password</button>
            </div>
            </form>
          </div>
        </div>
        <div class="col-md-4">
          <div class="p-3 py-5">
            <div class="d-flex justify-content-between align-items-center experience">
              <span>Encomendas passadas</span>
            </div>
            <br />
            <?php if (empty($encomendas)): ?>
              <div class="col-md-12">
                <label class="labels">Sem encomendas</label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="Ainda não tens encomendas"
                  value=""
                  disabled
                />
              </div>
            <?php else: ?>
              <?php foreach ($encomendas as $i => $en): ?>
                <div class="col-md-12">
                 <label class="labels">
                  Encomenda #<?= e($en['id'] ?? '') ?>
                </label>
                <input
                  type="text"
                  class="form-control"
                  placeholder="encomenda passada <?= $i+1 ?>"
                  value="Total: <?= money((float)($en['total'] ?? 0)) ?>€ — <?= e(date_pt($en['created_at'] ?? null)) ?>"
                  readonly
                />
                </div>
                <br />
              <?php endforeach; ?>
            <?php endif; ?>
          </div>
        </div>
      </div>
    </div>
    <div class="modal fade" id="modalPassword" tabindex="-1" aria-hidden="true">
      <div class="modal-dialog">
        <form class="modal-content" method="post" action="userProfile.php" novalidate>
          <?= csrf_field() ?>
          <input type="hidden" name="do" value="chpass">
          <div class="modal-header">
            <h5 class="modal-title">Alterar Password</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Fechar"></button>
          </div>
          <div class="modal-body">
            <?php if ($abrirModalPass && $okPass): ?>
              <div class="alert alert-success py-2"><?= e($okPass) ?></div>
            <?php elseif ($abrirModalPass && $erroPass): ?>
              <div class="alert alert-danger py-2"><?= e($erroPass) ?></div>
            <?php endif; ?>
            <div class="mb-3">
              <label class="form-label">Password atual</label>
              <input type="password" class="form-control" name="current_password" required autocomplete="current-password">
            </div>
            <div class="mb-3">
              <label class="form-label">Nova password</label>
              <input type="password" class="form-control" name="new_password" required minlength="8" autocomplete="new-password">
              <div class="form-text">Mínimo 8 caracteres, com pelo menos uma letra e um número.</div>
            </div>
            <div class="mb-3">
              <label class="form-label">Confirmar nova password</label>
              <input type="password" class="form-control" name="confirm_password" required minlength="8" autocomplete="new-password">
            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cancelar</button>
            <button type="submit" class="btn btn-primary">Guardar nova password</button>
          </div>
        </form>
      </div>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe" crossorigin="anonymous">
    </script>
    <?php if ($abrirModalPass): ?>
      <script nonce="<?= e($cspNonce) ?>">
        document.addEventListener('DOMContentLoaded', function () {
          var modalEl = document.getElementById('modalPassword');
          var m = new bootstrap.Modal(modalEl);
          m.show();
        });
      </script>
    <?php endif; ?>
  </body>
</html>
