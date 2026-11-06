<?php

/*Fornece uma função global db() que devolve uma instância singleton de PDO.
Configura a ligação a MySQL (organicos) com utf8mb4 e credenciais root/vazio (ambiente de desenvolvimento).
Activa ERRMODE_EXCEPTION, FETCH_ASSOC e desactiva emulate prepares para segurança e previsibilidade.
Garante que todas as partes da aplicação reutilizam a mesma ligação PDO.
Simplifica todas as chamadas posteriores à base de dados (db()->prepare(...), db()->query(...), etc.).*/

function db(): PDO {
    static $pdo = null;

    if ($pdo) return $pdo;

    // Carregar as credenciais do ficheiro privado
    $config = require __DIR__ . '/../config/db.private.php';

    // Construir a ligação à base de dados
    $dsn = "mysql:host={$config['host']};port={$config['port']};dbname={$config['database']};charset=utf8mb4";

    $pdo = new PDO(
        $dsn,
        $config['username'],
        $config['password'],
        [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
        ]
    );

    return $pdo;
}