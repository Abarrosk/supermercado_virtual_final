
<?php

/*Inclui o bootstrap e chama Auth::logout() para limpar a sessão do utilizador.
Após o logout, redirecciona para homepage.php.
É um endpoint muito simples, sem HTML próprio.
Garante que a sessão é encerrada de forma consistente com a lógica central de Auth.
Serve como “Sair” no menu da aplicação.*/

require __DIR__ . '/config/bootstrap.php';
Auth::logout();
header('Location: homepage.php');
exit;
