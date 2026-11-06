
<?php

/* Lista encomendas, com opção de pesquisa usando a função search_orders() sobre várias colunas (id, email, nome, morada, etc.).
Faz JOIN entre encomendas e utilizadores para mostrar o email do utilizador associado.
Agrupa os itens de cada encomenda num array $itemsByOrder para exibir detalhes linha a linha.
Renderiza uma tabela com total, data formatada, destinatário e um botão para abrir um modal com os detalhes da encomenda.
Usa helpers como e() e money() para sair do HTML e formatar valores monetários em euros.*/

$searchTerm = trim($_GET['q'] ?? '');

if ($searchTerm !== '') {
  $orders = search_orders($searchTerm);
} else {
  $stmt = db()->query(
    'SELECT e.*, u.email
       FROM encomendas e
  LEFT JOIN utilizadores u ON u.id = e.user_id
   ORDER BY e.created_at DESC'
  );
  $orders = $stmt->fetchAll();
}

$itemsByOrder = [];
if ($orders) {
  $ids = array_column($orders, 'id');
  $placeholders = implode(',', array_fill(0, count($ids), '?'));

  $stmtItems = db()->prepare(
    "SELECT *
       FROM encomendas_itens
      WHERE encomenda_id IN ($placeholders)
      ORDER BY encomenda_id, id"
  );
  $stmtItems->execute($ids);

  while ($it = $stmtItems->fetch()) {
    $orderId = (int)$it['encomenda_id'];
    if (!isset($itemsByOrder[$orderId])) {
      $itemsByOrder[$orderId] = [];
    }
    $itemsByOrder[$orderId][] = $it;
  }
}
?>
<div class="d-flex justify-content-start mb-3">
  <a href="admin_dashboard.php" class="btn btn-outline-secondary btn-sm">
    <i class="fas fa-arrow-left me-1"></i> Voltar ao painel
  </a>
</div>
<div class="card shadow-sm">
  <div class="card-body">
    <h2 class="h5 mb-4">Gestão de encomendas</h2>

   <div class="row mb-3">
  <div class="col-md-6">
    <form method="get" action="admin_dashboard.php" class="d-flex gap-2">
      <input type="hidden" name="sec" value="orders">
      <input
        type="text"
        name="q"
        class="form-control"
        placeholder="Pesquisar encomenda (nº, email, nome, telefone, morada, código postal, localidade, distrito)..."
        value="<?= e($searchTerm) ?>"
      />
      <button type="submit" class="btn btn-outline-secondary">
        Procurar
      </button>
    </form>
    <small class="text-muted">
      Podes pesquisar pelo nº da encomenda ou pelos dados do utilizador/destinatário.
    </small>
  </div>
</div>

    <div class="table-responsive">
      <table class="table table-striped table-hover align-middle">
        <thead class="table-light">
          <tr>
            <th>#</th>
            <th>Utilizador</th>
            <th>Nome destinatário</th>
            <th>Total (€)</th>
            <th>Criada em</th>
            <th class="text-end">Ações</th>
          </tr>
        </thead>
        <tbody>
          <?php if (!$orders): ?>
            <tr>
              <td colspan="6" class="text-center text-muted">
                Ainda não há encomendas registadas.
              </td>
            </tr>
          <?php else: ?>
            <?php foreach ($orders as $order): ?>
              <tr>
                <td><?= (int)$order['id'] ?></td>
                <td><?= e($order['email'] ?? '') ?></td>
                <td><?= e($order['nome_destinatario']) ?></td>
                <td><?= money((float)$order['total']) ?> €</td>
                <td><?= e(date_pt($order['created_at'])) ?></td>
                <td class="text-end">
                  <button
                    type="button"
                    class="btn btn-sm btn-outline-primary"
                    data-bs-toggle="modal"
                    data-bs-target="#orderModal-<?= (int)$order['id'] ?>"
                  >
                    Ver detalhes
                  </button>
                </td>
              </tr>
            <?php endforeach; ?>
          <?php endif; ?>
        </tbody>
      </table>
    </div>
  </div>
</div>

