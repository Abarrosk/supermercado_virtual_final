<?php

/*Implementa as funções do carrinho guardado em sessão: cart_get(), cart_add(), cart_update(), cart_clear() e cart_remove().
Em cart_add(), verifica se o produto existe e calcula o preço efectivo tendo em conta promoções activas e datas (promocao, promocao_ate).
Guarda por item informação relevante (id, nome, slug, tipo de venda, imagem, preço unitário, quantidade e total da linha).
cart_update() permite actualizar quantidades para valores positivos, removendo linhas inválidas ou a zero.
cart_remove() retira um item específico e reflecte o resultado em $_SESSION['cart'].*/

function cart_get(): array { return $_SESSION['cart'] ?? []; }
function cart_add(int $produtoId, int $qty): array {
  if ($qty < 1) { $qty = 1; }
  $p = product_by_id($produtoId);
  if (!$p) { http_response_code(404); exit('Produto inexistente.'); }
  $agora = new DateTimeImmutable('now');
  $promoAtiva = ((int)$p['promocao'] === 1) && (empty($p['promocao_ate']) || new DateTimeImmutable($p['promocao_ate']) >= $agora);
  $preco = ($promoAtiva && $p['preco_com_promocao'] !== null) ? (float)$p['preco_com_promocao'] : (float)$p['preco'];
  $key = (string)$p['id'];
  $item = [
    'id' => (int)$p['id'],
    'nome' => $p['nome'],
    'slug' => $p['slug'],
    'tipo_venda' => $p['tipo_venda'],
    'imagem' => $p['caminho_imagem'],
    'preco' => $preco,
    'qty' => $qty,
  ];
  $cart = cart_get();
  if (isset($cart[$key])) { $item['qty'] += $cart[$key]['qty']; }
  $cart[$key] = $item;
  $_SESSION['cart'] = $cart;
  return $cart;
}
function cart_clear(): void {
  unset($_SESSION['cart']);
}
function cart_remove(int $produtoId): array {
  $key  = (string)$produtoId;
  $cart = cart_get();
  if (isset($cart[$key])) {
    unset($cart[$key]);
    $_SESSION['cart'] = $cart;
  }
  return $cart;
}

