-- ============================================================
-- GameVault Management System - Database Setup Script
-- Generated from phpMyAdmin | MariaDB 10.4 / MySQL 8 compatible
-- Run this entire file in phpMyAdmin or MySQL Workbench
-- ============================================================

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- 1. Create and select the database
CREATE DATABASE IF NOT EXISTS `gamevault_db`;
USE `gamevault_db`;

-- --------------------------------------------------------
-- Table: users
-- --------------------------------------------------------
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','admin') DEFAULT 'user',
  `status` enum('pending','active') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- Table: games
-- --------------------------------------------------------
CREATE TABLE `games` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(100) NOT NULL,
  `genre` varchar(50) NOT NULL,
  `platform` varchar(50) NOT NULL,
  `release_date` date DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- Table: wishlist
-- --------------------------------------------------------
CREATE TABLE `wishlist` (
  `user_id` int(11) NOT NULL,
  `game_id` int(11) NOT NULL,
  `added_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`user_id`,`game_id`),
  KEY `game_id` (`game_id`),
  CONSTRAINT `wishlist_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `wishlist_ibfk_2` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- Table: purchases
-- --------------------------------------------------------
CREATE TABLE `purchases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `game_id` int(11) NOT NULL,
  `price_at_purchase` decimal(10,2) NOT NULL,
  `purchase_date` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `game_id` (`game_id`),
  CONSTRAINT `purchases_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `purchases_ibfk_2` FOREIGN KEY (`game_id`) REFERENCES `games` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------
-- Sample Games (optional starter data)
-- --------------------------------------------------------
INSERT INTO `games` (`title`, `genre`, `platform`, `release_date`, `price`, `image_path`) VALUES
('GTA V', 'Action', 'Steam', '2015-04-14', 29.99, 'images/Gta5.jpg'),
('Minecraft', 'Sandbox', 'PC', '2011-11-18', 26.95, 'images/minecraft.avif'),
('Elden Ring', 'Action RPG', 'PC', '2022-02-25', 59.99, 'images/elden-ring.webp'),
('Red Dead Redemption 2', 'Action Adventure', 'Steam', '2019-12-05', 59.99, 'images/Red Dead Redemption 2.jpg'),
('The Witcher 3: Wild Hunt', 'RPG', 'PC', '2015-05-19', 29.99, 'images/The Witcher3Wild Hunt.jpg'),
('Cyberpunk 2077', 'Action RPG', 'Steam', '2020-12-10', 39.99, 'images/Cyberpunk 2077.jpg'),
('Baldur''s Gate 3', 'RPG', 'PC', '2023-08-03', 59.99, 'images/Baldur''s Gate 3.jpg'),
('Hogwarts Legacy', 'Action RPG', 'Steam', '2023-02-10', 49.99, 'images/Hogwarts Legacy.jpg'),
('God of War', 'Action Adventure', 'PC', '2022-01-14', 39.99, 'images/God of War.jpg'),
('Spider-Man Remastered', 'Action Adventure', 'PC', '2022-08-12', 59.99, 'images/Spider-Man Remastered.jpg'),
('Stardew Valley', 'Simulation', 'PC', '2016-02-26', 14.99, 'images/Stardew Valley.avif'),
('Hollow Knight', 'Metroidvania', 'PC', '2017-02-24', 14.99, 'images/Hollow Knight.jpg'),
('Celeste', 'Platformer', 'PC', '2018-01-25', 19.99, 'images/Celeste.png'),
('Hades', 'Roguelike', 'PC', '2020-09-17', 24.99, 'images/Hades.jpg'),
('Doom Eternal', 'FPS', 'Steam', '2020-03-20', 39.99, 'images/Doom eternal.jpg'),
('Sekiro: Shadows Die Twice', 'Action RPG', 'PC', '2019-03-22', 59.99, 'images/SekiroShadows Die Twice.jpg'),
('Dark Souls III', 'Action RPG', 'PC', '2016-04-12', 59.99, 'images/Dark Souls III.jpg'),
('Persona 5 Royal', 'JRPG', 'PC', '2022-10-21', 59.99, 'images/Persona 5 Royal.jpg'),
('Disco Elysium', 'RPG', 'PC', '2019-10-15', 39.99, 'images/Disco Elysium.jpg'),
('Divinity: Original Sin 2', 'RPG', 'PC', '2017-09-14', 44.99, 'images/DivinityOriginal Sin 2.jpg'),
('Counter-Strike 2', 'FPS', 'Steam', '2023-09-27', 0.00, 'images/Counter-Strike 2.jpg'),
('Valorant', 'Tactical Shooter', 'PC', '2020-06-02', 0.00, 'images/Valorant.png'),
('League of Legends', 'MOBA', 'PC', '2009-10-27', 0.00, 'images/League of Legends.png'),
('Fortnite', 'Battle Royale', 'PC', '2017-07-21', 0.00, 'images/Fortnite.jpg'),
('Apex Legends', 'Battle Royale', 'Steam', '2019-02-04', 0.00, 'images/Apex Legends.jpg'),
('Overwatch 2', 'Hero Shooter', 'PC', '2022-10-04', 0.00, 'images/Overwatch 2.png'),
('FIFA 24', 'Sports', 'Steam', '2023-09-29', 49.99, 'images/FIFA 24.jpg'),
('NBA 2K24', 'Sports', 'PC', '2023-09-08', 59.99, 'images/NBA 2K24.jpg'),
('Need for Speed Unbound', 'Racing', 'Steam', '2022-12-02', 59.99, 'images/Need for Speed Unbound.jpg'),
('Forza Horizon 5', 'Racing', 'PC', '2021-11-09', 59.99, 'images/Forza Horizon 5.jpg'),
('Among Us', 'Social Deduction', 'PC', '2018-11-16', 4.99, 'images/Among Us.jpg'),
('It Takes Two', 'Co-op', 'Steam', '2021-03-26', 39.99, 'images/It Takes Two.jpg'),
('Terraria', 'Sandbox', 'PC', '2011-05-16', 9.99, 'images/Terraria.jpg');

COMMIT;

-- ============================================================
-- HOW TO MAKE AN ADMIN ACCOUNT:
-- 1. Register normally on the website.
-- 2. Then run this query (replace with your email):
--    UPDATE users SET role = 'admin' WHERE email = 'your@email.com';
-- ============================================================

-- Admin User Added (Email: admin@gmail.com)
INSERT INTO `users` (`name`, `email`, `password`, `role`, `status`) VALUES
('Admin', 'admin@gmail.com', '$2a$10$U1wH/HxwYI6WXWtq/1ZtNec7S6.Pr0eKTU7mArOR.ePnq5.r.nxv.', 'admin', 'active');

