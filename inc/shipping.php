
<?php

/* Define constantes de latitude/longitude de origem (armazém) para cálculo de distâncias.
Implementa haversine_km() para calcular a distância em km entre dois pontos geográficos.
geocode_address() usa o serviço Nominatim (OpenStreetMap) via cURL para converter uma morada em coordenadas (lat/lon).
calcular_portes_para_morada() calcula os portes: até 30 km portes grátis; acima disso cobra 2 € por cada bloco adicional de 5 km.
Devolve um array com distancia_km e portes, usado pelo shipping_quote.php e pelo checkout. */

const SHIPPING_ORIG_LAT = 39.1429993093935;
const SHIPPING_ORIG_LON = -9.29499460919433;
function haversine_km(float $lat1, float $lon1, float $lat2, float $lon2): float
{
    $R = 6371.0;
    $lat1Rad = deg2rad($lat1);
    $lat2Rad = deg2rad($lat2);
    $dLat    = deg2rad($lat2 - $lat1);
    $dLon    = deg2rad($lon2 - $lon1);
    $a = sin($dLat / 2) ** 2
       + cos($lat1Rad) * cos($lat2Rad) * sin($dLon / 2) ** 2;
    $c = 2 * atan2(sqrt($a), sqrt(1 - $a));
    return $R * $c;
}
function geocode_address(string $address): ?array
{
    $address = trim($address);
    if ($address === '') {
        return null;
    }
    $url = 'https://nominatim.openstreetmap.org/search?format=json&limit=1&q='
         . urlencode($address);

    $ch = curl_init($url);
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_TIMEOUT        => 5,
        CURLOPT_USERAGENT      => 'OrganicosCheckout/1.0 (+seu-email@exemplo.com)',
    ]);
    $resp = curl_exec($ch);
    if ($resp === false) {
        curl_close($ch);
        return null;
    }
    $status = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    if ($status !== 200) {
        return null;
    }
    $data = json_decode($resp, true);
    if (!is_array($data) || empty($data[0]['lat']) || empty($data[0]['lon'])) {
        return null;
    }
    return [
        'lat' => (float)$data[0]['lat'],
        'lon' => (float)$data[0]['lon'],
    ];
}
function calcular_portes_para_morada(string $address): array
{
    $coords = geocode_address($address);
    if ($coords === null) {
        return [
            'distancia_km' => 0.0,
            'portes'       => 0.0,
        ];
    }
    $distKm = haversine_km(
        SHIPPING_ORIG_LAT,
        SHIPPING_ORIG_LON,
        $coords['lat'],
        $coords['lon']
    );
    if ($distKm <= 30.0) {
        $portes = 0.0;
    } else {
        $extraKm = $distKm - 30.0;
        $steps   = ceil($extraKm / 5.0);
        $portes  = $steps * 2.0;
    }

    return [
        'distancia_km' => $distKm,
        'portes'       => $portes,
    ];
}
