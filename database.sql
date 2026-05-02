-- ============================================================
-- GameVault Management System - Database Setup Script
-- Run this entire file in phpMyAdmin or MySQL Workbench
-- ============================================================

-- 1. Create and select the database
CREATE DATABASE IF NOT EXISTS gamevault_db;
USE gamevault_db;

-- 2. Users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('user', 'admin') DEFAULT 'user',
    status ENUM('pending', 'active') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. Games table
CREATE TABLE IF NOT EXISTS games (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    genre VARCHAR(50) NOT NULL,
    platform VARCHAR(50) NOT NULL,
    release_date DATE,
    price DECIMAL(10, 2) NOT NULL,
    image_path VARCHAR(255) DEFAULT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Wishlist table (session-based, but kept for future DB persistence)
CREATE TABLE IF NOT EXISTS wishlist (
    user_id INT,
    game_id INT,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, game_id),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (game_id) REFERENCES games(id) ON DELETE CASCADE
);

-- 5. Purchases table (tracks sales for Admin analytics)
CREATE TABLE IF NOT EXISTS purchases (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    game_id INT NOT NULL,
    price_at_purchase DECIMAL(10, 2) NOT NULL,
    purchase_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (game_id) REFERENCES games(id) ON DELETE CASCADE
);

-- ============================================================
-- OPTIONAL: Seed some sample games to get started
-- ============================================================
INSERT INTO games (title, genre, platform, release_date, price) VALUES
('The Witcher 3', 'RPG', 'PC', '2015-05-19', 29.99),
('Elden Ring', 'Action RPG', 'PC', '2022-02-25', 59.99),
('Minecraft', 'Sandbox', 'PC', '2011-11-18', 26.95);

-- ============================================================
-- HOW TO MAKE AN ADMIN ACCOUNT:
-- 1. Register normally on the website.
-- 2. Then run this query (replace the email with yours):
--    UPDATE users SET role = 'admin' WHERE email = 'your@email.com';
-- ============================================================
