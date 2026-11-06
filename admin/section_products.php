
<?php

 /*Carrega a lista de categorias e, se existir edit em $_GET, carrega os dados do produto a editar.
Permite pesquisar produtos pelo nome através de search_products_by_name().
Apresenta um formulário completo para criar/editar produtos (nome, categoria, preço, promoção, stock, tipo de venda, imagem, etc.).
Mostra uma lista de produtos com indicação se estão em promoção (com badge e percentagem).
É a secção visual da gestão de produtos que é invocada pelo admin_dashboard.php na área de administração.*/

$catsStmt   = db()->query('SELECT id, nome, slug FROM categorias ORDER BY nome');
$categorias = $catsStmt->fetchAll();

$editId        = isset($_GET['edit']) ? (int)$_GET['edit'] : 0;
$produtoEdit   = null;
$promoAteValue = '';

if ($editId > 0) {
  $stmt = db()->prepare('SELECT * FROM produtos WHERE id = ?');
  $stmt->execute([$editId]);
  $produtoEdit = $stmt->fetch();

  if ($produtoEdit && !empty($produtoEdit['promocao_ate'])) {
    try {
      $dt = new DateTime($produtoEdit['promocao_ate']);
      $promoAteValue = $dt->format('Y-m-d\TH:i');
    } catch (Throwable $e) {
      $promoAteValue = '';
    }
  }

  if (!$produtoEdit) {
    $editId = 0;
  }
}
$searchTerm = trim($_GET['q'] ?? '');

if ($searchTerm !== '') {
  $produtos = search_products_by_name($searchTerm, null);
} else {
  $prodStmt = db()->query(
    'SELECT p.*, c.nome AS categoria_nome
       FROM produtos p
       JOIN categorias c ON c.id = p.categoria_id
      ORDER BY p.nome'
  );
  $produtos = $prodStmt->fetchAll();
}
?>
<div class="d-flex justify-content-start mb-3">
  <a href="admin_dashboard.php" class="btn btn-outline-secondary btn-sm">
    <i class="fas fa-arrow-left me-1"></i> Voltar ao painel
  </a>
</div>

<div class="card shadow-sm bg-white">
  <div class="card-body text-dark">
    <h2 class="h5 mb-4">Gestão de produtos</h2>

<div class="row mb-3">
  <div class="col-md-6">
    <form method="get" action="admin_dashboard.php" class="d-flex gap-2">
      <input type="hidden" name="sec" value="products">
      <input
        type="text"
        name="q"
        class="form-control"
        placeholder="Pesquisar produto (nome)..."
        value="<?= e($searchTerm) ?>"
      />
      <button type="submit" class="btn btn-outline-secondary">
        Procurar
      </button>
    </form>
    <small class="text-muted">
      Pode pesquisar pelo nome do produto.
    </small>
  </div>