<?php if ($orders): ?>
  <?php foreach ($orders as $order): ?>
    <?php
      $orderId   = (int)$order['id'];
      $items     = $itemsByOrder[$orderId] ?? [];
      $morada1   = $order['morada_linha1'] ?? '';
      $morada2   = $order['morada_linha2'] ?? '';
      $codPostal = $order['cod_postal'] ?? '';
      $local     = $order['localidade'] ?? '';
      $distrito  = $order['distrito'] ?? '';
      $pais      = $order['pais'] ?? 'Portugal';
    ?>
    <div
      class="modal fade"
      id="orderModal-<?= $orderId ?>"
      tabindex="-1"
      aria-labelledby="orderModalLabel-<?= $orderId ?>"
      aria-hidden="true"
    >
      <div class="modal-dialog modal-lg modal-dialog-scrollable">
        <div class="modal-content text-dark">
          <div class="modal-header">
            <h5 class="modal-title" id="orderModalLabel-<?= $orderId ?>">
              Detalhes da encomenda #<?= $orderId ?>
            </h5>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Fechar"
            ></button>
          </div>

          <div class="modal-body">
            <div class="mb-3">
              <h6 class="fw-bold mb-2">Dados da encomenda</h6>

              <p class="mb-1">
                <strong>Nº encomenda:</strong>
                #<?= (int)$order['id'] ?>
              </p>

              <p class="mb-1">
                <strong>Utilizador (email):</strong>
                <?= e($order['email'] ?? '') ?>
              </p>

              <p class="mb-1">
                <strong>Nome destinatário:</strong>
                <?= e($order['nome_destinatario']) ?>
              </p>

              <p class="mb-1">
                <strong>Telefone:</strong>
                <?= e($order['telefone'] ?? '') ?>
              </p>

              <p class="mb-1">
                <strong>Morada:</strong><br>
                <?= e($morada1) ?>
                <?php if ($morada2): ?>
                  <br><?= e($morada2) ?>
                <?php endif; ?>
                <br><?= e($codPostal) ?> <?= e($local) ?>
                <?php if ($distrito): ?>
                  <br><?= e($distrito) ?>
                <?php endif; ?>
                <br><?= e($pais) ?>
              </p>

              <p class="mb-1">
                <strong>Criada em:</strong>
                <?= e(date_pt($order['created_at'])) ?>
              </p>
            </div>

            <hr />
            <div class="mb-3">
              <h6 class="fw-bold mb-2">Produtos</h6>

              <?php if (!$items): ?>
                <p class="text-muted mb-0">
                  Não foram encontrados itens para esta encomenda.
                </p>
              <?php else: ?>
                <div class="table-responsive">
                  <table class="table table-sm align-middle">
                    <thead>
                      <tr>
                        <th>Produto</th>
                        <th class="text-end">Qtd</th>
                        <th class="text-end">Preço unitário</th>
                        <th class="text-end">Total linha</th>
                      </tr>
                    </thead>
                    <tbody>
                      <?php foreach ($items as $it): ?>
                        <tr>
                          <td>
                            <?= e($it['nome_produto']) ?><br>
                          </td>
                          <td class="text-end">
                            <?= (int)$it['quantidade'] ?>
                          </td>
                          <td class="text-end">
                            <?= money((float)$it['preco_unitario']) ?> €
                          </td>
                          <td class="text-end">
                            <?= money((float)$it['total_linha']) ?> €
                          </td>
                        </tr>
                      <?php endforeach; ?>
                    </tbody>
                  </table>
                </div>
              <?php endif; ?>
            </div>

            <hr />
            <div class="mb-1">
              <h6 class="fw-bold mb-2">Resumo de valores</h6>

              <p class="mb-1">
                <strong>Subtotal:</strong>
                <?= money((float)$order['subtotal']) ?> €
              </p>

              <p class="mb-1">
                <strong>Desconto:</strong>
                <?= money((float)$order['desconto_total']) ?> €
              </p>

              <p class="mb-1">
                <strong>Portes:</strong>
                <?= money((float)$order['portes']) ?> €
              </p>

              <p class="mb-0">
                <strong>Total:</strong>
                <?= money((float)$order['total']) ?> €
              </p>
            </div>
          </div>

          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-secondary"
              data-bs-dismiss="modal"
            >
              Fechar
            </button>
          </div>
        </div>
      </div>
    </div>
  <?php endforeach; ?>
<?php endif; ?>
