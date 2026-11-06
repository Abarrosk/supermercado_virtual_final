
<?php

/*Permite pesquisar utilizadores por vários campos usando search_users().
Quando não há pesquisa, lista todos os utilizadores não apagados (is_deleted = 0) com campos básicos (nome, apelido, email, telefone, datas, etc.).
Mostra numa tabela o nível de cada utilizador (incluindo admins) e informação de contacto.
Para utilizadores “normais”, apresenta um formulário para eliminar o utilizador, com CSRF e confirmação por confirm().
Impede a eliminação de administradores e do próprio utilizador autenticado, desactivando o botão nesses casos.*/

$searchTerm = trim($_GET['q'] ?? '');

if ($searchTerm !== '') {
  $users = search_users($searchTerm);
} else {
  $stmt = db()->query('SELECT id, nome, apelido, email, telefone, is_admin, created_at FROM utilizadores WHERE is_deleted = 0 ORDER BY id DESC');
  $users = $stmt->fetchAll();
}
?>
<div class="d-flex justify-content-start mb-3">
  <a href="admin_dashboard.php" class="btn btn-outline-secondary btn-sm">
    <i class="fas fa-arrow-left me-1"></i> Voltar ao painel
  </a>
</div>
<div class="card shadow-sm">
  <div class="card-body">
    <h2 class="h5 mb-4">Gestão de utilizadores</h2>

  <div class="row mb-3">
  <div class="col-md-6">
    <form method="get" action="admin_dashboard.php" class="d-flex gap-2">
      <input type="hidden" name="sec" value="users">
      <input
        type="text"
        name="q"
        class="form-control"
        placeholder="Pesquisar utilizador (ID, nome, email, telefone, morada, código postal, localidade)..."
        value="<?= e($searchTerm) ?>"
      />
      <button type="submit" class="btn btn-outline-secondary">
        Procurar
      </button>
    </form>
    <small class="text-muted">
      Podes pesquisar pelo ID ou por qualquer dado principal do utilizador.
    </small>
  </div>
</div>


    <div class="table-responsive">
      <table class="table table-striped table-hover align-middle">
        <thead class="table-light">
          <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Email</th>
            <th>Telefone</th>
            <th>Tipo</th>
            <th>Registado em</th>
            <th class="text-end">Ações</th>
          </tr>
        </thead>
        <tbody>
          <?php if (!$users): ?>
            <tr>
              <td colspan="7" class="text-center text-muted">
                Ainda não há utilizadores registados.
              </td>
            </tr>
          <?php else: ?>
            <?php foreach ($users as $uRow): ?>
              <tr>
                <td><?= (int)$uRow['id'] ?></td>
                <td><?= e($uRow['nome'] . ' ' . $uRow['apelido']) ?></td>
                <td><?= e($uRow['email']) ?></td>
                <td><?= e($uRow['telefone'] ?? '') ?></td>
                <td>
                  <?php if ((int)$uRow['is_admin'] === 1): ?>
                    <span class="badge bg-primary">Admin</span>
                  <?php else: ?>
                    <span class="badge bg-secondary">Utilizador</span>
                  <?php endif; ?>
                </td>
                <td><?= e(date_pt($uRow['created_at'])) ?></td>
                <td class="text-end">
                  <?php if ((int)$uRow['id'] === (int)$userId || (int)$uRow['is_admin'] === 1): ?>
                    <button
                      class="btn btn-sm btn-outline-secondary"
                      disabled
                      title="Não é possível eliminar administradores nem o próprio utilizador"
                    >
                      Eliminar
                    </button>
                  <?php else: ?>
                    <form
                      method="post"
                      class="d-inline"
                      onsubmit="return confirm('Tens a certeza que queres eliminar este utilizador?');"
                    >
                      <?= csrf_field() ?>
                      <input type="hidden" name="do" value="delete_user" />
                      <input
                        type="hidden"
                        name="id"
                        value="<?= (int)$uRow['id'] ?>"
                      />
                      <button type="submit" class="btn btn-sm btn-danger">
                        Eliminar
                      </button>
                    </form>
                  <?php endif; ?>
                </td>
              </tr>
            <?php endforeach; ?>
          <?php endif; ?>
        </tbody>
      </table>
    </div>
  </div>
</div>
