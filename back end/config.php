<?php
// Detail koneksi database (sesuai setting Laragon)
$host = "localhost";    // atau "127.0.0.1"
$username = "root";     // Default username Laragon
$password = "";         // Default password Laragon (kosong)
$db_name = "db_spk_laptop"; // GANTI INI dengan nama database Anda

// Membuat koneksi
$conn = new mysqli($host, $username, $password, $db_name);

// Cek koneksi
if ($conn->connect_error) {
    die("Koneksi Gagal: " . $conn->connect_error);
}

// ... (logika perhitungan SAW Anda selanjutnya ada di sini) ...
// Ambil data laptop dari $conn
// Hitung normalisasi
// Kirim hasil sebagai JSON
?>