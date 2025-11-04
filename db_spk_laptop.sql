-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 04, 2025 at 11:03 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_spk_laptop`
--

-- --------------------------------------------------------

--
-- Table structure for table `laptops`
--

CREATE TABLE `laptops` (
  `id_laptop` int NOT NULL,
  `nama_laptop` varchar(150) DEFAULT NULL,
  `harga` bigint DEFAULT NULL,
  `ram` int DEFAULT NULL,
  `ssd` int DEFAULT NULL,
  `skor_prosesor` int DEFAULT NULL,
  `skor_gpu` int DEFAULT NULL,
  `berat` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `laptops`
--

INSERT INTO `laptops` (`id_laptop`, `nama_laptop`, `harga`, `ram`, `ssd`, `skor_prosesor`, `skor_gpu`, `berat`) VALUES
(1, 'Acer Aspire 3 Slim (R3-7320U)', 5200000, 8, 512, 5150, 1150, 1.7),
(2, 'Asus Vivobook 14 (i5-1235U)', 8500000, 8, 512, 13450, 2650, 1.4),
(3, 'Dell XPS 13 (i7-1260P)', 21000000, 16, 512, 19800, 2750, 1.2),
(4, 'Lenovo LOQ 15 (i5-13420H/RTX 3050)', 13500000, 8, 512, 22100, 9800, 2.4),
(5, 'Asus ROG Zephyrus G14 (R9-7940HS/RTX 4060)', 27800000, 16, 1024, 30500, 14500, 1.72),
(6, 'Advan Workplus (R7-6800H)', 6999000, 16, 512, 19500, 4200, 1.4),
(7, 'MacBook Air M1 (8-Core GPU)', 11500000, 8, 256, 14200, 4500, 1.29),
(8, 'Lenovo ThinkPad X1 Carbon (i5-1240P)', 25000000, 16, 1024, 15100, 2700, 1.12),
(9, 'HP 14s (i5-1235U)', 6800000, 8, 512, 13300, 2650, 1.46),
(10, 'Acer Swift Go 14 OLED (i5-13500H)', 11200000, 16, 512, 23100, 2900, 1.25),
(11, 'MSI Cyborg 15 (i7-12650H/RTX 4050)', 14100000, 16, 512, 24300, 11800, 2),
(12, 'Microsoft Surface Pro 9 (i5-1235U)', 17900000, 8, 256, 13450, 2650, 0.88),
(13, 'Axioo Pongo 760 (i7-12650H/RTX 3060)', 15300000, 16, 1024, 28900, 13500, 2.2),
(14, 'Samsung Galaxy Book3 (i5-1335U)', 10500000, 8, 512, 15250, 2700, 1.57),
(15, 'Infinix INBook X2 (i7-1065G7)', 5900000, 8, 256, 7900, 2100, 1.24),
(16, 'Asus Zenbook S 13 OLED (i7-1355U)', 18500000, 16, 512, 19550, 2700, 1),
(17, 'Lenovo Legion 5 Pro (R9-7940HS/RTX 4060)', 23000000, 16, 1024, 30500, 14500, 2.5),
(18, 'HP Spectre x360 14 (i7-1355U)', 22500000, 16, 1024, 19800, 2700, 1.36),
(19, 'LG Gram 16 (i5-1340P)', 20500000, 16, 1024, 15100, 2700, 1.19),
(20, 'MacBook Pro 14 M2 Pro (10-Core CPU/16-Core GPU)', 31000000, 16, 512, 26800, 9500, 1.6),
(21, 'Asus TUF Gaming F15 (i5-13420H/RTX 3050)', 16000000, 16, 512, 22100, 9800, 2.2),
(22, 'HP Omen 16 (i7-13700HX/RTX 4060)', 20500000, 16, 1024, 38900, 14500, 2.35),
(23, 'Dell G15 Gaming (i7-13650HX/RTX 3050)', 14800000, 16, 512, 34000, 9800, 2.5),
(24, 'Acer Predator Helios Neo (i9-13900HX/RTX 4060)', 20000000, 16, 1024, 45000, 14500, 2.6),
(25, 'Zyrex Sky 232 (N100)', 3500000, 8, 256, 5150, 850, 1.3),
(26, 'Lenovo Yoga Slim 7 Pro (R7-6800HS)', 17500000, 16, 1024, 24300, 4200, 1.45),
(27, 'MSI Modern 14 (R5-7530U)', 7900000, 8, 512, 16500, 2400, 1.4),
(28, 'Acer Swift 3 (R5-5500U)', 9500000, 16, 512, 16500, 2400, 1.2),
(29, 'HP Envy x360 13 (i5-1335U)', 15500000, 16, 512, 13450, 2700, 1.3),
(30, 'Asus ROG Strix G16 (i7-13650HX/RTX 4070)', 26500000, 16, 1024, 38900, 19000, 2.5),
(31, 'Dell Inspiron 14 (i3-1215U)', 8200000, 8, 512, 10900, 2500, 1.5),
(32, 'Lenovo V14 Gen 3 (i5-1235U)', 6100000, 8, 256, 13300, 2650, 1.6),
(33, 'Asus Vivobook Go 14 (R3-7320U)', 6300000, 8, 256, 8100, 1150, 1.38),
(34, 'HP 15s (i5-1235U)', 7200000, 8, 512, 13300, 2650, 1.69),
(35, 'Axioo Hype 5 (i5-1235U)', 4999000, 8, 512, 13300, 2650, 1.4),
(36, 'Acer Aspire Lite (i5-1235U)', 6500000, 8, 512, 13300, 2650, 1.6),
(37, 'Lenovo IdeaPad Slim 3 (R5-7530U)', 7500000, 8, 512, 16500, 2400, 1.62),
(38, 'Asus Zenbook 14 OLED (i5-1240P)', 14300000, 16, 512, 15100, 2700, 1.39),
(39, 'MSI Prestige 14 Evo (i5-1340P)', 13800000, 16, 512, 15100, 2700, 1.29),
(40, 'Huawei MateBook D 14 (i5-1235U)', 9900000, 16, 512, 13300, 2650, 1.38),
(41, 'Samsung Galaxy Book2 Pro (i5-1240P)', 19500000, 16, 512, 15100, 2700, 0.87),
(42, 'MacBook Air M2 (8-Core GPU)', 16500000, 8, 256, 15600, 5200, 1.24),
(43, 'Dell XPS 15 (i7-13700H/RTX 4060)', 38000000, 16, 1024, 34500, 14500, 1.9),
(44, 'Lenovo ThinkBook 14 (i5-1235U)', 10100000, 16, 512, 13300, 2650, 1.4),
(45, 'HP Pavilion Plus 14 (i5-1240P)', 14200000, 16, 512, 15100, 2700, 1.4),
(46, 'Acer Spin 5 Evo (i5-1240P)', 16900000, 16, 1024, 15100, 2700, 1.3),
(47, 'MSI Katana 15 (i9-13900H/RTX 4060)', 18500000, 16, 1024, 34500, 14500, 2.25),
(48, 'Asus ProArt Studiobook (i9-13980HX/RTX 4070)', 35000000, 32, 1024, 54000, 19000, 2.4),
(49, 'Advan Soulmate (Celeron N4020)', 2500000, 4, 256, 1450, 500, 1.35),
(50, 'Lenovo IdeaPad Gaming 3 (R5-6600H/RTX 3050)', 12300000, 8, 512, 21900, 9800, 2.3),
(51, 'Acer Nitro V 15 (i5-13420H/RTX 4050)', 15000000, 16, 512, 22100, 11800, 2.1),
(52, 'HP Victus 15 (R5-7640HS/RTX 3050)', 14000000, 16, 512, 24000, 9800, 2.3),
(53, 'Asus TUF Gaming A15 (R7-7735HS/RTX 4050)', 17000000, 16, 512, 28000, 11800, 2.2),
(54, 'Dell G16 (i7-13650HX/RTX 4060)', 22000000, 16, 1024, 34000, 14500, 2.7),
(55, 'Lenovo Yoga 7 (R7-7730U)', 13000000, 16, 512, 18000, 2400, 1.4),
(56, 'HP Pavilion 14 (i7-1355U)', 12000000, 16, 1024, 15200, 2700, 1.4),
(57, 'Asus Zenbook 14X OLED (i5-13500H)', 16000000, 16, 512, 23000, 2900, 1.5),
(58, 'Axioo Hype 7 (i7-1255U)', 5999000, 16, 512, 13500, 2650, 1.5),
(59, 'Infinix Zenbook 14 (i5-1235U)', 7000000, 16, 512, 13450, 2650, 1.4),
(60, 'MSI Thin GF63 (i5-12450H/RTX 4050)', 12500000, 8, 512, 17500, 11800, 1.86);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `laptops`
--
ALTER TABLE `laptops`
  ADD PRIMARY KEY (`id_laptop`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `laptops`
--
ALTER TABLE `laptops`
  MODIFY `id_laptop` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
