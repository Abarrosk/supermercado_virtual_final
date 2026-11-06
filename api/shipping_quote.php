
<?php

/*Exige que o utilizador esteja autenticado (Auth::requireLogin()) e aceita apenas POST.
Valida o CSRF e inclui inc/shipping.php para aceder às funções de cálculo de portes e geocodificação.
Constrói uma morada completa a partir de morada, código postal, localidade e distrito e obtém o carrinho actual.
Recalcula subtotal e desconto, considerando se os produtos estão em promoção, e chama calcular_portes_para_morada() para obter distância e portes.
Responde em JSON com estado (ok/erro), distância em km, portes e todos os totais formatados (subtotal, desconto e total final).*/

require __DIR__ . '/../config/bootstrap.php';

Auth::requireLogin();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo 'Método não permitido';
    exit;
}

$token = $_POST['csrf'] ?? ($_SERVER['HTTP_X_CSRF_TOKEN'] ?? '');
csrf_verify($token);

require_once __DIR__ . '/../inc/shipping.php';

$morada      = trim($_POST['morada']     ?? '');
$distrito    = trim($_POST['distrito']   ?? '');
$localidade  = trim($_POST['localidade'] ?? '');
$cod_postal  = trim($_POST['cod_postal'] ?? '');

$partes = array_filter([
    $morada,
    $cod_postal,
    $localidade,
    $distrito,
    'Portugal',
]);
$moradaCompleta = implode(', ', $partes);

$cart = cart_get();

$agora    = new DateTimeImmutable('now');
$subtotal = 0.0;
$desconto = 0.0;

foreach ($cart as $item) {
    $produto = product_by_id($item['id']);
    if (!$produto) {
        continue;
    }

    $precoBase  = (float)$produto['preco'];
    $qty        = (int)$item['qty'];

    $promoAtiva = ((int)$produto['promocao'] === 1)
        && (empty($produto['promocao_ate']) || new DateTimeImmutable($produto['promocao_ate']) >= $agora);

    $precoFinal = ($promoAtiva && $produto['preco_com_promocao'] !== null)
        ? (float)$produto['preco_com_promocao']
        : $precoBase;

    $subtotal += $precoBase * $qty;

    $descontoUnit = max(0.0, $precoBase - $precoFinal);
    $desconto    += $descontoUnit * $qty;
}

$portes      = 0.0;
$distanciaKm = null;
$ok          = true;
$erroMsg     = null;

if ($moradaCompleta !== '') {
    try {
        $result      = calcular_portes_para_morada($moradaCompleta);
        $portes      = (float)($result['portes'] ?? 0.0);
        $distanciaKm = $result['distancia_km'] ?? null;
    } catch (\Throwable $e) {
        $ok      = false;
        $erroMsg = 'Não foi possível calcular as taxas de envio.';
        $portes  = 0.0;
    }
}

$total = $subtotal - $desconto + $portes;

header('Content-Type: application/json; charset=utf-8');
echo json_encode([
    'ok'                  => $ok,
    'erro'                => $erroMsg,
    'distancia_km'        => $distanciaKm,
    'portes'              => $portes,
    'portes_formatado'    => money($portes) . '€',
    'subtotal_formatado'  => money($subtotal) . '€',
    'desconto_formatado'  => money($desconto) . '€',
    'total_formatado'     => money($total) . '€',
]);
exit;
