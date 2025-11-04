<?php
// File: config.php
$db_host = 'localhost';
$db_user = 'root';
$db_pass = ''; // Kosongkan jika default XAMPP
$db_name = 'db_spk_laptop';

$conn = new mysqli($db_host, $db_user, $db_pass, $db_name);

if ($conn->connect_error) {
    die("Koneksi Gagal: " . $conn->connect_error);
}
?>