</div>

    <div class="table-responsive mb-4">
      <table class="table table-striped table-hover align-middle">
        <thead class="table-light">
          <tr>
            <th>ID</th>
            <th>Nome</th>
            <th>Categoria</th>
            <th>Preço (€)</th>
            <th>Promoção</th>
            <th>Stock</th>
            <th class="text-end">Ações</th>
          </tr>
        </thead>
        <tbody>
          <?php if (!$produtos): ?>
            <tr>
              <td colspan="7" class="text-center text-muted">
                Ainda não há produtos registados.
              </td>
            </tr>
          <?php else: ?>
            <?php foreach ($produtos as $p): ?>
              <?php $promoAtiva = ((int)$p['promocao'] === 1); ?>
              <tr>
                <td><?= (int)$p['id'] ?></td>
                <td><?= e($p['nome']) ?></td>
                <td><?= e($p['categoria_nome']) ?></td>
                <td><?= money((float)$p['preco']) ?> €</td>
                <td>
                  <?php if ($promoAtiva): ?>
                    <span class="badge bg-success">
                      Em promoção
                      <?php if ($p['valor_promocao'] !== null): ?>
                        (<?= e((string)$p['valor_promocao']) ?>%)
                      <?php endif; ?>
                    </span>
                  <?php else: ?>
                    <span class="badge bg-secondary">Sem promoção</span>
                  <?php endif; ?>
                </td>
                <td><?= (int)$p['quantidade_em_stock'] ?></td>
                <td class="text-end">
                  <a
                    href="admin_dashboard.php?sec=products&amp;edit=<?= (int)$p['id'] ?>#product-form"
                    class="btn btn-sm btn-primary"
                  >
                    Editar
                  </a>

                  <form
                    method="post"
                    class="d-inline"
                    onsubmit="return confirm('Tens a certeza que queres eliminar este produto?');"
                  >
                    <?= csrf_field() ?>
                    <input type="hidden" name="do" value="delete_product" />
                    <input
                      type="hidden"
                      name="id"
                      value="<?= (int)$p['id'] ?>"
                    />
                    <button type="submit" class="btn btn-sm btn-danger">
                      Eliminar
                    </button>
                  </form>
                </td>
              </tr>
            <?php endforeach; ?>
          <?php endif; ?>
        </tbody>
      </table>
    </div>

    <hr class="my-4" /> 

    <div id="product-form"></div>

    <h3 class="h6 mb-3">
      <?= $editId ? 'Editar produto #' . (int)$editId : 'Adicionar novo produto' ?>
    </h3>

    <form method="post" class="row g-3" enctype="multipart/form-data">
      <?= csrf_field() ?>
      <input type="hidden" name="do" value="save_product" />
      <input type="hidden" name="id" value="<?= $editId ? (int)$editId : 0 ?>" />
      <input
        type="hidden"
        name="slug"
        value="<?= e($produtoEdit['slug'] ?? '') ?>"
      />

      <div class="col-md-6">
        <label class="form-label" for="nome">Nome</label>
        <input
          type="text"
          class="form-control"
          id="nome"
          name="nome"
          required
          value="<?= e($produtoEdit['nome'] ?? '') ?>"
          style="border: 2px solid #2e7d32 "
        />
      </div>

      <div class="col-md-6">
        <label class="form-label" for="categoria_id">Categoria</label>
        <select
          class="form-select"
          id="categoria_id"
          name="categoria_id"
          style="border: 2px solid #2e7d32"
          required
          
        >
          <option value="">-- Escolhe uma categoria --</option>
          <?php foreach ($categorias as $cat): ?>
            <option
              value="<?= (int)$cat['id'] ?>"
              data-slug="<?= e($cat['slug']) ?>"
              <?php
                if ($produtoEdit && (int)$produtoEdit['categoria_id'] === (int)$cat['id']) {
                  echo 'selected';
                }
              ?>
            >
              <?= e($cat['nome']) ?>
            </option>
          <?php endforeach; ?>
        </select>
      </div>

      <div class="col-12">
        <label class="form-label" for="descricao_curta">Descrição curta</label>
        <input
          type="text"
          class="form-control"
          id="descricao_curta"
          name="descricao_curta"
          style="border: 2px solid #2e7d32"
          required
          value="<?= e($produtoEdit['descricao_curta'] ?? '') ?>"
        />
      </div>

      <div class="col-12">
        <label class="form-label" for="descricao_detalhada">
          Descrição detalhada
        </label>
        <textarea
          class="form-control"
          id="descricao_detalhada"
          name="descricao_detalhada"
          style="border: 2px solid #2e7d32"
          rows="2"
          required
        ><?= e($produtoEdit['descricao_detalhada'] ?? '') ?></textarea>
      </div>

      <div class="col-md-4">
        <label class="form-label" for="preco">Preço (€)</label>
        <input
          type="text"
          class="form-control"
          id="preco"
          name="preco"
          style="border: 2px solid #2e7d32"
          required
          value="<?= isset($produtoEdit['preco']) ? e((string)$produtoEdit['preco']) : '' ?>"
        />
      </div>

      <div class="col-md-4">
        <label class="form-label" for="tipo_venda">Tipo de venda</label>
        <?php
          $tiposVenda = [
            'unidade' => 'Unidade',
            'kg'      => 'Kg',
            'litro'   => 'Litro',
            'pack'    => 'Pack',
            'caixa'   => 'Caixa',
            'outro'   => 'Outro',
          ];
          $tipoAtual = $produtoEdit['tipo_venda'] ?? 'unidade';
        ?>
        <select
          class="form-select"
          id="tipo_venda"
          name="tipo_venda"
          style="border: 2px solid #2e7d32"
          required
        >
          <?php foreach ($tiposVenda as $tvKey => $tvLabel): ?>
            <option
              value="<?= e($tvKey) ?>"
              <?= $tipoAtual === $tvKey ? 'selected' : '' ?>
            >
              <?= e($tvLabel) ?>
            </option>
          <?php endforeach; ?>
        </select>
      </div>

      <div class="col-md-4">
        <label class="form-label" for="quantidade_em_stock">
          Quantidade em stock
        </label>
        <input
          type="number"
          class="form-control"
          id="quantidade_em_stock"
          name="quantidade_em_stock"
          min="0"
          style="border: 2px solid #2e7d32" 
          required
          value="<?= isset($produtoEdit['quantidade_em_stock']) ? (int)$produtoEdit['quantidade_em_stock'] : 0 ?>"
        />
      </div>

      <div class="col-md-3">
        <?php $promoAtivaForm = $produtoEdit ? ((int)$produtoEdit['promocao'] === 1) : false; ?>
        <div class="form-check mt-4 pt-2">
          <input
            class="form-check-input"
            type="checkbox"
            value="1"
            id="promocao"
            name="promocao"
            style="border: 2px solid #2e7d32"
            <?= $promoAtivaForm ? 'checked' : '' ?>
          />
          <label class="form-check-label" for="promocao">
            Produto em promoção
          </label>
        </div>
      </div>

      <div class="col-md-3">
        <label class="form-label" for="valor_promocao">
          Valor da promoção (%)
        </label>
        <input
          type="text"
          class="form-control"
          id="valor_promocao"
          name="valor_promocao"
          style="border: 2px solid #2e7d32"
          value="<?= isset($produtoEdit['valor_promocao']) ? e((string)$produtoEdit['valor_promocao']) : '' ?>"
        />
      </div>

      <div class="col-md-3 col-lg-2">
        <label class="form-label" for="promocao_ate">
          Promoção até
        </label>
        <input
          type="datetime-local"
          class="form-control"
          id="promocao_ate"
          name="promocao_ate"
          style="border: 2px solid #2e7d32"
          value="<?= e($promoAteValue) ?>"
        />
      </div>

      <div class="col-md-6">
        <label class="form-label" for="imagem_ficheiro">
          Escolher ficheiro de imagem
        </label>
        <input
          type="file"
          class="form-control"
          id="imagem_ficheiro"
          name="imagem_ficheiro"
          style="border: 2px solid #2e7d32"
          accept="image/*"
          <?= $editId ? '' : 'required' ?>
        />
        <small class="text-muted d-block">
          A imagem será guardada automaticamente na pasta da categoria.
        </small>
      </div>

      <div class="col-12">
        <button type="submit" class="btn btn-success">
          <?= $editId ? 'Guardar alterações' : 'Adicionar produto' ?>
        </button>
        <?php if ($editId): ?>
          <a
            href="admin_dashboard.php?sec=products"
            class="btn btn-outline-secondary ms-2"
          >
            Cancelar edição
          </a>
        <?php endif; ?>
      </div>
    </form>
  </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {
  var chkPromo    = document.getElementById('promocao');
  var inpValor    = document.getElementById('valor_promocao');
  var inpPromoAte = document.getElementById('promocao_ate');

  if (!chkPromo || !inpValor || !inpPromoAte) return;

  function atualizarObrigatoriedade() {
    if (chkPromo.checked) {
      inpValor.required    = true;
      inpPromoAte.required = true;
    } else {
      inpValor.required    = false;
      inpPromoAte.required = false;
    }
  }

  chkPromo.addEventListener('change', atualizarObrigatoriedade);
  atualizarObrigatoriedade();
});
</script>
