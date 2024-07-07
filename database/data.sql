-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.32-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table myplayc.category_of_intrest
CREATE TABLE IF NOT EXISTS `category_of_intrest` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL,
  `news_type_ids` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_category_of_intrest_users` (`user_id`),
  CONSTRAINT `FK_category_of_intrest_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table myplayc.category_of_intrest: ~0 rows (approximately)

-- Dumping structure for table myplayc.company
CREATE TABLE IF NOT EXISTS `company` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  `email` varchar(200) NOT NULL,
  `headquarters` varchar(200) NOT NULL,
  `address` text NOT NULL,
  `phone` varchar(50) NOT NULL,
  `website` varchar(50) DEFAULT NULL,
  `logo_url` text DEFAULT NULL,
  `identity_url` text DEFAULT NULL,
  `industry_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `deleted` int(11) NOT NULL DEFAULT 0,
  `status` enum('Pending','Approved','Rejected') NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  KEY `FK__users` (`user_id`),
  CONSTRAINT `FK__users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table myplayc.company: ~0 rows (approximately)

-- Dumping structure for table myplayc.company_page
CREATE TABLE IF NOT EXISTS `company_page` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `company_id` bigint(20) NOT NULL,
  `privacy_policy` text NOT NULL,
  `banner_url` text NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_company_page_company` (`company_id`),
  CONSTRAINT `FK_company_page_company` FOREIGN KEY (`company_id`) REFERENCES `company` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table myplayc.company_page: ~0 rows (approximately)

-- Dumping structure for table myplayc.gender
CREATE TABLE IF NOT EXISTS `gender` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table myplayc.gender: ~3 rows (approximately)
INSERT INTO `gender` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'Male', '2024-05-14 19:53:09', NULL),
	(2, 'Female', '2024-05-14 19:53:20', NULL),
	(3, 'Rather not say', '2024-05-14 19:53:31', NULL);

-- Dumping structure for table myplayc.news_comments
CREATE TABLE IF NOT EXISTS `news_comments` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `news_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `comment` text NOT NULL,
  `deleted` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_news_comments_news_posts` (`news_id`),
  KEY `FK_news_comments_users` (`user_id`),
  CONSTRAINT `FK_news_comments_news_posts` FOREIGN KEY (`news_id`) REFERENCES `news_posts` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_news_comments_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table myplayc.news_comments: ~0 rows (approximately)

-- Dumping structure for table myplayc.news_posts
CREATE TABLE IF NOT EXISTS `news_posts` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `page_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `news_type_id` bigint(20) NOT NULL,
  `details` text DEFAULT NULL,
  `image_url` text DEFAULT NULL,
  `likes` bigint(20) DEFAULT NULL,
  `dislikes` bigint(20) DEFAULT NULL,
  `deleted` int(11) DEFAULT 0,
  `created_at` date DEFAULT NULL,
  `updated_at` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_news_posts_users` (`user_id`),
  KEY `FK_news_posts_company_page` (`page_id`),
  CONSTRAINT `FK_news_posts_company_page` FOREIGN KEY (`page_id`) REFERENCES `company_page` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_news_posts_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table myplayc.news_posts: ~0 rows (approximately)

-- Dumping structure for table myplayc.news_type
CREATE TABLE IF NOT EXISTS `news_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table myplayc.news_type: ~4 rows (approximately)
INSERT INTO `news_type` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'Technology', '2024-05-14 21:21:49', NULL),
	(2, 'Religious', '2024-05-14 21:21:57', NULL),
	(3, 'Political News', '2024-05-14 21:22:27', NULL),
	(4, 'Business', '2024-05-14 21:22:34', NULL);

-- Dumping structure for table myplayc.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `dob` date NOT NULL,
  `gender` bigint(20) DEFAULT NULL,
  `role_id` bigint(20) DEFAULT 1,
  `email` varchar(200) NOT NULL,
  `phone` bigint(20) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` text DEFAULT NULL,
  `status_id` bigint(20) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `username` (`username`),
  KEY `FK_users_gender` (`gender`),
  KEY `FK_users_user_status` (`status_id`),
  KEY `FK_users_user_roles` (`role_id`),
  CONSTRAINT `FK_users_gender` FOREIGN KEY (`gender`) REFERENCES `gender` (`id`) ON UPDATE NO ACTION,
  CONSTRAINT `FK_users_user_roles` FOREIGN KEY (`role_id`) REFERENCES `user_roles` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_users_user_status` FOREIGN KEY (`status_id`) REFERENCES `user_status` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table myplayc.users: ~1 rows (approximately)
INSERT INTO `users` (`id`, `first_name`, `last_name`, `dob`, `gender`, `role_id`, `email`, `phone`, `username`, `password`, `status_id`, `created_at`, `updated_at`) VALUES
	(1, 'Chemist', 'Mudavanhu', '2024-05-14', 1, 1, 'chem@gmail.com', 68778778, 'chem001', '$2y$10$brmf4G4HqoYzBAWFM47QauFEM7h2Zi4xfznlk53ceE09MXqKEb/4W', 1, '2024-05-14 21:49:53', '2024-05-15 01:18:20');

-- Dumping structure for table myplayc.user_roles
CREATE TABLE IF NOT EXISTS `user_roles` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table myplayc.user_roles: ~2 rows (approximately)
INSERT INTO `user_roles` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'General User', '2024-05-14 20:06:27', NULL),
	(2, 'Admin', '2024-05-14 20:06:57', NULL);

-- Dumping structure for table myplayc.user_status
CREATE TABLE IF NOT EXISTS `user_status` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table myplayc.user_status: ~3 rows (approximately)
INSERT INTO `user_status` (`id`, `name`, `created_at`, `updated_at`) VALUES
	(1, 'Active', '2024-05-14 19:55:52', NULL),
	(2, 'InActive', '2024-05-14 19:56:06', NULL),
	(3, 'Deleted', '2024-05-14 19:56:12', NULL);

-- Dumping structure for view myplayc.viewusers
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `viewusers` (
	`id` BIGINT(20) NOT NULL,
	`first_name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`last_name` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_general_ci',
	`dob` DATE NOT NULL,
	`gender` BIGINT(20) NULL,
	`role_id` BIGINT(20) NULL,
	`email` VARCHAR(200) NOT NULL COLLATE 'utf8mb4_general_ci',
	`phone` BIGINT(20) NULL,
	`username` VARCHAR(50) NULL COLLATE 'utf8mb4_general_ci',
	`password` TEXT NULL COLLATE 'utf8mb4_general_ci',
	`status_id` BIGINT(20) NULL,
	`created_at` DATETIME NULL,
	`updated_at` DATETIME NULL,
	`roleName` VARCHAR(50) NULL COLLATE 'utf8mb4_general_ci',
	`statusName` VARCHAR(50) NULL COLLATE 'utf8mb4_general_ci'
) ENGINE=MyISAM;

-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `viewusers`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `viewusers` AS SELECT a.*,b.name AS roleName,c.name AS statusName FROM users a JOIN user_roles b ON b.id=a.role_id JOIN user_status c ON c.id=a.status_id ;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
