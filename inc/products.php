<?php

/*Implementa funções de acesso a produtos: product_by_id() e vários selectores de listas.
products_random() devolve produtos em ordem aleatória, com limite opcional.
products_by_category_slug() selecciona produtos por categoria.slug, ordenando por nome.
Inclui funções para obter “mais vendidos”, “destaque”, “populares” e “recentes”, com ordenações por vendas, promoção, número de reviews ou data de adição.
É o motor para obter listas de produtos utilizado em homepage.php, comprar.php e outras partes do site.*/

function product_by_id(int $id): ?array {
  $s = db()->prepare('SELECT * FROM produtos WHERE id = ? LIMIT 1');
  $s->execute([$id]);
  $p = $s->fetch();
  return $p ?: null;
}
function products_random(?int $limit = 7): array {
  $sql = "SELECT * FROM produtos ORDER BY RAND()";
  if ($limit !== null) { $sql .= " LIMIT " . (int)$limit; }
  $q = db()->query($sql);
  return $q->fetchAll();
}
function products_by_category_slug(string $slug, ?int $limit = 7): array {
  $sql = 'SELECT p.* FROM produtos p JOIN categorias c ON c.id = p.categoria_id WHERE c.slug = ? ORDER BY p.nome';
  if ($limit !== null) { $sql .= ' LIMIT ' . (int)$limit; }
  $s = db()->prepare($sql);
  $s->execute([$slug]);
  return $s->fetchAll();
}
function products_mais_vendidos(?int $limit = 5): array {
  $sql = 'SELECT * FROM produtos ORDER BY quantidade_vendida DESC, id DESC';
  if ($limit !== null) { $sql .= ' LIMIT ' . (int)$limit; }
  return db()->query($sql)->fetchAll();
}
function products_destaque(?int $limit = 5): array {
 $sql = "SELECT * FROM produtos
        WHERE promocao = 1
          AND (promocao_ate IS NULL OR promocao_ate >= NOW())
        ORDER BY valor_promocao DESC,
                 COALESCE(preco_com_promocao, preco) ASC,
                 data_produto_adicionado DESC, id DESC";
if ($limit !== null) { $sql .= ' LIMIT ' . (int)$limit; }
  return db()->query($sql)->fetchAll();
}
function products_populares(?int $limit = 5): array {
  $sql = 'SELECT * FROM produtos ORDER BY numero_reviews DESC, id DESC';
  if ($limit !== null) { $sql .= ' LIMIT ' . (int)$limit; }
  return db()->query($sql)->fetchAll();
}
function products_recentes(?int $limit = 5): array {
  $sql = 'SELECT * FROM produtos ORDER BY data_produto_adicionado DESC, id DESC';
  if ($limit !== null) { $sql .= ' LIMIT ' . (int)$limit; }
  return db()->query($sql)->fetchAll();
}
