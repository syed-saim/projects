/*
SQLyog Ultimate v10.00 Beta1
MySQL - 5.5.5-10.4.32-MariaDB : Database - trucking_logistics
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`trucking_logistics` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `trucking_logistics`;

/*Table structure for table `customers` */

DROP TABLE IF EXISTS `customers`;

CREATE TABLE `customers` (
  `CustomerID` int(11) NOT NULL,
  `CompanyName` varchar(100) DEFAULT NULL,
  `ContactPerson` varchar(50) DEFAULT NULL,
  `ContactNumber` varchar(15) DEFAULT NULL,
  `Email` varchar(100) DEFAULT NULL,
  `Address` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`CustomerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `customers` */

insert  into `customers`(`CustomerID`,`CompanyName`,`ContactPerson`,`ContactNumber`,`Email`,`Address`) values (1,'Gul Ahmed','Saim Ali','111-222-3333','saim@gmail.com','123 Main St'),(2,'Engro Corporarion','Abdullah Khalid','444-555-6666','abdullah@gmail.com','456 Oak St');

/*Table structure for table `drivers` */

DROP TABLE IF EXISTS `drivers`;

CREATE TABLE `drivers` (
  `DriverID` int(11) NOT NULL,
  `FirstName` varchar(50) DEFAULT NULL,
  `LastName` varchar(50) DEFAULT NULL,
  `ContactNumber` varchar(15) DEFAULT NULL,
  `LicenseNumber` varchar(20) DEFAULT NULL,
  `Status` enum('Active','Inactive') NOT NULL,
  PRIMARY KEY (`DriverID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `drivers` */

insert  into `drivers`(`DriverID`,`FirstName`,`LastName`,`ContactNumber`,`LicenseNumber`,`Status`) values (1,'Anas','Awan','123-456-7890','DL12345','Active'),(2,'Mustafa','Jaffri','987-654-3210','DL67890','Inactive'),(3,'Maaz','Ahmed','555-123-4567','DL55555','Active');

/*Table structure for table `maintenance` */

DROP TABLE IF EXISTS `maintenance`;

CREATE TABLE `maintenance` (
  `MaintenanceID` int(11) NOT NULL,
  `TruckID` int(11) DEFAULT NULL,
  `MaintenanceType` varchar(50) DEFAULT NULL,
  `MaintenanceDate` date DEFAULT NULL,
  `Cost` decimal(10,2) DEFAULT NULL,
  `Notes` text DEFAULT NULL,
  PRIMARY KEY (`MaintenanceID`),
  KEY `TruckID` (`TruckID`),
  CONSTRAINT `maintenance_ibfk_1` FOREIGN KEY (`TruckID`) REFERENCES `trucks` (`TruckID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `maintenance` */

insert  into `maintenance`(`MaintenanceID`,`TruckID`,`MaintenanceType`,`MaintenanceDate`,`Cost`,`Notes`) values (1,1,'Routine Inspection','2024-01-10','150.00','Performed regular check-up'),(2,4,'Engine Repair','2024-01-15','800.00','Replaced faulty components');

/*Table structure for table `payments` */

DROP TABLE IF EXISTS `payments`;

CREATE TABLE `payments` (
  `PaymentID` int(11) NOT NULL,
  `ShipmentID` int(11) DEFAULT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  `PaymentDate` date DEFAULT NULL,
  `PaymentMethod` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`PaymentID`),
  KEY `ShipmentID` (`ShipmentID`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`ShipmentID`) REFERENCES `shipments` (`ShipmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `payments` */

insert  into `payments`(`PaymentID`,`ShipmentID`,`Amount`,`PaymentDate`,`PaymentMethod`) values (1,1,'500.00','2024-01-25','Credit Card'),(2,2,'700.00','2024-01-28','Cash');

/*Table structure for table `shipments` */

DROP TABLE IF EXISTS `shipments`;

CREATE TABLE `shipments` (
  `ShipmentID` int(11) NOT NULL,
  `CustomerID` int(11) DEFAULT NULL,
  `TruckID` int(11) DEFAULT NULL,
  `DriverID` int(11) DEFAULT NULL,
  `PickupLocation` varchar(255) DEFAULT NULL,
  `DeliveryLocation` varchar(255) DEFAULT NULL,
  `ShipmentDate` date DEFAULT NULL,
  `EstimatedDeliveryDate` date DEFAULT NULL,
  `Status` enum('Pending','In Transit','Delivered') NOT NULL,
  PRIMARY KEY (`ShipmentID`),
  KEY `CustomerID` (`CustomerID`),
  KEY `TruckID` (`TruckID`),
  KEY `DriverID` (`DriverID`),
  CONSTRAINT `shipments_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`),
  CONSTRAINT `shipments_ibfk_2` FOREIGN KEY (`TruckID`) REFERENCES `trucks` (`TruckID`),
  CONSTRAINT `shipments_ibfk_3` FOREIGN KEY (`DriverID`) REFERENCES `drivers` (`DriverID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `shipments` */

insert  into `shipments`(`ShipmentID`,`CustomerID`,`TruckID`,`DriverID`,`PickupLocation`,`DeliveryLocation`,`ShipmentDate`,`EstimatedDeliveryDate`,`Status`) values (1,1,1,1,'Warehouse A','123 Street, DHA Phase 8 , Lahore.','2024-01-22','2024-01-25','In Transit'),(2,2,3,2,'Warehouse B','456 Street, Block L, North Nazmabad, Karachi.','2024-01-23','2024-01-28','Pending');

/*Table structure for table `trucks` */

DROP TABLE IF EXISTS `trucks`;

CREATE TABLE `trucks` (
  `TruckID` int(11) NOT NULL,
  `TruckNumber` varchar(50) NOT NULL,
  `Model` varchar(50) DEFAULT NULL,
  `Capacity` decimal(10,2) DEFAULT NULL,
  `CurrentLocation` varchar(100) DEFAULT NULL,
  `Status` enum('Available','In Transit','Out of Service') NOT NULL,
  PRIMARY KEY (`TruckID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `trucks` */

insert  into `trucks`(`TruckID`,`TruckNumber`,`Model`,`Capacity`,`CurrentLocation`,`Status`) values (1,'TRK001','Freightliner','15000.00','Warehouse A','Available'),(2,'TRK002','Volvo','18000.00','Warehouse B','In Transit'),(3,'TRK003','Kenworth','12000.00','Warehouse C','Available'),(4,'TRK004','Peterbilt','20000.00','Warehouse A','Out of Service'),(5,'TRK005','Mack','16000.00','Warehouse B','Available');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `Username` varchar(50) DEFAULT NULL,
  `Password` varchar(255) DEFAULT NULL,
  `UserType` enum('Admin','Manager','Dispatcher','Driver') NOT NULL,
  PRIMARY KEY (`UserID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `users` */

insert  into `users`(`UserID`,`Username`,`Password`,`UserType`) values (1,'admin','admin123','Admin'),(2,'manager','manager456','Manager'),(3,'dispatcher','dispatch789','Dispatcher'),(4,'driver1','driverpass1','Driver'),(5,'driver2','driverpass2','Driver');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
