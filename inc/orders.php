
<?php

/*orders_for_user() devolve a lista paginada de encomendas de um utilizador (id, total, data), ordenadas por data decrescente.
orders_generate_number() cria um identificador legível do tipo ENYYYYMMDDHHMMSS-userId.
orders_create_from_cart() recebe userId, dados do cliente, carrinho e totais (subtotal, desconto, portes, total).
Guarda a encomenda na tabela encomendas e em seguida insere cada linha na tabela encomendas_itens com preços e quantidades.
Usa transacções (beginTransaction/commit/rollBack) para garantir consistência caso algo corra mal a meio.*/

function orders_for_user(int $userId, int $limit = 10, int $offset = 0): array {
  $limit  = max(1, min(100, (int)$limit));
  $offset = max(0, (int)$offset);
  $sql = "
    SELECT id, total, created_at
    FROM encomendas
    WHERE user_id = ?
    ORDER BY created_at DESC
    LIMIT {$limit} OFFSET {$offset}
  ";
  $st = db()->prepare($sql);
  $st->execute([$userId]);
  return $st->fetchAll();
}
function orders_generate_number(int $userId): string
{
    return 'EN' . date('YmdHis') . '-' . $userId;
}

/**
 * Cria uma encomenda a partir do carrinho actual.
 *
 * @param int   $userId
 * @param array $cliente  Dados de contacto/morada
 * @param array $cart     Resultado de cart_get()
 * @param float $subtotal
 * @param float $desconto
 * @param float $portes
 * @param float $total
 *
 * @return int ID da encomenda criada
 */
function orders_create_from_cart(
  int $userId,
  array $cliente,
  array $cart,
  float $subtotal,
  float $desconto,
  float $portes,
  float $total
): int {
  $pdo = db();
  $pdo->beginTransaction();
  try {
    $numero = orders_generate_number($userId);
    $stmt = $pdo->prepare(
      'INSERT INTO encomendas
         (user_id,
          nome_destinatario,
          telefone,
          morada_linha1,
          morada_linha2,
          cod_postal,
          localidade,
          distrito,
          pais,
          subtotal,
          desconto_total,
          portes,
          total)
       VALUES
         (:user_id,
          :nome_destinatario,
          :telefone,
          :morada_linha1,
          :morada_linha2,
          :cod_postal,
          :localidade,
          :distrito,
          :pais,
          :subtotal,
          :desconto_total,
          :portes,
          :total)'
    );
    $nomeDest = trim(
      ($cliente['nome'] ?? '') .
      (' ' . ($cliente['apelido'] ?? ''))
    );
    $stmt->execute([
      ':user_id'           => $userId,
      ':nome_destinatario' => $nomeDest,
      ':telefone'          => $cliente['telefone']      ?? '',
      ':morada_linha1'     => $cliente['morada_linha1'] ?? '',
      ':morada_linha2'     => $cliente['morada_linha2'] ?? '',
      ':cod_postal'        => $cliente['cod_postal']    ?? '',
      ':localidade'        => $cliente['localidade']    ?? '',
      ':distrito'          => $cliente['distrito']      ?? '',
      ':pais'              => $cliente['pais']          ?? 'Portugal',
      ':subtotal'          => $subtotal,
      ':desconto_total'    => $desconto,
      ':portes'            => $portes,
      ':total'             => $total,
    ]);

    $orderId = (int)$pdo->lastInsertId();
    $stmtItem = $pdo->prepare(
      'INSERT INTO encomendas_itens
         (encomenda_id,
          produto_id,
          nome_produto,
          slug_produto,
          caminho_imagem,
          tipo_venda,
          preco_unitario,
          quantidade,
          total_linha)
       VALUES
         (:encomenda_id,
          :produto_id,
          :nome_produto,
          :slug_produto,
          :caminho_imagem,
          :tipo_venda,
          :preco_unitario,
          :quantidade,
          :total_linha)'
    );
    foreach ($cart as $item) {
      $qty = (int)($item['qty'] ?? 0);
      if ($qty <= 0) {
        continue;
      }
      $precoUnit  = (float)($item['preco'] ?? 0.0);
      $totalLinha = $precoUnit * $qty;
      $stmtItem->execute([
        ':encomenda_id'   => $orderId,
        ':produto_id'     => (int)($item['id'] ?? 0),
        ':nome_produto'   => (string)($item['nome'] ?? ''),
        ':slug_produto'   => (string)($item['slug'] ?? ''),
        ':caminho_imagem' => (string)($item['imagem'] ?? ''),
        ':tipo_venda'     => (string)($item['tipo_venda'] ?? 'unidade'),
        ':preco_unitario' => $precoUnit,
        ':quantidade'     => $qty,
        ':total_linha'    => $totalLinha,
      ]);
    }
    $pdo->commit();
    return $orderId;
  } catch (\Throwable $e) {
    $pdo->rollBack();
    throw $e;
  }
}
