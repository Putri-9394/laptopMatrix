<?php
// File: api/hitung.php

// 1. Headers untuk REST API (JSON & CORS)
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *"); // Izinkan akses dari mana saja
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

include_once '../config.php'; // Hubungkan ke database

// 2. Ambil data JSON yang dikirim oleh Frontend
$data = json_decode(file_get_contents("php://input"));

// Validasi sederhana
if (
    !isset($data->w_harga) || !isset($data->w_ram) || !isset($data->w_cpu) ||
    !isset($data->w_gpu) || !isset($data->w_ssd) || !isset($data->w_berat)
) {
    http_response_code(400); // Bad Request
    echo json_encode(["message" => "Data bobot tidak lengkap."]);
    exit();
}

// 3. Simpan bobot
$bobot = [
    'harga' => (float) $data->w_harga,
    'ram' => (float) $data->w_ram,
    'cpu' => (float) $data->w_cpu,
    'gpu' => (float) $data->w_gpu,
    'ssd' => (float) $data->w_ssd,
    'berat' => (float) $data->w_berat,
];

try {
    // 4. Ambil data laptop dari database
    $laptops = [];
    $result_laptops = $conn->query("SELECT * FROM laptops");
    while ($row = $result_laptops->fetch_assoc()) {
        $laptops[] = $row;
    }

    if (count($laptops) === 0) {
        http_response_code(404);
        echo json_encode(["message" => "Data laptop kosong."]);
        exit();
    }

    // 5. Cari Nilai Min/Max untuk setiap kriteria
    $min_max = $conn->query("
        SELECT
            MIN(harga) AS min_harga,
            MAX(ram) AS max_ram,
            MAX(skor_cpu) AS max_cpu,
            MAX(skor_gpu) AS max_gpu,
            MAX(ssd) AS max_ssd,
            MIN(berat) AS min_berat
        FROM laptops
    ")->fetch_assoc();

    // 6. Proses Normalisasi (Matriks R) dan Perhitungan Skor (V)
    $hasil_saw = [];

    foreach ($laptops as $laptop) {
        // Normalisasi
        // C1: Harga (Cost)
        $r_harga = $min_max['min_harga'] / $laptop['harga'];
        // C2: RAM (Benefit)
        $r_ram = $laptop['ram'] / $min_max['max_ram'];
        // C3: Skor CPU (Benefit)
        $r_cpu = $laptop['skor_cpu'] / $min_max['max_cpu'];
        // C4: Skor GPU (Benefit)
        $r_gpu = $laptop['skor_gpu'] / $min_max['max_gpu'];
        // C5: SSD (Benefit)
        $r_ssd = $laptop['ssd'] / $min_max['max_ssd'];
        // C6: Berat (Cost)
        $r_berat = $min_max['min_berat'] / $laptop['berat'];

        // Perhitungan Skor V (Weighted Sum)
        $skor_v =
            ($bobot['harga'] * $r_harga) +
            ($bobot['ram'] * $r_ram) +
            ($bobot['cpu'] * $r_cpu) +
            ($bobot['gpu'] * $r_gpu) +
            ($bobot['ssd'] * $r_ssd) +
            ($bobot['berat'] * $r_berat);

        $hasil_saw[] = [
            'nama_laptop' => $laptop['nama_laptop'],
            'skor' => (float) $skor_v,
            // Anda bisa tambahkan detail jika perlu
            // 'detail' => [
            //     'harga' => $laptop['harga'],
            //     'ram' => $laptop['ram']
            // ]
        ];
    }

    // 7. Urutkan hasil dari skor tertinggi ke terendah
    usort($hasil_saw, function ($a, $b) {
        return $b['skor'] <=> $a['skor'];
    });

    // 8. Kembalikan hasil sebagai JSON
    http_response_code(200);
    echo json_encode($hasil_saw);

} catch (Exception $e) {
    http_response_code(500); // Internal Server Error
    echo json_encode(["message" => "Terjadi kesalahan server: " . $e->getMessage()]);
}

$conn->close();
?>