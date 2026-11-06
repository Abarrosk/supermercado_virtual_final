-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 11-Dez-2025 às 00:02
-- Versão do servidor: 10.4.32-MariaDB
-- versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `organicos`
--
-- CREATE DATABASE IF NOT EXISTS `organicos` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
-- USE `organicos`;

-- --------------------------------------------------------

--
-- Estrutura da tabela `categorias`
--

DROP TABLE IF EXISTS `categorias`;
CREATE TABLE `categorias` (
  `id` int(10) UNSIGNED NOT NULL,
  `nome` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `categorias`
--

INSERT INTO `categorias` (`id`, `nome`, `slug`) VALUES
(1, 'Frutas e Legumes', 'frutas_legumes'),
(2, 'Lacticínios e Ovos', 'lacticinios_ovos'),
(3, 'Carnes e Aves', 'carnes_aves'),
(4, 'Peixe e Marisco', 'peixe_marisco'),
(5, 'Padaria e Pastelaria', 'padaria_pastelaria'),
(6, 'Conservas', 'conservas'),
(7, 'Massa e Arroz', 'massa_arroz'),
(8, 'Bebidas', 'bebidas'),
(9, 'Especiarias e Temperos', 'especiarias_temperos');

-- --------------------------------------------------------

--
-- Estrutura da tabela `encomendas`
--

DROP TABLE IF EXISTS `encomendas`;
CREATE TABLE `encomendas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `nome_destinatario` varchar(150) NOT NULL,
  `telefone` varchar(30) DEFAULT NULL,
  `morada_linha1` varchar(150) NOT NULL,
  `morada_linha2` varchar(150) DEFAULT NULL,
  `cod_postal` varchar(10) NOT NULL,
  `localidade` varchar(100) NOT NULL,
  `distrito` varchar(100) DEFAULT NULL,
  `pais` varchar(80) NOT NULL DEFAULT 'Portugal',
  `subtotal` decimal(10,2) NOT NULL DEFAULT 0.00,
  `desconto_total` decimal(10,2) NOT NULL DEFAULT 0.00,
  `portes` decimal(10,2) NOT NULL DEFAULT 0.00,
  `total` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `encomendas`
--

INSERT INTO `encomendas` (`id`, `user_id`, `nome_destinatario`, `telefone`, `morada_linha1`, `morada_linha2`, `cod_postal`, `localidade`, `distrito`, `pais`, `subtotal`, `desconto_total`, `portes`, `total`, `created_at`, `updated_at`) VALUES
(1, 5, 'Admin2 Admin2', '910933088', 'Rua Gonçalves Lobato n3 RC D', '', '2720-264', 'Amadora', 'Lisboa', 'Portugal', 29.38, 1.57, 0.00, 27.81, '2025-11-26 22:06:11', '2025-11-26 22:06:11'),
(2, 5, 'Admin2 Admin2', '910933088', 'Rua Gonçalves Lobato', 'N3 RC D', '2720-264', 'Amadora', 'Lisboa', 'Portugal', 7.48, 1.45, 6.00, 12.03, '2025-11-26 22:30:23', '2025-11-26 22:30:23'),
(3, 5, 'Admin2 Admin2', '910933088', 'Rua Gonçalves Lobato', 'N3 RC D', '2720-264', 'Amadora', 'Lisboa', 'Portugal', 7.48, 1.45, 6.00, 12.03, '2025-11-26 22:35:57', '2025-11-26 22:35:57'),
(4, 5, 'Admin2 Admin2', '910933088', 'Rua Gonçalves Lobato', 'N3 RC D', '2720-264', 'Amadora', 'Lisboa', 'Portugal', 13.86, 1.64, 6.00, 18.22, '2025-11-26 22:38:15', '2025-11-26 22:38:15'),
(5, 8, 'Vicente Barros', '910933148', 'Rua Dom Manuel II', '17', '2560-016', 'A-dos-Cunhadois', 'Lisboa', 'Portugal', 3.73, 0.25, 0.00, 3.48, '2025-11-26 22:45:43', '2025-11-26 22:45:43'),
(6, 8, 'Vicente Barros', '910933148', 'Rua Dom Manuel II', '17', '2560-016', 'A-dos-Cunhadois', 'Lisboa', 'Portugal', 25.90, 5.20, 0.00, 20.70, '2025-11-26 23:22:19', '2025-11-26 23:22:19'),
(7, 9, 'Ana Silva', '910100001', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(8, 9, 'Ana Silva', '910100001', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(9, 9, 'Ana Silva', '910100001', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(10, 9, 'Ana Silva', '910100001', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(11, 9, 'Ana Silva', '910100001', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(12, 9, 'Ana Silva', '910100001', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(13, 9, 'Ana Silva', '910100001', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(14, 9, 'Ana Silva', '910100001', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(15, 9, 'Ana Silva', '910100001', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(16, 10, 'João Silva', '910100002', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(17, 10, 'João Silva', '910100002', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(18, 10, 'João Silva', '910100002', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(19, 10, 'João Silva', '910100002', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(20, 10, 'João Silva', '910100002', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(21, 10, 'João Silva', '910100002', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(22, 10, 'João Silva', '910100002', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(23, 10, 'João Silva', '910100002', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(24, 10, 'João Silva', '910100002', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(25, 11, 'Maria Silva', '910100003', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(26, 11, 'Maria Silva', '910100003', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(27, 11, 'Maria Silva', '910100003', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(28, 11, 'Maria Silva', '910100003', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(29, 11, 'Maria Silva', '910100003', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(30, 11, 'Maria Silva', '910100003', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(31, 11, 'Maria Silva', '910100003', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(32, 11, 'Maria Silva', '910100003', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(33, 11, 'Maria Silva', '910100003', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(34, 12, 'Pedro Silva', '910100004', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(35, 12, 'Pedro Silva', '910100004', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(36, 12, 'Pedro Silva', '910100004', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(37, 12, 'Pedro Silva', '910100004', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(38, 12, 'Pedro Silva', '910100004', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(39, 12, 'Pedro Silva', '910100004', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(40, 12, 'Pedro Silva', '910100004', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(41, 12, 'Pedro Silva', '910100004', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(42, 12, 'Pedro Silva', '910100004', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(43, 13, 'Sofia Silva', '910100005', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(44, 13, 'Sofia Silva', '910100005', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(45, 13, 'Sofia Silva', '910100005', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(46, 13, 'Sofia Silva', '910100005', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(47, 13, 'Sofia Silva', '910100005', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(48, 13, 'Sofia Silva', '910100005', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(49, 13, 'Sofia Silva', '910100005', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(50, 13, 'Sofia Silva', '910100005', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(51, 13, 'Sofia Silva', '910100005', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(52, 14, 'Tiago Silva', '910100006', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(53, 14, 'Tiago Silva', '910100006', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(54, 14, 'Tiago Silva', '910100006', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(55, 14, 'Tiago Silva', '910100006', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(56, 14, 'Tiago Silva', '910100006', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(57, 14, 'Tiago Silva', '910100006', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(58, 14, 'Tiago Silva', '910100006', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(59, 14, 'Tiago Silva', '910100006', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(60, 14, 'Tiago Silva', '910100006', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(61, 15, 'Inês Silva', '910100007', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(62, 15, 'Inês Silva', '910100007', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(63, 15, 'Inês Silva', '910100007', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(64, 15, 'Inês Silva', '910100007', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(65, 15, 'Inês Silva', '910100007', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(66, 15, 'Inês Silva', '910100007', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(67, 15, 'Inês Silva', '910100007', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(68, 15, 'Inês Silva', '910100007', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(69, 15, 'Inês Silva', '910100007', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(70, 16, 'Miguel Silva', '910100008', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(71, 16, 'Miguel Silva', '910100008', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(72, 16, 'Miguel Silva', '910100008', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(73, 16, 'Miguel Silva', '910100008', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(74, 16, 'Miguel Silva', '910100008', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(75, 16, 'Miguel Silva', '910100008', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(76, 16, 'Miguel Silva', '910100008', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(77, 16, 'Miguel Silva', '910100008', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(78, 16, 'Miguel Silva', '910100008', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(79, 17, 'Carla Silva', '910100009', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(80, 17, 'Carla Silva', '910100009', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(81, 17, 'Carla Silva', '910100009', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(82, 17, 'Carla Silva', '910100009', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(83, 17, 'Carla Silva', '910100009', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(84, 17, 'Carla Silva', '910100009', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(85, 17, 'Carla Silva', '910100009', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(86, 17, 'Carla Silva', '910100009', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(87, 17, 'Carla Silva', '910100009', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(88, 18, 'Rui Silva', '910100010', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(89, 18, 'Rui Silva', '910100010', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(90, 18, 'Rui Silva', '910100010', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(91, 18, 'Rui Silva', '910100010', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(92, 18, 'Rui Silva', '910100010', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(93, 18, 'Rui Silva', '910100010', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(94, 18, 'Rui Silva', '910100010', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(95, 18, 'Rui Silva', '910100010', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(96, 18, 'Rui Silva', '910100010', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(97, 19, 'Ana Santos', '910100011', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(98, 19, 'Ana Santos', '910100011', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(99, 19, 'Ana Santos', '910100011', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(100, 19, 'Ana Santos', '910100011', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(101, 19, 'Ana Santos', '910100011', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(102, 19, 'Ana Santos', '910100011', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(103, 19, 'Ana Santos', '910100011', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(104, 19, 'Ana Santos', '910100011', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(105, 19, 'Ana Santos', '910100011', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(106, 20, 'João Santos', '910100012', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(107, 20, 'João Santos', '910100012', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(108, 20, 'João Santos', '910100012', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(109, 20, 'João Santos', '910100012', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(110, 20, 'João Santos', '910100012', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(111, 20, 'João Santos', '910100012', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(112, 20, 'João Santos', '910100012', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(113, 20, 'João Santos', '910100012', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(114, 20, 'João Santos', '910100012', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(115, 21, 'Maria Santos', '910100013', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(116, 21, 'Maria Santos', '910100013', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(117, 21, 'Maria Santos', '910100013', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(118, 21, 'Maria Santos', '910100013', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(119, 21, 'Maria Santos', '910100013', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(120, 21, 'Maria Santos', '910100013', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(121, 21, 'Maria Santos', '910100013', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(122, 21, 'Maria Santos', '910100013', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(123, 21, 'Maria Santos', '910100013', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(124, 22, 'Pedro Santos', '910100014', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(125, 22, 'Pedro Santos', '910100014', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(126, 22, 'Pedro Santos', '910100014', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(127, 22, 'Pedro Santos', '910100014', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(128, 22, 'Pedro Santos', '910100014', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(129, 22, 'Pedro Santos', '910100014', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(130, 22, 'Pedro Santos', '910100014', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(131, 22, 'Pedro Santos', '910100014', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(132, 22, 'Pedro Santos', '910100014', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(133, 23, 'Sofia Santos', '910100015', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(134, 23, 'Sofia Santos', '910100015', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(135, 23, 'Sofia Santos', '910100015', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(136, 23, 'Sofia Santos', '910100015', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(137, 23, 'Sofia Santos', '910100015', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(138, 23, 'Sofia Santos', '910100015', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(139, 23, 'Sofia Santos', '910100015', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(140, 23, 'Sofia Santos', '910100015', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(141, 23, 'Sofia Santos', '910100015', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(142, 24, 'Tiago Santos', '910100016', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(143, 24, 'Tiago Santos', '910100016', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(144, 24, 'Tiago Santos', '910100016', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(145, 24, 'Tiago Santos', '910100016', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(146, 24, 'Tiago Santos', '910100016', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(147, 24, 'Tiago Santos', '910100016', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(148, 24, 'Tiago Santos', '910100016', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(149, 24, 'Tiago Santos', '910100016', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(150, 24, 'Tiago Santos', '910100016', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(151, 25, 'Inês Santos', '910100017', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(152, 25, 'Inês Santos', '910100017', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(153, 25, 'Inês Santos', '910100017', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(154, 25, 'Inês Santos', '910100017', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(155, 25, 'Inês Santos', '910100017', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(156, 25, 'Inês Santos', '910100017', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(157, 25, 'Inês Santos', '910100017', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(158, 25, 'Inês Santos', '910100017', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(159, 25, 'Inês Santos', '910100017', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(160, 26, 'Miguel Santos', '910100018', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(161, 26, 'Miguel Santos', '910100018', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(162, 26, 'Miguel Santos', '910100018', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(163, 26, 'Miguel Santos', '910100018', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(164, 26, 'Miguel Santos', '910100018', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(165, 26, 'Miguel Santos', '910100018', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(166, 26, 'Miguel Santos', '910100018', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(167, 26, 'Miguel Santos', '910100018', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(168, 26, 'Miguel Santos', '910100018', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(169, 27, 'Carla Santos', '910100019', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(170, 27, 'Carla Santos', '910100019', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(171, 27, 'Carla Santos', '910100019', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(172, 27, 'Carla Santos', '910100019', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(173, 27, 'Carla Santos', '910100019', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(174, 27, 'Carla Santos', '910100019', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(175, 27, 'Carla Santos', '910100019', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(176, 27, 'Carla Santos', '910100019', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(177, 27, 'Carla Santos', '910100019', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(178, 28, 'Rui Santos', '910100020', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(179, 28, 'Rui Santos', '910100020', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(180, 28, 'Rui Santos', '910100020', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(181, 28, 'Rui Santos', '910100020', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(182, 28, 'Rui Santos', '910100020', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(183, 28, 'Rui Santos', '910100020', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(184, 28, 'Rui Santos', '910100020', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(185, 28, 'Rui Santos', '910100020', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(186, 28, 'Rui Santos', '910100020', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(187, 29, 'Ana Pereira', '910100021', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(188, 29, 'Ana Pereira', '910100021', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(189, 29, 'Ana Pereira', '910100021', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(190, 29, 'Ana Pereira', '910100021', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(191, 29, 'Ana Pereira', '910100021', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(192, 29, 'Ana Pereira', '910100021', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(193, 29, 'Ana Pereira', '910100021', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(194, 29, 'Ana Pereira', '910100021', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(195, 29, 'Ana Pereira', '910100021', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(196, 30, 'João Pereira', '910100022', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(197, 30, 'João Pereira', '910100022', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(198, 30, 'João Pereira', '910100022', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(199, 30, 'João Pereira', '910100022', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(200, 30, 'João Pereira', '910100022', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(201, 30, 'João Pereira', '910100022', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(202, 30, 'João Pereira', '910100022', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(203, 30, 'João Pereira', '910100022', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(204, 30, 'João Pereira', '910100022', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(205, 31, 'Maria Pereira', '910100023', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(206, 31, 'Maria Pereira', '910100023', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(207, 31, 'Maria Pereira', '910100023', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(208, 31, 'Maria Pereira', '910100023', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(209, 31, 'Maria Pereira', '910100023', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(210, 31, 'Maria Pereira', '910100023', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(211, 31, 'Maria Pereira', '910100023', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(212, 31, 'Maria Pereira', '910100023', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(213, 31, 'Maria Pereira', '910100023', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(214, 32, 'Pedro Pereira', '910100024', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(215, 32, 'Pedro Pereira', '910100024', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(216, 32, 'Pedro Pereira', '910100024', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(217, 32, 'Pedro Pereira', '910100024', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(218, 32, 'Pedro Pereira', '910100024', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(219, 32, 'Pedro Pereira', '910100024', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(220, 32, 'Pedro Pereira', '910100024', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(221, 32, 'Pedro Pereira', '910100024', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(222, 32, 'Pedro Pereira', '910100024', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(223, 33, 'Sofia Pereira', '910100025', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(224, 33, 'Sofia Pereira', '910100025', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(225, 33, 'Sofia Pereira', '910100025', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(226, 33, 'Sofia Pereira', '910100025', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(227, 33, 'Sofia Pereira', '910100025', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(228, 33, 'Sofia Pereira', '910100025', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(229, 33, 'Sofia Pereira', '910100025', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(230, 33, 'Sofia Pereira', '910100025', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(231, 33, 'Sofia Pereira', '910100025', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(232, 34, 'Tiago Pereira', '910100026', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(233, 34, 'Tiago Pereira', '910100026', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(234, 34, 'Tiago Pereira', '910100026', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(235, 34, 'Tiago Pereira', '910100026', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(236, 34, 'Tiago Pereira', '910100026', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(237, 34, 'Tiago Pereira', '910100026', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(238, 34, 'Tiago Pereira', '910100026', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(239, 34, 'Tiago Pereira', '910100026', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(240, 34, 'Tiago Pereira', '910100026', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(241, 35, 'Inês Pereira', '910100027', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(242, 35, 'Inês Pereira', '910100027', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(243, 35, 'Inês Pereira', '910100027', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(244, 35, 'Inês Pereira', '910100027', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(245, 35, 'Inês Pereira', '910100027', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(246, 35, 'Inês Pereira', '910100027', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(247, 35, 'Inês Pereira', '910100027', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(248, 35, 'Inês Pereira', '910100027', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(249, 35, 'Inês Pereira', '910100027', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(250, 36, 'Miguel Pereira', '910100028', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(251, 36, 'Miguel Pereira', '910100028', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(252, 36, 'Miguel Pereira', '910100028', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(253, 36, 'Miguel Pereira', '910100028', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(254, 36, 'Miguel Pereira', '910100028', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(255, 36, 'Miguel Pereira', '910100028', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(256, 36, 'Miguel Pereira', '910100028', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(257, 36, 'Miguel Pereira', '910100028', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(258, 36, 'Miguel Pereira', '910100028', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(259, 37, 'Carla Pereira', '910100029', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(260, 37, 'Carla Pereira', '910100029', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(261, 37, 'Carla Pereira', '910100029', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(262, 37, 'Carla Pereira', '910100029', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(263, 37, 'Carla Pereira', '910100029', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(264, 37, 'Carla Pereira', '910100029', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(265, 37, 'Carla Pereira', '910100029', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(266, 37, 'Carla Pereira', '910100029', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(267, 37, 'Carla Pereira', '910100029', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(268, 38, 'Rui Pereira', '910100030', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(269, 38, 'Rui Pereira', '910100030', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(270, 38, 'Rui Pereira', '910100030', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(271, 38, 'Rui Pereira', '910100030', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(272, 38, 'Rui Pereira', '910100030', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(273, 38, 'Rui Pereira', '910100030', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42');
INSERT INTO `encomendas` (`id`, `user_id`, `nome_destinatario`, `telefone`, `morada_linha1`, `morada_linha2`, `cod_postal`, `localidade`, `distrito`, `pais`, `subtotal`, `desconto_total`, `portes`, `total`, `created_at`, `updated_at`) VALUES
(274, 38, 'Rui Pereira', '910100030', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(275, 38, 'Rui Pereira', '910100030', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(276, 38, 'Rui Pereira', '910100030', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(277, 39, 'Ana Costa', '910100031', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(278, 39, 'Ana Costa', '910100031', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(279, 39, 'Ana Costa', '910100031', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(280, 39, 'Ana Costa', '910100031', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(281, 39, 'Ana Costa', '910100031', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(282, 39, 'Ana Costa', '910100031', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(283, 39, 'Ana Costa', '910100031', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(284, 39, 'Ana Costa', '910100031', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(285, 39, 'Ana Costa', '910100031', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(286, 40, 'João Costa', '910100032', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(287, 40, 'João Costa', '910100032', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(288, 40, 'João Costa', '910100032', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(289, 40, 'João Costa', '910100032', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(290, 40, 'João Costa', '910100032', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(291, 40, 'João Costa', '910100032', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(292, 40, 'João Costa', '910100032', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(293, 40, 'João Costa', '910100032', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(294, 40, 'João Costa', '910100032', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(295, 41, 'Maria Costa', '910100033', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(296, 41, 'Maria Costa', '910100033', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(297, 41, 'Maria Costa', '910100033', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(298, 41, 'Maria Costa', '910100033', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(299, 41, 'Maria Costa', '910100033', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(300, 41, 'Maria Costa', '910100033', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(301, 41, 'Maria Costa', '910100033', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(302, 41, 'Maria Costa', '910100033', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(303, 41, 'Maria Costa', '910100033', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(304, 42, 'Pedro Costa', '910100034', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(305, 42, 'Pedro Costa', '910100034', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(306, 42, 'Pedro Costa', '910100034', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(307, 42, 'Pedro Costa', '910100034', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(308, 42, 'Pedro Costa', '910100034', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(309, 42, 'Pedro Costa', '910100034', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(310, 42, 'Pedro Costa', '910100034', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(311, 42, 'Pedro Costa', '910100034', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(312, 42, 'Pedro Costa', '910100034', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(313, 43, 'Sofia Costa', '910100035', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(314, 43, 'Sofia Costa', '910100035', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(315, 43, 'Sofia Costa', '910100035', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(316, 43, 'Sofia Costa', '910100035', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(317, 43, 'Sofia Costa', '910100035', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(318, 43, 'Sofia Costa', '910100035', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(319, 43, 'Sofia Costa', '910100035', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(320, 43, 'Sofia Costa', '910100035', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(321, 43, 'Sofia Costa', '910100035', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(322, 44, 'Tiago Costa', '910100036', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(323, 44, 'Tiago Costa', '910100036', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(324, 44, 'Tiago Costa', '910100036', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(325, 44, 'Tiago Costa', '910100036', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(326, 44, 'Tiago Costa', '910100036', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(327, 44, 'Tiago Costa', '910100036', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(328, 44, 'Tiago Costa', '910100036', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(329, 44, 'Tiago Costa', '910100036', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(330, 44, 'Tiago Costa', '910100036', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(331, 45, 'Inês Costa', '910100037', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(332, 45, 'Inês Costa', '910100037', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(333, 45, 'Inês Costa', '910100037', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(334, 45, 'Inês Costa', '910100037', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(335, 45, 'Inês Costa', '910100037', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(336, 45, 'Inês Costa', '910100037', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(337, 45, 'Inês Costa', '910100037', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(338, 45, 'Inês Costa', '910100037', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(339, 45, 'Inês Costa', '910100037', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(340, 46, 'Miguel Costa', '910100038', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(341, 46, 'Miguel Costa', '910100038', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(342, 46, 'Miguel Costa', '910100038', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(343, 46, 'Miguel Costa', '910100038', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(344, 46, 'Miguel Costa', '910100038', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(345, 46, 'Miguel Costa', '910100038', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(346, 46, 'Miguel Costa', '910100038', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(347, 46, 'Miguel Costa', '910100038', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(348, 46, 'Miguel Costa', '910100038', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(349, 47, 'Carla Costa', '910100039', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(350, 47, 'Carla Costa', '910100039', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(351, 47, 'Carla Costa', '910100039', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(352, 47, 'Carla Costa', '910100039', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(353, 47, 'Carla Costa', '910100039', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(354, 47, 'Carla Costa', '910100039', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(355, 47, 'Carla Costa', '910100039', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(356, 47, 'Carla Costa', '910100039', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(357, 47, 'Carla Costa', '910100039', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(358, 48, 'Rui Costa', '910100040', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(359, 48, 'Rui Costa', '910100040', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(360, 48, 'Rui Costa', '910100040', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(361, 48, 'Rui Costa', '910100040', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(362, 48, 'Rui Costa', '910100040', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(363, 48, 'Rui Costa', '910100040', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(364, 48, 'Rui Costa', '910100040', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(365, 48, 'Rui Costa', '910100040', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(366, 48, 'Rui Costa', '910100040', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(367, 49, 'Ana Rodrigues', '910100041', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(368, 49, 'Ana Rodrigues', '910100041', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(369, 49, 'Ana Rodrigues', '910100041', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(370, 49, 'Ana Rodrigues', '910100041', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(371, 49, 'Ana Rodrigues', '910100041', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(372, 49, 'Ana Rodrigues', '910100041', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(373, 49, 'Ana Rodrigues', '910100041', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(374, 49, 'Ana Rodrigues', '910100041', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(375, 49, 'Ana Rodrigues', '910100041', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(376, 50, 'João Rodrigues', '910100042', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(377, 50, 'João Rodrigues', '910100042', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(378, 50, 'João Rodrigues', '910100042', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(379, 50, 'João Rodrigues', '910100042', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(380, 50, 'João Rodrigues', '910100042', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(381, 50, 'João Rodrigues', '910100042', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(382, 50, 'João Rodrigues', '910100042', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(383, 50, 'João Rodrigues', '910100042', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(384, 50, 'João Rodrigues', '910100042', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(385, 51, 'Maria Rodrigues', '910100043', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(386, 51, 'Maria Rodrigues', '910100043', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(387, 51, 'Maria Rodrigues', '910100043', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(388, 51, 'Maria Rodrigues', '910100043', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(389, 51, 'Maria Rodrigues', '910100043', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(390, 51, 'Maria Rodrigues', '910100043', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(391, 51, 'Maria Rodrigues', '910100043', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(392, 51, 'Maria Rodrigues', '910100043', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(393, 51, 'Maria Rodrigues', '910100043', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(394, 52, 'Pedro Rodrigues', '910100044', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(395, 52, 'Pedro Rodrigues', '910100044', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(396, 52, 'Pedro Rodrigues', '910100044', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(397, 52, 'Pedro Rodrigues', '910100044', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(398, 52, 'Pedro Rodrigues', '910100044', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(399, 52, 'Pedro Rodrigues', '910100044', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(400, 52, 'Pedro Rodrigues', '910100044', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(401, 52, 'Pedro Rodrigues', '910100044', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(402, 52, 'Pedro Rodrigues', '910100044', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(403, 53, 'Sofia Rodrigues', '910100045', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(404, 53, 'Sofia Rodrigues', '910100045', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(405, 53, 'Sofia Rodrigues', '910100045', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(406, 53, 'Sofia Rodrigues', '910100045', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(407, 53, 'Sofia Rodrigues', '910100045', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(408, 53, 'Sofia Rodrigues', '910100045', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(409, 53, 'Sofia Rodrigues', '910100045', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(410, 53, 'Sofia Rodrigues', '910100045', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(411, 53, 'Sofia Rodrigues', '910100045', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(412, 54, 'Tiago Rodrigues', '910100046', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(413, 54, 'Tiago Rodrigues', '910100046', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(414, 54, 'Tiago Rodrigues', '910100046', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(415, 54, 'Tiago Rodrigues', '910100046', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(416, 54, 'Tiago Rodrigues', '910100046', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(417, 54, 'Tiago Rodrigues', '910100046', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(418, 54, 'Tiago Rodrigues', '910100046', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(419, 54, 'Tiago Rodrigues', '910100046', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(420, 54, 'Tiago Rodrigues', '910100046', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(421, 55, 'Inês Rodrigues', '910100047', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(422, 55, 'Inês Rodrigues', '910100047', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(423, 55, 'Inês Rodrigues', '910100047', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(424, 55, 'Inês Rodrigues', '910100047', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(425, 55, 'Inês Rodrigues', '910100047', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(426, 55, 'Inês Rodrigues', '910100047', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(427, 55, 'Inês Rodrigues', '910100047', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(428, 55, 'Inês Rodrigues', '910100047', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(429, 55, 'Inês Rodrigues', '910100047', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(430, 56, 'Miguel Rodrigues', '910100048', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(431, 56, 'Miguel Rodrigues', '910100048', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(432, 56, 'Miguel Rodrigues', '910100048', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(433, 56, 'Miguel Rodrigues', '910100048', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(434, 56, 'Miguel Rodrigues', '910100048', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(435, 56, 'Miguel Rodrigues', '910100048', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(436, 56, 'Miguel Rodrigues', '910100048', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(437, 56, 'Miguel Rodrigues', '910100048', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(438, 56, 'Miguel Rodrigues', '910100048', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(439, 57, 'Carla Rodrigues', '910100049', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(440, 57, 'Carla Rodrigues', '910100049', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(441, 57, 'Carla Rodrigues', '910100049', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(442, 57, 'Carla Rodrigues', '910100049', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(443, 57, 'Carla Rodrigues', '910100049', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(444, 57, 'Carla Rodrigues', '910100049', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(445, 57, 'Carla Rodrigues', '910100049', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(446, 57, 'Carla Rodrigues', '910100049', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(447, 57, 'Carla Rodrigues', '910100049', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(448, 58, 'Rui Rodrigues', '910100050', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(449, 58, 'Rui Rodrigues', '910100050', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(450, 58, 'Rui Rodrigues', '910100050', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(451, 58, 'Rui Rodrigues', '910100050', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(452, 58, 'Rui Rodrigues', '910100050', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(453, 58, 'Rui Rodrigues', '910100050', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(454, 58, 'Rui Rodrigues', '910100050', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(455, 58, 'Rui Rodrigues', '910100050', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(456, 58, 'Rui Rodrigues', '910100050', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(457, 59, 'Ana Almeida', '910100051', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(458, 59, 'Ana Almeida', '910100051', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(459, 59, 'Ana Almeida', '910100051', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(460, 59, 'Ana Almeida', '910100051', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(461, 59, 'Ana Almeida', '910100051', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(462, 59, 'Ana Almeida', '910100051', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(463, 59, 'Ana Almeida', '910100051', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(464, 59, 'Ana Almeida', '910100051', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(465, 59, 'Ana Almeida', '910100051', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(466, 60, 'João Almeida', '910100052', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(467, 60, 'João Almeida', '910100052', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(468, 60, 'João Almeida', '910100052', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(469, 60, 'João Almeida', '910100052', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(470, 60, 'João Almeida', '910100052', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(471, 60, 'João Almeida', '910100052', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(472, 60, 'João Almeida', '910100052', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(473, 60, 'João Almeida', '910100052', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(474, 60, 'João Almeida', '910100052', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(475, 61, 'Maria Almeida', '910100053', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(476, 61, 'Maria Almeida', '910100053', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(477, 61, 'Maria Almeida', '910100053', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(478, 61, 'Maria Almeida', '910100053', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(479, 61, 'Maria Almeida', '910100053', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(480, 61, 'Maria Almeida', '910100053', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(481, 61, 'Maria Almeida', '910100053', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(482, 61, 'Maria Almeida', '910100053', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(483, 61, 'Maria Almeida', '910100053', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(484, 62, 'Pedro Almeida', '910100054', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(485, 62, 'Pedro Almeida', '910100054', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(486, 62, 'Pedro Almeida', '910100054', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(487, 62, 'Pedro Almeida', '910100054', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(488, 62, 'Pedro Almeida', '910100054', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(489, 62, 'Pedro Almeida', '910100054', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(490, 62, 'Pedro Almeida', '910100054', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(491, 62, 'Pedro Almeida', '910100054', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(492, 62, 'Pedro Almeida', '910100054', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(493, 63, 'Sofia Almeida', '910100055', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(494, 63, 'Sofia Almeida', '910100055', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(495, 63, 'Sofia Almeida', '910100055', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(496, 63, 'Sofia Almeida', '910100055', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(497, 63, 'Sofia Almeida', '910100055', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(498, 63, 'Sofia Almeida', '910100055', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(499, 63, 'Sofia Almeida', '910100055', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(500, 63, 'Sofia Almeida', '910100055', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(501, 63, 'Sofia Almeida', '910100055', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(502, 64, 'Tiago Almeida', '910100056', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(503, 64, 'Tiago Almeida', '910100056', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(504, 64, 'Tiago Almeida', '910100056', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(505, 64, 'Tiago Almeida', '910100056', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(506, 64, 'Tiago Almeida', '910100056', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(507, 64, 'Tiago Almeida', '910100056', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(508, 64, 'Tiago Almeida', '910100056', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(509, 64, 'Tiago Almeida', '910100056', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(510, 64, 'Tiago Almeida', '910100056', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(511, 65, 'Inês Almeida', '910100057', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(512, 65, 'Inês Almeida', '910100057', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(513, 65, 'Inês Almeida', '910100057', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(514, 65, 'Inês Almeida', '910100057', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(515, 65, 'Inês Almeida', '910100057', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(516, 65, 'Inês Almeida', '910100057', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(517, 65, 'Inês Almeida', '910100057', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(518, 65, 'Inês Almeida', '910100057', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(519, 65, 'Inês Almeida', '910100057', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(520, 66, 'Miguel Almeida', '910100058', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(521, 66, 'Miguel Almeida', '910100058', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(522, 66, 'Miguel Almeida', '910100058', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(523, 66, 'Miguel Almeida', '910100058', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(524, 66, 'Miguel Almeida', '910100058', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(525, 66, 'Miguel Almeida', '910100058', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(526, 66, 'Miguel Almeida', '910100058', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(527, 66, 'Miguel Almeida', '910100058', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(528, 66, 'Miguel Almeida', '910100058', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(529, 67, 'Carla Almeida', '910100059', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(530, 67, 'Carla Almeida', '910100059', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(531, 67, 'Carla Almeida', '910100059', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(532, 67, 'Carla Almeida', '910100059', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(533, 67, 'Carla Almeida', '910100059', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(534, 67, 'Carla Almeida', '910100059', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(535, 67, 'Carla Almeida', '910100059', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(536, 67, 'Carla Almeida', '910100059', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(537, 67, 'Carla Almeida', '910100059', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(538, 68, 'Rui Almeida', '910100060', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(539, 68, 'Rui Almeida', '910100060', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(540, 68, 'Rui Almeida', '910100060', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(541, 68, 'Rui Almeida', '910100060', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(542, 68, 'Rui Almeida', '910100060', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(543, 68, 'Rui Almeida', '910100060', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(544, 68, 'Rui Almeida', '910100060', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(545, 68, 'Rui Almeida', '910100060', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(546, 68, 'Rui Almeida', '910100060', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', 20.00, 0.00, 3.00, 23.00, '2025-12-09 22:34:42', '2025-12-09 22:34:42'),
(1030, 5, 'Admin2 Admin2', '910933088', 'Rua Gonçalves Lobato', 'N3 RC D', '2720-264', 'Amadora', 'Lisboa', 'Portugal', 5.56, 0.12, 0.00, 5.44, '2025-12-09 23:09:42', '2025-12-09 23:09:42'),
(1031, 4, 'Admin Admin', '967596210', 'Rua da Saudade', 'n3 3D', '4400-158', 'Vila Nova de Gaia', 'Porto', 'Portugal', 4.26, 0.08, 0.00, 4.18, '2025-12-09 23:12:06', '2025-12-09 23:12:06');
INSERT INTO `encomendas` (`id`, `user_id`, `nome_destinatario`, `telefone`, `morada_linha1`, `morada_linha2`, `cod_postal`, `localidade`, `distrito`, `pais`, `subtotal`, `desconto_total`, `portes`, `total`, `created_at`, `updated_at`) VALUES
(1032, 69, 'Teste1 Apelido1', '910988157', 'Rua desta CIdade', 'N63 2D', '2720-475', 'Amadora', 'Lisboa', 'Portugal', 1.98, 0.00, 0.00, 1.98, '2025-12-10 22:55:05', '2025-12-10 22:55:05');

-- --------------------------------------------------------

--
-- Estrutura da tabela `encomendas_itens`
--

DROP TABLE IF EXISTS `encomendas_itens`;
CREATE TABLE `encomendas_itens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `encomenda_id` bigint(20) UNSIGNED NOT NULL,
  `produto_id` int(10) UNSIGNED NOT NULL,
  `nome_produto` varchar(150) NOT NULL,
  `slug_produto` varchar(160) NOT NULL,
  `caminho_imagem` varchar(255) DEFAULT NULL,
  `tipo_venda` enum('unidade','kg','litro','pack','caixa','outro') NOT NULL DEFAULT 'unidade',
  `preco_unitario` decimal(10,2) NOT NULL,
  `quantidade` int(10) UNSIGNED NOT NULL,
  `total_linha` decimal(10,2) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `encomendas_itens`
--

INSERT INTO `encomendas_itens` (`id`, `encomenda_id`, `produto_id`, `nome_produto`, `slug_produto`, `caminho_imagem`, `tipo_venda`, `preco_unitario`, `quantidade`, `total_linha`, `created_at`) VALUES
(1, 1, 6, 'Batata Branca', 'batata-branca', 'images/frutas_legumes/batata-branca.jpg', 'kg', 0.99, 1, 0.99, '2025-11-26 22:06:11'),
(2, 1, 15, 'Iogurte Grego', 'iogurte-grego', 'images/lacticinios_ovos/iogurte-grego.jpg', 'unidade', 0.76, 1, 0.76, '2025-11-26 22:06:11'),
(3, 1, 28, 'Hambúrguer Bovino', 'hamburguer-bovino', 'images/carnes_aves/hamburguer-bovino.jpg', 'pack', 3.59, 1, 3.59, '2025-11-26 22:06:11'),
(4, 1, 33, 'Filetes de Pescada', 'filetes-pescada', 'images/peixe_marisco/filetes-pescada.jpg', 'kg', 7.99, 1, 7.99, '2025-11-26 22:06:11'),
(5, 1, 66, 'Arroz Carolino', 'arroz-carolino', 'images/massa_arroz/arroz-carolino.jpg', 'unidade', 1.09, 1, 1.09, '2025-11-26 22:06:11'),
(6, 1, 26, 'Entrecosto de Porco', 'entrecosto-porco', 'images/carnes_aves/entrecosto-porco.jpg', 'kg', 5.89, 1, 5.89, '2025-11-26 22:06:11'),
(7, 1, 67, 'Arroz Basmati', 'arroz-basmati', 'images/massa_arroz/arroz-basmati.jpg', 'unidade', 1.61, 3, 4.83, '2025-11-26 22:06:11'),
(8, 1, 46, 'Pastel de Nata', 'pastel-nata', 'images/padaria_pastelaria/pastel-nata.jpg', 'unidade', 0.89, 3, 2.67, '2025-11-26 22:06:11'),
(9, 2, 45, 'Croissant Manteiga', 'croissant-manteiga', 'images/padaria_pastelaria/croissant-manteiga.png', 'unidade', 0.84, 1, 0.84, '2025-11-26 22:30:23'),
(10, 2, 20, 'Queijo Amanteigado', 'queijo-amanteigado', 'images/lacticinios_ovos/queijo-amanteigado.jpg', 'unidade', 5.19, 1, 5.19, '2025-11-26 22:30:23'),
(11, 3, 45, 'Croissant Manteiga', 'croissant-manteiga', 'images/padaria_pastelaria/croissant-manteiga.png', 'unidade', 0.84, 1, 0.84, '2025-11-26 22:35:57'),
(12, 3, 20, 'Queijo Amanteigado', 'queijo-amanteigado', 'images/lacticinios_ovos/queijo-amanteigado.jpg', 'unidade', 5.19, 1, 5.19, '2025-11-26 22:35:57'),
(13, 4, 40, 'Mexilhão', 'mexilhao', 'images/peixe_marisco/mexilhao.jpg', 'kg', 3.99, 1, 3.99, '2025-11-26 22:38:15'),
(14, 4, 80, 'Leite Achocolatado', 'leite-achocolatado', 'images/bebidas/leite-achocolatado.jpg', 'unidade', 0.80, 1, 0.80, '2025-11-26 22:38:15'),
(15, 4, 20, 'Queijo Amanteigado', 'queijo-amanteigado', 'images/lacticinios_ovos/queijo-amanteigado.jpg', 'unidade', 5.19, 1, 5.19, '2025-11-26 22:38:15'),
(16, 4, 1, 'Maçã Gala', 'maca-gala', 'images/frutas_legumes/maca-gala.jpg', 'kg', 2.24, 1, 2.24, '2025-11-26 22:38:15'),
(17, 5, 6, 'Batata Branca', 'batata-branca', 'images/frutas_legumes/batata-branca.jpg', 'kg', 0.99, 1, 0.99, '2025-11-26 22:45:43'),
(18, 5, 1, 'Maçã Gala', 'maca-gala', 'images/frutas_legumes/maca-gala.jpg', 'kg', 2.24, 1, 2.24, '2025-11-26 22:45:43'),
(19, 5, 43, 'Carcaça Tradicional', 'carcaca-tradicional', 'images/padaria_pastelaria/carcaca-tradicional.jpg', 'unidade', 0.25, 1, 0.25, '2025-11-26 22:45:43'),
(20, 6, 9, 'Pimento Vermelho', 'pimento-vermelho', 'images/frutas_legumes/pimento-vermelho.jpg', 'kg', 2.07, 10, 20.70, '2025-11-26 23:22:19'),
(21, 1030, 71, 'Água Mineral 1.5L', 'agua-mineral-15l', 'images/bebidas/agua-mineral-15l.jpg', 'unidade', 0.39, 1, 0.39, '2025-12-09 23:09:42'),
(22, 1030, 75, 'Chá Gelado Limão', 'cha-gelado-limao', 'images/bebidas/cha-gelado-limao.jpg', 'unidade', 1.07, 1, 1.07, '2025-12-09 23:09:42'),
(23, 1030, 78, 'Vinho Tinto Mesa', 'vinho-tinto-mesa', 'images/bebidas/vinho-tinto.jpg', 'unidade', 2.99, 1, 2.99, '2025-12-09 23:09:42'),
(24, 1030, 73, 'Sumos Laranja 1L', 'sumo-laranja-1l', 'images/bebidas/sumo-laranja.jpg', 'unidade', 0.99, 1, 0.99, '2025-12-09 23:09:42'),
(25, 1031, 58, 'Azeitonas Pretas', 'azeitonas-pretas', 'images/conservas/azeitonas-pretas.jpg', 'unidade', 1.29, 1, 1.29, '2025-12-09 23:12:06'),
(26, 1031, 56, 'Milho Doce', 'milho-doce', 'images/conservas/milho-doce.jpg', 'unidade', 0.71, 1, 0.71, '2025-12-09 23:12:06'),
(27, 1031, 52, 'Sardinha em Tomate', 'sardinha-tomate', 'images/conservas/sardinha-tomate.jpg', 'unidade', 1.19, 1, 1.19, '2025-12-09 23:12:06'),
(28, 1031, 57, 'Tomate Pelado', 'tomate-pelado', 'images/conservas/tomate-pelado.jpg', 'unidade', 0.99, 1, 0.99, '2025-12-09 23:12:06'),
(29, 1032, 6, 'Batata Branca', 'batata-branca', 'images/frutas_legumes/batata-branca.jpg', 'kg', 0.99, 2, 1.98, '2025-12-10 22:55:05');

-- --------------------------------------------------------

--
-- Estrutura da tabela `produtos`
--

DROP TABLE IF EXISTS `produtos`;
CREATE TABLE `produtos` (
  `id` int(10) UNSIGNED NOT NULL,
  `nome` varchar(150) NOT NULL,
  `slug` varchar(160) NOT NULL,
  `categoria_id` int(10) UNSIGNED NOT NULL,
  `descricao_curta` varchar(255) DEFAULT NULL,
  `descricao_detalhada` text DEFAULT NULL,
  `preco` decimal(10,2) NOT NULL,
  `tipo_venda` enum('unidade','kg','litro','pack','caixa','outro') NOT NULL DEFAULT 'unidade',
  `promocao` tinyint(1) NOT NULL DEFAULT 0,
  `promocao_ate` datetime DEFAULT NULL,
  `valor_promocao` decimal(5,2) DEFAULT NULL,
  `preco_com_promocao` decimal(10,2) DEFAULT NULL,
  `data_produto_adicionado` datetime NOT NULL DEFAULT current_timestamp(),
  `quantidade_em_stock` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `quantidade_vendida` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `caminho_imagem` varchar(255) DEFAULT NULL,
  `numero_reviews` int(10) UNSIGNED NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `produtos`
--

INSERT INTO `produtos` (`id`, `nome`, `slug`, `categoria_id`, `descricao_curta`, `descricao_detalhada`, `preco`, `tipo_venda`, `promocao`, `promocao_ate`, `valor_promocao`, `preco_com_promocao`, `data_produto_adicionado`, `quantidade_em_stock`, `quantidade_vendida`, `caminho_imagem`, `numero_reviews`) VALUES
(1, 'Maçã Gala', 'maca-gala', 1, 'Maçã Gala fresca e doce, ideal para consumo diário.', 'Maçã Gala selecionada de produtores nacionais, com textura crocante e sabor equilibrado, perfeita para snacks, saladas ou sobremesas.', 2.49, 'kg', 1, '2026-09-30 23:59:59', 10.00, 2.24, '2025-01-05 10:00:00', 2, 320, 'images/frutas_legumes/maca-gala.jpg', 120),
(2, 'Banana Madeira', 'banana-madeira', 1, 'Banana da Madeira doce e aromática.', 'Banana de origem Madeira, rica em sabor e nutrientes, ideal para pequenos-almoços, batidos e sobremesas.', 1.79, 'kg', 0, NULL, NULL, NULL, '2025-01-08 10:00:00', 400, 280, 'images/frutas_legumes/banana-madeira.jpg', 95),
(3, 'Laranja do Algarve', 'laranja-algarve', 1, 'Laranja doce do Algarve para sumo e mesa.', 'Laranja fresca do Algarve, sumarenta e doce, perfeita para sumos naturais e consumo direto.', 2.19, 'kg', 1, '2026-03-30 23:59:59', 15.00, 1.86, '2025-01-12 09:30:00', 350, 260, 'images/frutas_legumes/laranja-algarve.jpg', 80),
(4, 'Tomate Cacho', 'tomate-cacho', 1, 'Tomate em cacho maduro e saboroso.', 'Tomate em cacho de produtores locais, ideal para saladas, molhos e pratos do dia-a-dia.', 2.39, 'kg', 0, NULL, NULL, NULL, '2025-01-20 11:15:00', 300, 190, 'images/frutas_legumes/tomate-cacho.jpg', 60),
(5, 'Cenoura Fresca', 'cenoura-fresca', 1, 'Cenoura fresca e crocante.', 'Cenouras frescas ideais para sopas, saladas e snacks saudáveis, ricas em vitamina A.', 1.29, 'kg', 0, NULL, NULL, NULL, '2025-01-18 15:00:00', 280, 150, 'images/frutas_legumes/cenoura-fresca.jpg', 40),
(6, 'Batata Branca', 'batata-branca', 1, 'Batata branca versátil para o dia-a-dia.', 'Batata branca de excelente qualidade, ideal para cozer, assar ou fritar, com ótima conservação.', 0.99, 'kg', 0, NULL, NULL, NULL, '2025-01-10 08:45:00', 600, 400, 'images/frutas_legumes/batata-branca.jpg', 110),
(7, 'Cebola Dourada', 'cebola-dourada', 1, 'Cebola dourada aromática.', 'Cebolas douradas de sabor intenso, perfeitas para refogados, assados e molhos.', 1.09, 'kg', 0, NULL, NULL, NULL, '2025-01-14 14:20:00', 450, 310, 'images/frutas_legumes/cebola-dourada.jpg', 90),
(8, 'Alface Frisada', 'alface-frisada', 1, 'Alface frisada fresca para saladas.', 'Alface frisada crocante e fresca, ideal para saladas variadas e sanduíches.', 1.19, 'unidade', 0, NULL, NULL, NULL, '2025-02-02 09:10:00', 150, 60, 'images/frutas_legumes/alface-frisada.jpg', 25),
(9, 'Pimento Vermelho', 'pimento-vermelho', 1, 'Pimento vermelho doce e carnudo.', 'Pimentos vermelhos selecionados, ideais para grelhar, rechear ou utilizar em salteados.', 2.59, 'kg', 1, '2026-02-28 23:59:59', 20.00, 2.07, '2025-02-05 16:00:00', 220, 130, 'images/frutas_legumes/pimento-vermelho.jpg', 55),
(10, 'Courgette Verde', 'courgette-verde', 1, 'Courgette verde tenra e versátil.', 'Courgettes verdes frescas, perfeitas para grelhados, sopas, salteados e pratos vegetarianos.', 1.89, 'kg', 0, NULL, NULL, NULL, '2025-02-08 12:00:00', 200, 70, 'images/frutas_legumes/courgette-verde.jpg', 30),
(11, 'Leite Meio-Gordo 1L', 'leite-meio-gordo-1l', 2, 'Leite meio-gordo UHT 1L.', 'Leite meio-gordo UHT, origem nacional, ideal para consumo diário, café e receitas.', 0.79, 'litro', 0, NULL, NULL, NULL, '2025-01-03 08:00:00', 800, 500, 'images/lacticinios_ovos/leite.jpg', 140),
(12, 'Queijo Flamengo Fatiado', 'queijo-flamengo-fatiado', 2, 'Queijo flamengo fatiado pronto a servir.', 'Queijo flamengo fatiado, textura suave e sabor ligeiro, perfeito para sanduíches.', 2.49, 'pack', 1, '2026-01-30 23:59:59', 10.00, 2.24, '2025-01-07 09:30:00', 300, 220, 'images/lacticinios_ovos/queijo-flamengo-fatiado.png', 85),
(13, 'Queijo Curado de Cabra', 'queijo-curado-cabra', 2, 'Queijo curado de cabra com sabor intenso.', 'Queijo curado artesanal de cabra, maturação lenta e sabor apurado, ideal para tábuas de queijos.', 5.99, 'unidade', 0, NULL, NULL, NULL, '2025-01-15 11:00:00', 120, 80, 'images/lacticinios_ovos/queijo-cabra-curado.png', 45),
(14, 'Iogurte Natural', 'iogurte-natural', 2, 'Iogurte natural cremoso sem açúcar.', 'Iogurte natural cremoso, perfeito para pequenos-almoços saudáveis, smoothies e sobremesas.', 0.59, 'unidade', 0, NULL, NULL, NULL, '2025-02-01 10:00:00', 500, 260, 'images/lacticinios_ovos/iogurte-natural.jpg', 70),
(15, 'Iogurte Grego', 'iogurte-grego', 2, 'Iogurte grego espesso e rico em proteína.', 'Iogurte grego natural, com textura densa e cremosa, ideal para snacks e sobremesas.', 0.89, 'unidade', 1, '2025-12-31 23:59:59', 15.00, 0.76, '2025-02-04 10:30:00', 400, 280, 'images/lacticinios_ovos/iogurte-grego.jpg', 95),
(16, 'Manteiga com Sal', 'manteiga-com-sal', 2, 'Manteiga com sal para barrar e cozinhar.', 'Manteiga tradicional com sal, sabor equilibrado, ideal para barrar e confeccionar.', 1.79, 'unidade', 0, NULL, NULL, NULL, '2025-01-18 09:00:00', 260, 150, 'images/lacticinios_ovos/manteiga-com-sal.jpg', 50),
(17, 'Margarina Vegetal', 'margarina-vegetal', 2, 'Margarina vegetal cremosa.', 'Margarina vegetal de fácil espalhabilidade, ideal para barrar e cozinhar.', 1.29, 'unidade', 0, NULL, NULL, NULL, '2025-01-22 10:00:00', 240, 120, 'images/lacticinios_ovos/margarina-vegetal.jpg', 30),
(18, 'Ovos Classe M (12 uni)', 'ovos-classe-m-12', 2, 'Ovos classe M em embalagem de 12 unidades.', 'Ovos frescos classe M de galinhas criadas ao ar livre, ideais para uso diário.', 2.19, 'pack', 0, NULL, NULL, NULL, '2025-02-06 08:50:00', 180, 140, 'images/lacticinios_ovos/ovos-classe-m-12.png', 65),
(19, 'Queijo Fresco', 'queijo-fresco', 2, 'Queijo fresco leve e macio.', 'Queijo fresco tradicional, baixo teor de sal, ideal para snacks e saladas.', 1.29, 'unidade', 0, NULL, NULL, NULL, '2025-02-10 09:30:00', 160, 60, 'images/lacticinios_ovos/queijo-fresco.jpg', 25),
(20, 'Queijo Amanteigado', 'queijo-amanteigado', 2, 'Queijo amanteigado de pasta mole.', 'Queijo amanteigado cremoso, perfeito para servir à mesa com pão regional.', 6.49, 'unidade', 1, '2026-02-15 23:59:59', 20.00, 5.19, '2025-02-12 10:10:00', 90, 40, 'images/lacticinios_ovos/queijo-amanteigado.jpg', 35),
(21, 'Peito de Frango', 'peito-frango', 3, 'Peito de frango fresco e magro.', 'Peito de frango fresco, ideal para grelhar, saltear ou assar, alto teor de proteína e baixo em gordura.', 5.49, 'kg', 1, '2026-01-30 23:59:59', 10.00, 4.94, '2025-01-05 09:00:00', 300, 260, 'images/carnes_aves/peito-frango.jpg', 90),
(22, 'Coxas de Frango', 'coxas-frango', 3, 'Coxas de frango suculentas.', 'Coxas de frango tenras, perfeitas para assados e estufados cheios de sabor.', 3.99, 'kg', 0, NULL, NULL, NULL, '2025-01-09 11:00:00', 260, 180, 'images/carnes_aves/coxas-frango.jpg', 55),
(23, 'Bife da Vazia', 'bife-vazia', 3, 'Bife da vazia tenro.', 'Cortes selecionados de vazia de novilho, ideais para grelhar ou fritar.', 14.99, 'kg', 0, NULL, NULL, NULL, '2025-01-14 10:30:00', 150, 90, 'images/carnes_aves/bife-vazia.jpg', 40),
(24, 'Carne Picada Novilho', 'carne-picada-novilho', 3, 'Carne picada de novilho fresca.', 'Carne picada 100% novilho, perfeita para bolonhesa, hambúrgueres caseiros e almôndegas.', 7.49, 'kg', 0, NULL, NULL, NULL, '2025-01-20 14:00:00', 220, 160, 'images/carnes_aves/carne-picada-novilho.jpg', 60),
(25, 'Lombo de Porco', 'lombo-porco', 3, 'Lombo de porco tenro.', 'Lombo de porco fresco, ideal para assados suculentos e bifes grelhados.', 6.99, 'kg', 1, '2025-12-31 23:59:59', 15.00, 5.94, '2025-01-25 10:45:00', 180, 140, 'images/carnes_aves/lombo-porco.jpg', 45),
(26, 'Entrecosto de Porco', 'entrecosto-porco', 3, 'Entrecosto de porco para assar ou grelhar.', 'Entrecosto de porco com a quantidade ideal de gordura para assados saborosos.', 5.89, 'kg', 0, NULL, NULL, NULL, '2025-02-01 13:15:00', 200, 110, 'images/carnes_aves/entrecosto-porco.jpg', 35),
(27, 'Peru em Bifes', 'peru-bifes', 3, 'Bifes de peru magros.', 'Bifes de peru frescos, opção leve e versátil para grelhar ou saltear.', 6.79, 'kg', 0, NULL, NULL, NULL, '2025-02-05 09:20:00', 170, 80, 'images/carnes_aves/bifes-peru.jpg', 30),
(28, 'Hambúrguer Bovino', 'hamburguer-bovino', 3, 'Hambúrguer bovino pronto a cozinhar.', 'Hambúrgueres de carne bovina 100% novilho, temperados ligeiramente, ideais para grelhadores.', 4.49, 'pack', 1, '2026-02-28 23:59:59', 20.00, 3.59, '2025-02-08 12:40:00', 210, 160, 'images/carnes_aves/hamburguer-bovino.jpg', 75),
(29, 'Salsichas Frescas', 'salsichas-frescas', 3, 'Salsichas frescas de porco.', 'Salsichas frescas artesanais, ideais para grelhar ou cozinhar em molhos.', 3.79, 'kg', 0, NULL, NULL, NULL, '2025-02-10 15:00:00', 160, 70, 'images/carnes_aves/salsichas-frescas.jpg', 25),
(30, 'Almôndegas de Novilho', 'almondegas-novilho', 3, 'Almôndegas de novilho prontas a cozinhar.', 'Almôndegas de carne de novilho temperadas, perfeitas para pratos rápidos no forno ou tacho.', 4.29, 'pack', 0, NULL, NULL, NULL, '2025-02-12 11:30:00', 140, 65, 'images/carnes_aves/almondegas-novilho.jpg', 28),
(31, 'Salmão em Postas', 'salmao-postas', 4, 'Postas de salmão fresco.', 'Salmão fresco em postas, rico em ómega-3, ideal para grelhar, assar ou cozinhar no forno.', 14.49, 'kg', 1, '2026-01-30 23:59:59', 10.00, 13.04, '2025-01-06 09:10:00', 180, 140, 'images/peixe_marisco/salmao-postas.jpg', 85),
(32, 'Bacalhau Demolhado', 'bacalhau-demolhado', 4, 'Bacalhau demolhado pronto a cozinhar.', 'Lombos de bacalhau demolhado, textura firme e sabor intenso, pronto para receitas tradicionais.', 11.99, 'kg', 0, NULL, NULL, NULL, '2025-01-11 10:20:00', 160, 120, 'images/peixe_marisco/bacalhau-demolhado.jpg', 60),
(33, 'Filetes de Pescada', 'filetes-pescada', 4, 'Filetes de pescada suaves.', 'Filetes de pescada de textura macia, ideais para crianças e receitas rápidas.', 7.99, 'kg', 0, NULL, NULL, NULL, '2025-01-16 11:30:00', 200, 130, 'images/peixe_marisco/filetes-pescada.jpg', 50),
(34, 'Carapau Fresco', 'carapau-fresco', 4, 'Carapau fresco inteiro.', 'Carapau fresco do dia, ideal para grelhar, assar ou cozer em receitas tradicionais.', 3.49, 'kg', 0, NULL, NULL, NULL, '2025-01-22 08:50:00', 140, 80, 'images/peixe_marisco/carapau-fresco.jpg', 25),
(35, 'Dourada Inteira', 'dourada-inteira', 4, 'Dourada inteira de viveiro.', 'Dourada inteira de viveiro, fresca e pronta para grelhar ou assar.', 8.99, 'kg', 0, NULL, NULL, NULL, '2025-01-25 12:15:00', 130, 75, 'images/peixe_marisco/dourada-inteira.jpg', 30),
(36, 'Robalo Inteiro', 'robalo-inteiro', 4, 'Robalo inteiro fresco.', 'Robalo fresco perfeito para grelhar, de sabor delicado e textura firme.', 9.49, 'kg', 0, NULL, NULL, NULL, '2025-02-01 09:40:00', 120, 65, 'images/peixe_marisco/robalo-inteiro.jpg', 28),
(37, 'Camarão 40/60', 'camarao-40-60', 4, 'Camarão congelado calibre 40/60.', 'Camarão congelado, ideal para mariscadas, arrozes e massas.', 10.99, 'kg', 1, '2026-03-30 23:59:59', 15.00, 9.34, '2025-02-05 10:10:00', 220, 150, 'images/peixe_marisco/camarao-4060.jpg', 70),
(38, 'Miolo de Camarão', 'miolo-camarao', 4, 'Miolo de camarão descascado.', 'Miolo de camarão já descascado, perfeito para salteados, massas e saladas.', 11.49, 'kg', 0, NULL, NULL, NULL, '2025-02-07 11:20:00', 180, 90, 'images/peixe_marisco/miolo-camarao.jpg', 40),
(39, 'Amêijoa', 'ameijoa', 4, 'Amêijoa fresca para mariscadas.', 'Amêijoas frescas ideais para pratos à Bulhão Pato e massas.', 6.99, 'kg', 0, NULL, NULL, NULL, '2025-02-10 12:00:00', 160, 70, 'images/peixe_marisco/ameijoa.jpg', 32),
(40, 'Mexilhão', 'mexilhao', 4, 'Mexilhão fresco.', 'Mexilhão fresco, ideal para cataplanas, arrozes e pratos no forno.', 3.99, 'kg', 0, NULL, NULL, NULL, '2025-02-12 13:30:00', 150, 60, 'images/peixe_marisco/mexilhao.jpg', 26),
(41, 'Pão de Forma Integral', 'pao-forma-integral', 5, 'Pão de forma integral fatiado.', 'Pão de forma integral rico em fibra, ideal para torradas e sanduíches saudáveis.', 1.89, 'unidade', 1, '2026-01-30 23:59:59', 10.00, 1.70, '2025-01-04 08:30:00', 200, 180, 'images/padaria_pastelaria/pao-forma-integral.jpg', 75),
(42, 'Pão de Mistura', 'pao-mistura', 5, 'Pão de mistura de trigo e centeio.', 'Pão tradicional de mistura com crosta estaladiça e miolo fofo.', 1.29, 'unidade', 0, NULL, NULL, NULL, '2025-01-08 09:00:00', 180, 130, 'images/padaria_pastelaria/pao-mistura.png', 40),
(43, 'Carcaça Tradicional', 'carcaca-tradicional', 5, 'Carcaça tradicional fresca.', 'Pãezinhos carcaça ideais para pequenos-almoços e lanches.', 0.25, 'unidade', 0, NULL, NULL, NULL, '2025-01-12 07:30:00', 0, 320, 'images/padaria_pastelaria/carcaca-tradicional.jpg', 55),
(44, 'Baguete', 'baguete', 5, 'Baguete estaladiça.', 'Baguete de inspiração francesa, crosta crocante e miolo leve.', 0.79, 'unidade', 0, NULL, NULL, NULL, '2025-01-18 08:00:00', 220, 150, 'images/padaria_pastelaria/baguete.jpg', 35),
(45, 'Croissant Manteiga', 'croissant-manteiga', 5, 'Croissant de manteiga folhado.', 'Croissant folhado com manteiga, perfeito para acompanhar café ou chá.', 0.99, 'unidade', 1, '2025-12-31 23:59:59', 15.00, 0.84, '2025-01-22 07:45:00', 260, 190, 'images/padaria_pastelaria/croissant-manteiga.png', 80),
(46, 'Pastel de Nata', 'pastel-nata', 5, 'Pastel de nata tradicional.', 'Pastel de nata com massa folhada crocante e creme suave.', 0.89, 'unidade', 0, NULL, NULL, NULL, '2025-02-01 08:10:00', 300, 210, 'images/padaria_pastelaria/pastel-nata.jpg', 90),
(47, 'Bola de Berlim', 'bola-berlim', 5, 'Bola de Berlim com creme.', 'Doce tradicional recheado com creme, perfeito para momentos de indulgência.', 1.10, 'unidade', 0, NULL, NULL, NULL, '2025-02-05 08:20:00', 180, 90, 'images/padaria_pastelaria/bola-berlim.jpg', 35),
(48, 'Bolo de Iogurte', 'bolo-iogurte', 5, 'Bolo de iogurte fofo.', 'Bolo de iogurte caseiro, textura fofa e sabor suave.', 4.50, 'unidade', 0, NULL, NULL, NULL, '2025-02-08 09:00:00', 80, 40, 'images/padaria_pastelaria/bolo-iogurte.png', 22),
(49, 'Queque Simples', 'queque-simples', 5, 'Queque simples individual.', 'Queque tradicional de baunilha, ideal para lanches.', 0.60, 'unidade', 0, NULL, NULL, NULL, '2025-02-10 09:15:00', 220, 85, 'images/padaria_pastelaria/queque-simples.png', 20),
(50, 'Pão de Deus', 'pao-de-deus', 5, 'Pão de Deus com coco.', 'Pão doce coberto com coco e açúcar, fofinho e aromático.', 1.20, 'unidade', 1, '2026-02-28 23:59:59', 10.00, 1.08, '2025-02-12 08:50:00', 150, 70, 'images/padaria_pastelaria/pao-de-deus.jpg', 28),
(51, 'Atum em Azeite', 'atum-azeite', 6, 'Atum em azeite em conserva.', 'Lata de atum em azeite de elevada qualidade, ideal para saladas e sandes.', 1.39, 'unidade', 0, NULL, NULL, NULL, '2025-01-04 11:00:00', 400, 260, 'images/conservas/atum-azeite.jpg', 70),
(52, 'Sardinha em Tomate', 'sardinha-tomate', 6, 'Sardinha em molho de tomate.', 'Conserva de sardinha em molho de tomate, sabor intensa e prática.', 1.19, 'unidade', 0, NULL, NULL, NULL, '2025-01-06 11:30:00', 300, 180, 'images/conservas/sardinha-tomate.jpg', 40),
(53, 'Filetes de Cavala', 'filetes-cavala', 6, 'Filetes de cavala em azeite.', 'Filetes de cavala em azeite, ricos em ómega-3, ideais para refeições rápidas.', 1.59, 'unidade', 0, NULL, NULL, NULL, '2025-01-10 12:00:00', 260, 140, 'images/conservas/filetes-cavala.png', 35),
(54, 'Grão-de-Bico Cozido', 'grao-bico-cozido', 6, 'Grão-de-bico cozido em frasco.', 'Grão-de-bico cozido pronto a servir, ideal para saladas e pratos tradicionais.', 0.89, 'unidade', 0, NULL, NULL, NULL, '2025-01-14 12:30:00', 350, 200, 'images/conservas/grao-bico-cozido.jpg', 50),
(55, 'Feijão Vermelho', 'feijao-vermelho', 6, 'Feijão vermelho cozido.', 'Feijão vermelho cozido em conserva, ideal para guisados e chili.', 0.85, 'unidade', 0, NULL, NULL, NULL, '2025-01-18 13:00:00', 320, 170, 'images/conservas/feijao-vermelho.jpg', 30),
(56, 'Milho Doce', 'milho-doce', 6, 'Milho doce em conserva.', 'Milho doce crocante, perfeito para saladas e acompanhamentos.', 0.79, 'unidade', 1, '2025-12-31 23:59:59', 10.00, 0.71, '2025-01-22 13:30:00', 380, 240, 'images/conservas/milho-doce.jpg', 65),
(57, 'Tomate Pelado', 'tomate-pelado', 6, 'Tomate pelado em lata.', 'Tomate pelado inteiro em molho, ideal para molhos caseiros.', 0.99, 'unidade', 0, NULL, NULL, NULL, '2025-01-26 14:00:00', 340, 190, 'images/conservas/tomate-pelado.jpg', 38),
(58, 'Azeitonas Pretas', 'azeitonas-pretas', 6, 'Azeitonas pretas em salmoura.', 'Azeitonas pretas saborosas para saladas, entradas e pizzas.', 1.29, 'unidade', 0, NULL, NULL, NULL, '2025-02-02 14:30:00', 260, 120, 'images/conservas/azeitonas-pretas.jpg', 25),
(59, 'Azeitonas Verdes', 'azeitonas-verdes', 6, 'Azeitonas verdes descaroçadas.', 'Azeitonas verdes descaroçadas, ideais para petiscos e culinária.', 1.29, 'unidade', 0, NULL, NULL, NULL, '2025-02-05 15:00:00', 260, 130, 'images/conservas/azeitonas-verdes.jpg', 28),
(60, 'Ananás em Calda', 'ananas-calda', 6, 'Rodelas de ananás em calda.', 'Ananás em calda doce, perfeito para sobremesas e cocktails.', 1.89, 'unidade', 1, '2026-02-28 23:59:59', 15.00, 1.61, '2025-02-08 15:30:00', 200, 90, 'images/conservas/ananas-calda.jpg', 22),
(61, 'Esparguete', 'esparguete', 7, 'Esparguete de trigo duro.', 'Esparguete de qualidade superior, cozedura perfeita al dente.', 0.79, 'unidade', 0, NULL, NULL, NULL, '2025-01-03 10:00:00', 500, 300, 'images/massa_arroz/esparguete.jpg', 55),
(62, 'Massa Penne', 'massa-penne', 7, 'Massa penne ranhurada.', 'Penne ideal para pratos de forno e molhos encorpados.', 0.89, 'unidade', 0, NULL, NULL, NULL, '2025-01-07 10:30:00', 450, 260, 'images/massa_arroz/massa-penne.jpg', 40),
(63, 'Massa Fusilli', 'massa-fusilli', 7, 'Massa fusilli em espiral.', 'Fusilli perfeito para saladas frias e pratos do dia-a-dia.', 0.89, 'unidade', 0, NULL, NULL, NULL, '2025-01-11 11:00:00', 430, 240, 'images/massa_arroz/massa-fusilli.jpg', 35),
(64, 'Massa Macarrão', 'massa-macarrao', 7, 'Massa macarrão tradicional.', 'Macarrão versátil para sopas e pratos de massa.', 0.75, 'unidade', 0, NULL, NULL, NULL, '2025-01-15 11:30:00', 420, 210, 'images/massa_arroz/massa-macarrao.jpg', 30),
(65, 'Arroz Agulha', 'arroz-agulha', 7, 'Arroz agulha solto.', 'Arroz agulha que fica solto após a cozedura, ideal para acompanhamentos.', 0.99, 'unidade', 0, NULL, NULL, NULL, '2025-01-19 12:00:00', 380, 250, 'images/massa_arroz/arroz-agulha.jpg', 45),
(66, 'Arroz Carolino', 'arroz-carolino', 7, 'Arroz carolino para pratos cremosos.', 'Arroz carolino ideal para arroz de pato, malandrinho e caldoso.', 1.09, 'unidade', 0, NULL, NULL, NULL, '2025-01-23 12:30:00', 360, 190, 'images/massa_arroz/arroz-carolino.jpg', 32),
(67, 'Arroz Basmati', 'arroz-basmati', 7, 'Arroz basmati aromático.', 'Arroz basmati de grão longo, aroma delicado, ideal para pratos asiáticos.', 1.79, 'unidade', 1, '2026-01-30 23:59:59', 10.00, 1.61, '2025-01-27 13:00:00', 300, 170, 'images/massa_arroz/arroz-basmati.jpg', 38),
(68, 'Arroz Integral', 'arroz-integral', 7, 'Arroz integral rico em fibra.', 'Arroz integral de cozedura firme, opção saudável para o dia-a-dia.', 1.59, 'unidade', 1, '2026-01-28 22:38:00', 15.00, 1.35, '2025-02-02 13:30:00', 350, 140, 'images/massa_arroz/arroz-integral.jpg', 26),
(69, 'Lasanha Seca', 'massa-lasanha', 7, 'Placas de massa para lasanha.', 'Massa seca para lasanha, resistente à cozedura em forno.', 1.49, 'unidade', 0, NULL, NULL, NULL, '2025-02-06 14:00:00', 260, 110, 'images/massa_arroz/massa-lasanha.jpg', 24),
(70, 'Noodles de Trigo', 'noodles-trigo', 7, 'Noodles de trigo rápidos.', 'Noodles de trigo ideais para woks e sopas asiáticas.', 1.29, 'unidade', 0, NULL, NULL, NULL, '2025-02-10 14:30:00', 240, 90, 'images/massa_arroz/noodles-trigo.jpg', 20),
(71, 'Água Mineral 1.5L', 'agua-mineral-15l', 8, 'Água mineral natural 1.5L.', 'Água mineral leve e equilibrada para consumo diário.', 0.39, 'unidade', 0, NULL, NULL, NULL, '2025-01-02 09:00:00', 900, 600, 'images/bebidas/agua-mineral-15l.jpg', 80),
(72, 'Água com Gás', 'agua-gas', 8, 'Água mineral com gás.', 'Água gaseificada refrescante, ideal para acompanhar refeições.', 0.49, 'unidade', 1, '2025-12-27 17:53:00', 15.00, 0.42, '2025-01-06 09:30:00', 547, 260, 'images/bebidas/agua-gas.jpg', 35),
(73, 'Sumos Laranja 1L', 'sumo-laranja-1l', 8, 'Sumo de laranja 1L.', 'Sumo de laranja pasteurizado, sabor equilibrado, ideal para pequenos-almoços.', 0.99, 'unidade', 0, NULL, NULL, NULL, '2025-01-10 10:00:00', 420, 230, 'images/bebidas/sumo-laranja.jpg', 40),
(74, 'Néctar de Pêssego', 'nectar-pessego', 8, 'Néctar de pêssego em embalagem 1L.', 'Néctar de pêssego suave e frutado.', 1.09, 'unidade', 0, NULL, NULL, NULL, '2025-01-14 10:30:00', 380, 200, 'images/bebidas/nectar-pessego.jpg', 32),
(75, 'Chá Gelado Limão', 'cha-gelado-limao', 8, 'Chá gelado sabor limão.', 'Chá gelado refrescante com aroma de limão.', 1.19, 'unidade', 1, '2025-12-31 23:59:59', 10.00, 1.07, '2025-01-18 11:00:00', 360, 210, 'images/bebidas/cha-gelado-limao.jpg', 45),
(76, 'Refrigerante Cola', 'refrigerante-cola', 8, 'Refrigerante sabor cola.', 'Refrigerante clássico cola em garrafa PET.', 1.29, 'unidade', 0, NULL, NULL, NULL, '2025-01-22 11:30:00', 340, 190, 'images/bebidas/refrigerante-cola.png', 38),
(77, 'Cerveja Lager', 'cerveja-lager', 8, 'Cerveja lager 33cl.', 'Cerveja lager leve e refrescante.', 0.79, 'unidade', 0, NULL, NULL, NULL, '2025-02-01 12:00:00', 300, 170, 'images/bebidas/cerveja-lager.jpg', 34),
(78, 'Vinho Tinto Mesa', 'vinho-tinto-mesa', 8, 'Vinho tinto de mesa.', 'Vinho tinto jovem, ideal para refeições diárias.', 2.99, 'unidade', 0, NULL, NULL, NULL, '2025-02-04 12:30:00', 260, 130, 'images/bebidas/vinho-tinto.jpg', 30),
(79, 'Vinho Branco Mesa', 'vinho-branco-mesa', 8, 'Vinho branco de mesa.', 'Vinho branco leve e frutado.', 2.79, 'unidade', 0, NULL, NULL, NULL, '2025-02-08 13:00:00', 240, 120, 'images/bebidas/vinho-branco.jpg', 26),
(80, 'Leite Achocolatado', 'leite-achocolatado', 8, 'Leite achocolatado pronto a beber.', 'Bebida láctea com cacau, apreciada por crianças e adultos.', 0.89, 'unidade', 1, '2026-02-28 23:59:59', 10.00, 0.80, '2025-02-12 13:30:00', 280, 160, 'images/bebidas/leite-achocolatado.jpg', 42),
(81, 'Sal Fino', 'sal-fino', 9, 'Sal fino refinado.', 'Sal fino para temperar todo o tipo de pratos.', 0.39, 'unidade', 0, NULL, NULL, NULL, '2025-01-05 09:00:00', 400, 260, 'images/especiarias_temperos/sal-fino.jpg', 25),
(82, 'Sal Grosso', 'sal-grosso', 9, 'Sal grosso para grelhados.', 'Sal grosso ideal para churrascos e grelhados.', 0.49, 'unidade', 0, NULL, NULL, NULL, '2025-01-08 09:30:00', 350, 210, 'images/especiarias_temperos/sal-grosso.jpg', 22),
(83, 'Pimenta Preta Moída', 'pimenta-preta-moida', 9, 'Pimenta preta moída.', 'Pimenta preta moída aromática para realçar os sabores.', 1.29, 'unidade', 0, NULL, NULL, NULL, '2025-01-12 10:00:00', 260, 140, 'images/especiarias_temperos/pimenta-preta-moida.jpg', 30),
(84, 'Alho em Pó', 'alho-po', 9, 'Alho em pó desidratado.', 'Alho em pó prático para temperar carnes, sopas e molhos.', 0.99, 'unidade', 0, NULL, NULL, NULL, '2025-01-16 10:30:00', 240, 120, 'images/especiarias_temperos/alho-po.jpg', 20),
(85, 'Cebola em Pó', 'cebola-po', 9, 'Cebola em pó desidratada.', 'Cebola em pó prática para temperar diversos pratos.', 0.99, 'unidade', 0, NULL, NULL, NULL, '2025-01-20 11:00:00', 220, 110, 'images/especiarias_temperos/cebola-po.png', 18),
(86, 'Paprika Doce', 'paprika-doce', 9, 'Paprika doce moída.', 'Paprika doce para dar cor e sabor suave a carnes e guisados.', 1.19, 'unidade', 0, NULL, NULL, NULL, '2025-01-24 11:30:00', 210, 105, 'images/especiarias_temperos/paprika-doce.png', 22),
(87, 'Colorau', 'colorau', 9, 'Colorau tradicional.', 'Colorau para temperar e dar cor a pratos típicos.', 0.79, 'unidade', 0, NULL, NULL, NULL, '2025-01-28 12:00:00', 230, 115, 'images/especiarias_temperos/colorau.jpg', 19),
(88, 'Oregãos Secos', 'oregaos', 9, 'Oregãos secos.', 'Oregãos secos aromáticos, ideais para pizzas, massas e molhos.', 0.89, 'unidade', 0, NULL, NULL, NULL, '2025-02-02 12:30:00', 200, 95, 'images/especiarias_temperos/oregaos.jpg', 21),
(89, 'Manjericão Seco', 'manjericao-seco', 9, 'Manjericão seco.', 'Manjericão seco para realçar pratos de massa, tomate e saladas.', 0.89, 'unidade', 0, NULL, NULL, NULL, '2025-02-06 13:00:00', 190, 85, 'images/especiarias_temperos/manjericao.jpg', 18),
(90, 'Mistura Ervas de Provence', 'ervas-provence', 9, 'Mistura de ervas de Provence.', 'Blend aromático de ervas secas para temperar carnes, legumes e assados.', 1.49, 'unidade', 1, '2026-01-30 23:59:59', 10.00, 1.34, '2025-02-10 13:30:00', 170, 80, 'images/especiarias_temperos/ervas-provence.jpg', 24),
(91, 'Queijo Mozarela', 'queijo-mozarela', 2, 'Queijo mozzarella fresco, macio e de sabor suave.', 'Mozzarella fresca, ideal para saladas, pizzas e pratos gratinados.', 1.49, 'kg', 1, '2026-01-09 17:57:00', 15.00, 1.27, '2025-12-04 17:57:32', 274, 0, 'images/lacticinios_ovos/queijo-mozarela.jpg', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `utilizadores`
--

DROP TABLE IF EXISTS `utilizadores`;
CREATE TABLE `utilizadores` (
  `id` int(10) UNSIGNED NOT NULL,
  `nome` varchar(100) NOT NULL,
  `apelido` varchar(100) NOT NULL,
  `email` varchar(190) NOT NULL,
  `telefone` varchar(30) DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  `morada_linha1` varchar(150) DEFAULT NULL,
  `morada_linha2` varchar(150) DEFAULT NULL,
  `cod_postal` varchar(10) DEFAULT NULL,
  `localidade` varchar(100) DEFAULT NULL,
  `distrito` varchar(100) DEFAULT NULL,
  `pais` varchar(80) NOT NULL DEFAULT 'Portugal',
  `password` varchar(255) NOT NULL,
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  `is_deleted` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Extraindo dados da tabela `utilizadores`
--

INSERT INTO `utilizadores` (`id`, `nome`, `apelido`, `email`, `telefone`, `data_nascimento`, `morada_linha1`, `morada_linha2`, `cod_postal`, `localidade`, `distrito`, `pais`, `password`, `is_admin`, `is_deleted`, `created_at`, `updated_at`) VALUES
(4, 'Admin', 'Admin', 'admin.admin@gmail.com', '967596210', '1960-01-01', 'Rua da Saudade', 'n3 3D', '4400-158', 'Vila Nova de Gaia', 'Porto', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$RUZZL2RxMjNQbmkvYzFzag$80wKwd7Ck2Bken1UD1xDmmn4jUcFiMm5u17VNLvgmaM', 1, 0, '2025-11-14 10:42:57', '2025-12-10 22:20:36'),
(5, 'Admin2', 'Admin2', 'admin2.admin2@gmail.com', '910933088', '0000-00-00', 'Rua Gonçalves Lobato', 'N3 RC D', '2720-264', 'Amadora', 'Lisboa', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Y0xzdS5lNXlQdTlPaVVPbw$kTcdAmDYLKTJtUq1oY+lqxiN/jpDSlrj18AIfI2V+k8', 1, 0, '2025-11-14 10:44:45', '2025-12-10 22:40:45'),
(6, 'Andre', 'Barros', 'andre.barros@gmail.com', '910933085', '1960-12-31', 'Rua Gonçalves Lobato', '30 RC D', '2728-269', 'Amadora', 'Lisboa', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-11-14 10:46:15', '2025-12-10 22:20:36'),
(7, 'Tatiana', 'Catarino', 'tatiana.catarino@gmail.com', NULL, '1961-07-01', NULL, NULL, NULL, NULL, NULL, 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$NjZaVzRXY2JyVGpsTS9NQg$yZkofMtTmyoqFPK5WhtYzJYUmMRGuTH4FMaFj4uWOIs', 0, 0, '2025-11-14 10:47:06', '2025-12-10 22:20:36'),
(8, 'Vicente', 'Barros', 'vicente.barros@gmail.com', '910933148', '1961-12-31', 'Rua Dom Manuel II', '17', '2560-016', 'A-dos-Cunhadois', 'Lisboa', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$czAvaWFXVmExMElycDIxSA$8WVAzlNns8oBaM5et7ugQodzfMsJqhGaTAWlCm9VP+s', 0, 0, '2025-11-14 10:47:56', '2025-12-10 22:20:36'),
(9, 'Ana', 'Silva', 'ana.silva@example.com', '910100001', '1962-07-01', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(10, 'João', 'Silva', 'joao.silva@example.com', '910100002', '1962-12-31', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(11, 'Maria', 'Silva', 'maria.silva@example.com', '910100003', '1963-07-01', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(12, 'Pedro', 'Silva', 'pedro.silva@example.com', '910100004', '1963-12-31', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(13, 'Sofia', 'Silva', 'sofia.silva@example.com', '910100005', '1964-06-30', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(14, 'Tiago', 'Silva', 'tiago.silva@example.com', '910100006', '1964-12-30', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(15, 'Inês', 'Silva', 'ines.silva@example.com', '910100007', '1965-06-30', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(16, 'Miguel', 'Silva', 'miguel.silva@example.com', '910100008', '1965-12-30', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(17, 'Carla', 'Silva', 'carla.silva@example.com', '910100009', '1966-06-30', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(18, 'Rui', 'Silva', 'rui.silva@example.com', '910100010', '1966-12-30', 'Rua das Flores 1', '2 Esq', '1000-001', 'Lisboa', 'Lisboa', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(19, 'Ana', 'Santos', 'ana.santos@example.com', '910100011', '1967-06-30', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(20, 'João', 'Santos', 'joao.santos@example.com', '910100012', '1967-12-30', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(21, 'Maria', 'Santos', 'maria.santos@example.com', '910100013', '1968-06-29', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(22, 'Pedro', 'Santos', 'pedro.santos@example.com', '910100014', '1968-12-29', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(23, 'Sofia', 'Santos', 'sofia.santos@example.com', '910100015', '1969-06-29', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(24, 'Tiago', 'Santos', 'tiago.santos@example.com', '910100016', '1969-12-29', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(25, 'Inês', 'Santos', 'ines.santos@example.com', '910100017', '1970-06-29', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(26, 'Miguel', 'Santos', 'miguel.santos@example.com', '910100018', '1970-12-29', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(27, 'Carla', 'Santos', 'carla.santos@example.com', '910100019', '1971-06-29', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(28, 'Rui', 'Santos', 'rui.santos@example.com', '910100020', '1971-12-29', 'Avenida do Mar 10', '3 Dt', '4000-002', 'Porto', 'Porto', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(29, 'Ana', 'Pereira', 'ana.pereira@example.com', '910100021', '1972-06-28', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(30, 'João', 'Pereira', 'joao.pereira@example.com', '910100022', '1972-12-28', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(31, 'Maria', 'Pereira', 'maria.pereira@example.com', '910100023', '1973-06-28', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 1, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(32, 'Pedro', 'Pereira', 'pedro.pereira@example.com', '910100024', '1973-12-28', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(33, 'Sofia', 'Pereira', 'sofia.pereira@example.com', '910100025', '1974-06-28', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(34, 'Tiago', 'Pereira', 'tiago.pereira@example.com', '910100026', '1974-12-28', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(35, 'Inês', 'Pereira', 'ines.pereira@example.com', '910100027', '1975-06-28', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(36, 'Miguel', 'Pereira', 'miguel.pereira@example.com', '910100028', '1975-12-28', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(37, 'Carla', 'Pereira', 'carla.pereira@example.com', '910100029', '1976-06-27', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(38, 'Rui', 'Pereira', 'rui.pereira@example.com', '910100030', '1976-12-27', 'Rua de Coimbra 5', '1 Esq', '3000-003', 'Coimbra', 'Coimbra', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(39, 'Ana', 'Costa', 'ana.costa@example.com', '910100031', '1977-06-27', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(40, 'João', 'Costa', 'joao.costa@example.com', '910100032', '1977-12-27', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(41, 'Maria', 'Costa', 'maria.costa@example.com', '910100033', '1978-06-27', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(42, 'Pedro', 'Costa', 'pedro.costa@example.com', '910100034', '1978-12-27', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(43, 'Sofia', 'Costa', 'sofia.costa@example.com', '910100035', '1979-06-27', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(44, 'Tiago', 'Costa', 'tiago.costa@example.com', '910100036', '1979-12-27', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(45, 'Inês', 'Costa', 'ines.costa@example.com', '910100037', '1980-06-26', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(46, 'Miguel', 'Costa', 'miguel.costa@example.com', '910100038', '1980-12-26', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 1, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(47, 'Carla', 'Costa', 'carla.costa@example.com', '910100039', '1981-06-26', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(48, 'Rui', 'Costa', 'rui.costa@example.com', '910100040', '1981-12-26', 'Rua da Praia 7', 'RC Dto', '8000-004', 'Faro', 'Faro', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 1, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(49, 'Ana', 'Rodrigues', 'ana.rodrigues@example.com', '910100041', '1982-06-26', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(50, 'João', 'Rodrigues', 'joao.rodrigues@example.com', '910100042', '1982-12-26', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(51, 'Maria', 'Rodrigues', 'maria.rodrigues@example.com', '910100043', '1983-06-26', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(52, 'Pedro', 'Rodrigues', 'pedro.rodrigues@example.com', '910100044', '1983-12-26', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(53, 'Sofia', 'Rodrigues', 'sofia.rodrigues@example.com', '910100045', '1984-06-25', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(54, 'Tiago', 'Rodrigues', 'tiago.rodrigues@example.com', '910100046', '1984-12-25', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(55, 'Inês', 'Rodrigues', 'ines.rodrigues@example.com', '910100047', '1985-06-25', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(56, 'Miguel', 'Rodrigues', 'miguel.rodrigues@example.com', '910100048', '1985-12-25', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(57, 'Carla', 'Rodrigues', 'carla.rodrigues@example.com', '910100049', '1986-06-25', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 1, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(58, 'Rui', 'Rodrigues', 'rui.rodrigues@example.com', '910100050', '1986-12-25', 'Largo da Sé 3', '4 Esq', '4700-005', 'Braga', 'Braga', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(59, 'Ana', 'Almeida', 'ana.almeida@example.com', '910100051', '1987-06-25', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(60, 'João', 'Almeida', 'joao.almeida@example.com', '910100052', '2010-01-15', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(61, 'Maria', 'Almeida', 'maria.almeida@example.com', '910100053', '2010-05-20', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(62, 'Pedro', 'Almeida', 'pedro.almeida@example.com', '910100054', '2010-09-10', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 1, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(63, 'Sofia', 'Almeida', 'sofia.almeida@example.com', '910100055', '2011-02-05', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(64, 'Tiago', 'Almeida', 'tiago.almeida@example.com', '910100056', '2011-07-18', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(65, 'Inês', 'Almeida', 'ines.almeida@example.com', '910100057', '2012-03-03', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(66, 'Miguel', 'Almeida', 'miguel.almeida@example.com', '910100058', '2012-11-25', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(67, 'Carla', 'Almeida', 'carla.almeida@example.com', '910100059', '2013-04-30', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(68, 'Rui', 'Almeida', 'rui.almeida@example.com', '910100060', '2014-08-22', 'Alameda Central 9', '5 Dt', '2900-006', 'Setúbal', 'Setúbal', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$Tld5Qk9OT3AzWnhtYTBuWA$mc+CA6BlTGKeShAAPgRVoQkVOkI72j4eIsXw8qbb+d0', 0, 0, '2025-12-09 22:34:24', '2025-12-10 22:20:36'),
(69, 'Teste1', 'Apelido1', 'teste1@gmail.com', '910988157', '2005-02-01', 'Rua desta CIdade', 'N63 2D', '2720-475', 'Amadora', 'Lisboa', 'Portugal', '$argon2id$v=19$m=131072,t=4,p=2$YTRmOFFlcDhVcE11UVNMRA$3zP+wjfVmMTU7g36QhLFOLIeP0LJqVjs17VL8fWMCxA', 0, 0, '2025-12-10 22:42:32', '2025-12-10 22:55:00');

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_categorias_slug` (`slug`),
  ADD UNIQUE KEY `uq_categorias_nome` (`nome`);

--
-- Índices para tabela `encomendas`
--
ALTER TABLE `encomendas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_encomendas_user` (`user_id`);

--
-- Índices para tabela `encomendas_itens`
--
ALTER TABLE `encomendas_itens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_itens_encomenda` (`encomenda_id`),
  ADD KEY `idx_itens_produto` (`produto_id`);

--
-- Índices para tabela `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_produtos_slug` (`slug`),
  ADD KEY `idx_produtos_categoria` (`categoria_id`),
  ADD KEY `idx_produtos_promocao` (`promocao`,`promocao_ate`),
  ADD KEY `idx_produtos_data_adicionado` (`data_produto_adicionado`),
  ADD KEY `idx_produtos_mais_vendidos` (`quantidade_vendida`),
  ADD KEY `idx_produtos_mais_populares` (`numero_reviews`);

--
-- Índices para tabela `utilizadores`
--
ALTER TABLE `utilizadores`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_utilizadores_email` (`email`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `categorias`
--
ALTER TABLE `categorias`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de tabela `encomendas`
--
ALTER TABLE `encomendas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1033;

--
-- AUTO_INCREMENT de tabela `encomendas_itens`
--
ALTER TABLE `encomendas_itens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT de tabela `produtos`
--
ALTER TABLE `produtos`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT de tabela `utilizadores`
--
ALTER TABLE `utilizadores`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `encomendas`
--
ALTER TABLE `encomendas`
  ADD CONSTRAINT `fk_encomendas_user` FOREIGN KEY (`user_id`) REFERENCES `utilizadores` (`id`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `encomendas_itens`
--
ALTER TABLE `encomendas_itens`
  ADD CONSTRAINT `fk_itens_encomenda` FOREIGN KEY (`encomenda_id`) REFERENCES `encomendas` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_itens_produto` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `produtos`
--
ALTER TABLE `produtos`
  ADD CONSTRAINT `fk_produtos_categoria` FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
