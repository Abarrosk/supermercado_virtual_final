<?php
declare(strict_types=1);

/*Declara o ficheiro em strict types e define várias funções de pesquisa.
search_products_by_name() pesquisa produtos pelo nome com LIKE, podendo limitar o número de resultados.
search_orders() pesquisa encomendas por id, email, nome, apelido, telefone e vários campos de morada, devolvendo uma lista ordenada por data.
search_users() pesquisa utilizadores não apagados (is_deleted = 0) por id, nome, apelido, email, telefone e morada (várias colunas).
Em todos os casos usa PDO::prepare() com parâmetros nomeados para evitar SQL injection.*/

/**
 * Pesquisa produtos apenas pelo nome.
 *
 * @param string   $term  Texto a pesquisar.
 * @param int|null $limit Limite de resultados (null = sem limite explícito).
 * @return array
 */
function search_products_by_name(string $term, ?int $limit = null): array {
  $term = trim($term);
  if ($term === '') {
    return [];
  }

  $q = '%' . $term . '%';

  $sql = 'SELECT p.*, c.nome AS categoria_nome
            FROM produtos p
       LEFT JOIN categorias c ON c.id = p.categoria_id
           WHERE p.nome LIKE :q_nome
        ORDER BY p.nome';

  if ($limit !== null) {
    $sql .= ' LIMIT ' . (int)$limit;
  }

  $stmt = db()->prepare($sql);
  $stmt->execute([
    ':q_nome' => $q,
  ]);

  return $stmt->fetchAll();
}

function search_orders(string $term): array {
  $term = trim($term);
  if ($term === '') {
    return [];
  }

  $q = '%' . $term . '%';

  $sql = 'SELECT e.*, u.email
            FROM encomendas e
       LEFT JOIN utilizadores u ON u.id = e.user_id
           WHERE
             CAST(e.id AS CHAR) LIKE :q_id
          OR u.email LIKE :q_email
          OR u.nome LIKE :q_nome
          OR u.apelido LIKE :q_apelido
          OR CONCAT(u.nome, " ", u.apelido) LIKE :q_nome_completo
          OR u.telefone LIKE :q_tel
          OR u.morada_linha1 LIKE :q_morada1
          OR u.cod_postal LIKE :q_cp
          OR u.localidade LIKE :q_localidade
          OR u.distrito LIKE :q_distrito
          OR e.nome_destinatario LIKE :q_dest_nome
          OR e.telefone LIKE :q_dest_tel
          OR e.morada_linha1 LIKE :q_dest_morada1
          OR e.cod_postal LIKE :q_dest_cp
          OR e.localidade LIKE :q_dest_localidade
          OR e.distrito LIKE :q_dest_distrito
        ORDER BY e.created_at DESC';

  $stmt = db()->prepare($sql);
  $stmt->execute([
    ':q_id'              => $q,
    ':q_email'           => $q,
    ':q_nome'            => $q,
    ':q_apelido'         => $q,
    ':q_nome_completo'   => $q,
    ':q_tel'             => $q,
    ':q_morada1'         => $q,
    ':q_cp'              => $q,
    ':q_localidade'      => $q,
    ':q_distrito'        => $q,
    ':q_dest_nome'       => $q,
    ':q_dest_tel'        => $q,
    ':q_dest_morada1'    => $q,
    ':q_dest_cp'         => $q,
    ':q_dest_localidade' => $q,
    ':q_dest_distrito'   => $q,
  ]);

  return $stmt->fetchAll();
}

function search_users(string $term): array {
  $term = trim($term);
  if ($term === '') {
    return [];
  }

  $q = '%' . $term . '%';

  $sql = 'SELECT u.*
            FROM utilizadores u
           WHERE u.is_deleted = 0
             AND (
               CAST(u.id AS CHAR)           LIKE :q_id
            OR u.nome                      LIKE :q_nome
            OR u.apelido                   LIKE :q_apelido
            OR CONCAT(u.nome, " ", u.apelido) LIKE :q_nome_completo
            OR u.email                     LIKE :q_email
            OR u.telefone                  LIKE :q_tel
            OR u.morada_linha1             LIKE :q_morada1
            OR u.cod_postal                LIKE :q_cp
            OR u.localidade                LIKE :q_localidade
            OR u.distrito                  LIKE :q_distrito
             )
        ORDER BY u.created_at DESC, u.id DESC';

  $stmt = db()->prepare($sql);
  $stmt->execute([
    ':q_id'            => $q,
    ':q_nome'          => $q,
    ':q_apelido'       => $q,
    ':q_nome_completo' => $q,
    ':q_email'         => $q,
    ':q_tel'           => $q,
    ':q_morada1'       => $q,
    ':q_cp'            => $q,
    ':q_localidade'    => $q,
    ':q_distrito'      => $q,
  ]);

  return $stmt->fetchAll();
}


