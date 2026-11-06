<?php

/*Fornece uma função global db() que devolve uma instância singleton de PDO.
Configura a ligação a MySQL (organicos) com utf8mb4 e credenciais root/vazio (ambiente de desenvolvimento).
Activa ERRMODE_EXCEPTION, FETCH_ASSOC e desactiva emulate prepares para segurança e previsibilidade.
Garante que todas as partes da aplicação reutilizam a mesma ligação PDO.
Simplifica todas as chamadas posteriores à base de dados (db()->prepare(...), db()->query(...), etc.).*/

function db(): PDO {
  static $pdo = null;
  if ($pdo) return $pdo;
  $dsn = 'mysql:host=127.0.0.1;dbname=organicos;charset=utf8mb4';
  $user = 'root';
  $pass = '';
  $pdo = new PDO($dsn, $user, $pass, [
    PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES => false,
  ]);
  return $pdo;
}
