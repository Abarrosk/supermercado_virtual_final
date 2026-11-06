<?php
declare(strict_types=1);

/*Define a função render_card_produto() que imprime o HTML completo de um cartão de produto.
Calcula se a promoção está activa (campo promocao e promocao_ate) e, se sim, mostra preço original, preço com promoção e badge com “X% DESC”.
Garante que existe sempre uma imagem (usa placeholder se caminho_imagem estiver vazio).
Renderiza o formulário “Adicionar ao Carrinho” com quantidade, tipo de venda (kg/unidade, etc.), CSRF e botão com ícone de carrinho.
Centraliza a estrutura visual dos produtos para que diferentes páginas usem o mesmo layout consistente. */

if (!function_exists('render_card_produto')) {
  function render_card_produto(array $p): void {
    $emPromo = (int)($p['promocao'] ?? 0) === 1 && (!isset($p['promocao_ate']) || strtotime((string)$p['promocao_ate']) >= time());
    $precoOriginal = number_format((float)($p['preco'] ?? 0), 2, ',', '');
    $temPromo = $emPromo && isset($p['preco_com_promocao']) && $p['preco_com_promocao'] !== null;
    $precoPromo = $temPromo ? number_format((float)$p['preco_com_promocao'], 2, ',', '') : null;
    $badge = ($temPromo && isset($p['valor_promocao']) && $p['valor_promocao'] !== null)
      ? rtrim(rtrim((string)$p['valor_promocao'], '0'), '.') . '% DESC'
      : null;
    $img = !empty($p['caminho_imagem']) ? (string)$p['caminho_imagem'] : 'images/placeholder.png';
    ?>
    <div class="col">
      <div class="product-item">
        <figure>
          <a href="comprar.php?produto=<?= urlencode($p['slug'] ?? (string)($p['id'] ?? '')) ?>" title="<?= htmlspecialchars((string)($p['nome'] ?? 'Produto')) ?>">
            <img
              src="<?= htmlspecialchars($img) ?>"
              alt="<?= htmlspecialchars((string)($p['nome'] ?? 'Produto')) ?>"
              class="tab-image"
              loading="lazy"
            />
          </a>
        </figure>
        <div class="d-flex flex-column text-center">
          <h3 class="fs-6 fw-normal"><?= htmlspecialchars((string)($p['nome'] ?? '')) ?></h3>
          <div>
            <span class="rating">
              <svg width="18" height="18" class="text-warning"><use xlink:href="images/icons.svg#star-full"></use></svg>
              <svg width="18" height="18" class="text-warning"><use xlink:href="images/icons.svg#star-full"></use></svg>
              <svg width="18" height="18" class="text-warning"><use xlink:href="images/icons.svg#star-full"></use></svg>
              <svg width="18" height="18" class="text-warning"><use xlink:href="images/icons.svg#star-full"></use></svg>
              <svg width="18" height="18" class="text-warning"><use xlink:href="images/icons.svg#star-half"></use></svg>
            </span>
            <span>(<?= (int)($p['numero_reviews'] ?? 0) ?>)</span>
          </div>
          <div class="d-flex justify-content-center align-items-center gap-2">
            <?php if ($temPromo): ?>
              <del><?= $precoOriginal ?>€</del>
              <span class="text-dark fw-semibold"><?= $precoPromo ?>€</span>
              <?php if ($badge): ?>
                <span class="badge border border-dark-subtle rounded-0 fw-normal px-1 fs-7 lh-1 text-body-tertiary"><?= $badge ?></span>
              <?php endif; ?>
            <?php else: ?>
              <span class="text-dark fw-semibold"><?= $precoOriginal ?>€</span>
            <?php endif; ?>
            <?php if (!empty($p['tipo_venda'])): ?>
              <small class="text-body-tertiary ms-1">/ <?= htmlspecialchars((string)$p['tipo_venda']) ?></small>
            <?php endif; ?>
          </div>
          <div class="button-area p-3 pt-0">
            <form class="row g-1 mt-2 add-to-cart-form" method="post" action="api/cart_add.php">
              <div class="col-3">
                <input type="number" name="quantidade" class="form-control border-dark-subtle input-number quantity" value="1" min="1" />
              </div>
              <div class="col-7">
                <input type="hidden" name="produto_id" value="<?= (int)($p['id'] ?? 0) ?>">
                <?= function_exists('csrf_field') ? csrf_field() : '' ?>
                <button type="submit" class="btn btn-primary rounded-1 p-2 fs-7 btn-cart">
                  <svg width="18" height="18"><use xlink:href="images/icons.svg#cart"></use></svg>
                  Adicionar ao Carrinho
                </button>
              </div>
              <div class="col-2">
                <a href="#" class="btn btn-outline-dark rounded-1 p-2 fs-6">
                  <svg width="18" height="18"><use xlink:href="images/icons.svg#heart"></use></svg>
                </a>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
    <?php
  }
}
