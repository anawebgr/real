-- --------------------------------------------------------
-- Host:                         localhost
-- Server version:               5.7.24 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for thessalonikidb
CREATE DATABASE IF NOT EXISTS `thessalonikidb` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `thessalonikidb`;

-- Dumping structure for view thessalonikidb.spinview
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `spinview` (
	`id` INT(11) NULL,
	`type` VARCHAR(200) NULL COLLATE 'utf8_general_ci',
	`availability` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`location` VARCHAR(100) NULL COLLATE 'utf8_general_ci',
	`sqm` INT(11) NULL,
	`price` FLOAT NULL
) ENGINE=MyISAM;

-- Dumping structure for table thessalonikidb.thessaloniki
CREATE TABLE IF NOT EXISTS `thessaloniki` (
  `thes_id` int(11) DEFAULT NULL,
  `thes_type` varchar(200) DEFAULT NULL,
  `thes_availability` varchar(100) DEFAULT NULL,
  `thes_location` varchar(100) DEFAULT NULL,
  `thes_sqm` int(11) DEFAULT NULL,
  `thes_price` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table thessalonikidb.thessaloniki: ~6 rows (approximately)
/*!40000 ALTER TABLE `thessaloniki` DISABLE KEYS */;
INSERT INTO `thessaloniki` (`thes_id`, `thes_type`, `thes_availability`, `thes_location`, `thes_sqm`, `thes_price`) VALUES
	(3, 'Apartment', 'Sale', 'Thessalloniki', 140, 250000),
	(8, 'Studio, Loft', 'Rent', 'Thessalloniki', 65, 300),
	(9, 'Studio', 'Rent', 'Thessalloniki', 65, 300),
	(10, 'Studio', 'Rent', 'Thessalloniki', 90, 500),
	(16, 'Maisonette, Apartment', 'Sale', 'Thessalloniki', 65, 140000),
	(18, 'Maisonette', 'Rent', 'Thessalloniki', 120, 700);
/*!40000 ALTER TABLE `thessaloniki` ENABLE KEYS */;

-- Dumping structure for view thessalonikidb.spinview
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `spinview`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `spinview` AS select `thessaloniki`.`thes_id` AS `id`,`thessaloniki`.`thes_type` AS `type`,`thessaloniki`.`thes_availability` AS `availability`,`thessaloniki`.`thes_location` AS `location`,`thessaloniki`.`thes_sqm` AS `sqm`,`thessaloniki`.`thes_price` AS `price` from `thessaloniki` order by `thessaloniki`.`thes_sqm`,`thessaloniki`.`thes_price` ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
