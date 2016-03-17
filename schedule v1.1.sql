-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Feb 01, 2016 at 05:45 PM
-- Server version: 5.5.32
-- PHP Version: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `scheduler`
--
CREATE DATABASE IF NOT EXISTS `schedulerv11` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `schedulerv11`;

-- --------------------------------------------------------

--
-- Table structure for table `classrooms`
--

CREATE TABLE IF NOT EXISTS `classrooms` (
  `roomCode` varchar(10) NOT NULL,
  `roomName` varchar(255) NOT NULL,
  `roomCapacity` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  PRIMARY KEY (`roomCode`),
  UNIQUE KEY `roomName` (`roomName`),
  KEY `typeId` (`typeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `classrooms`
--

INSERT INTO `classrooms` (`roomCode`, `roomName`, `roomCapacity`, `typeId`) VALUES
('Lab01', 'Oxford', 80, 3),
('Lab02', 'Nottingam', 40, 3),
('Lab09', 'Cambridge', 70, 3),
('Lab10', 'Liverpool', 35, 4),
('Lab11', 'York', 35, 4),
('Lab12', 'New Castle', 35, 4),
('Lab13', 'Bath', 35, 4),
('LT01', 'Buckingham Palace', 80, 1),
('LT02', 'Kensington Palace', 80, 1),
('LT03', 'Westminster Palace', 80, 1),
('SR01', 'Tower Bridge', 60, 1),
('SR02', 'Trafalgar Square', 50, 2),
('SR03', 'Piccadilly Circus', 50, 4),
('SR04', 'Tower of London', 50, 2),
('TR01', 'Machapuchare', 35, 2),
('TR02', 'Patan', 40, 2),
('TR03', 'Kanchanjunga', 35, 2),
('TR04', 'Sagarmatha', 35, 2),
('TR05', 'Lumbini', 40, 4),
('TR06', 'Annapurna', 40, 4),
('TR10', 'Pokhara', 35, 2);

-- --------------------------------------------------------

--
-- Table structure for table `class_types`
--

CREATE TABLE IF NOT EXISTS `class_types` (
  `typeId` int(11) NOT NULL,
  `typeName` varchar(255) NOT NULL,
  PRIMARY KEY (`typeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `class_types`
--

INSERT INTO `class_types` (`typeId`, `typeName`) VALUES
(1, 'Lecture'),
(2, 'Tutorial'),
(3, 'Lab'),
(4, 'Workshop');

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE IF NOT EXISTS `groups` (
  `groupCode` varchar(10) NOT NULL,
  `noOfStudents` int(11) NOT NULL,
  PRIMARY KEY (`groupCode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`groupCode`, `noOfStudents`) VALUES
('L3C2', 25),
('L3C3', 25),
('L3C4', 32),
('L3C5', 30);

-- --------------------------------------------------------

--
-- Table structure for table `group_module`
--

CREATE TABLE IF NOT EXISTS `group_module` (
  `groupCode` varchar(10) NOT NULL,
  `moduleCode` varchar(10) NOT NULL,
  `identifier` varchar(20) NOT NULL,
  PRIMARY KEY (`groupCode`,`moduleCode`),
  KEY `groupCode` (`groupCode`,`moduleCode`),
  KEY `moduleCode` (`moduleCode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `group_module`
--

INSERT INTO `group_module` (`groupCode`, `moduleCode`, `identifier`) VALUES
('L3C2', 'CC3001NI', 'L3C2CC3001NI'),
('L3C2', 'CC3301NI', 'L3C2CC3301NI'),
('L3C3', 'CC3301NI', 'L3C3CC3301NI'),
('L3C4', 'CC3001NI', 'L3C4CC3001NI'),
('L3C4', 'CC3003NI', 'L3C4CC3003NI'),
('L3C4', 'CC3005NI', 'L3C4CC3005NI'),
('L3C5', 'CC3001NI', 'L3C5CC3001NI'),
('L3C5', 'CC3003NI', 'L3C5CC3003NI'),
('L3C5', 'CC3005NI', 'L3C5CC3005NI');

-- --------------------------------------------------------

--
-- Table structure for table `login_info`
--

CREATE TABLE IF NOT EXISTS `login_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `login_info`
--

INSERT INTO `login_info` (`id`, `username`, `password`) VALUES
(1, 'nikesh', '5d4f5c1332542272f4d9381ec152af6c'),
(2, 'admin', '21232f297a57a5a743894a0e4a801fc3');

-- --------------------------------------------------------

--
-- Table structure for table `modules`
--

CREATE TABLE IF NOT EXISTS `modules` (
  `moduleCode` varchar(10) NOT NULL,
  `moduleName` varchar(255) NOT NULL,
  `year` int(11) NOT NULL,
  `semester` int(11) NOT NULL,
  PRIMARY KEY (`moduleCode`),
  UNIQUE KEY `moduleName` (`moduleName`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `modules`
--

INSERT INTO `modules` (`moduleCode`, `moduleName`, `year`, `semester`) VALUES
('CC3001NI', 'Advanced System Analysis', 3, 1),
('CC3002NI', 'Advanced Database System', 3, 2),
('CC3003NI', 'Software Engineering II', 3, 1),
('CC3004NI', 'Post Implementation Issues', 3, 2),
('CC3005NI', 'Current Developments', 3, 1),
('CC3301NI', 'Employment Skills', 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `module_classes`
--

CREATE TABLE IF NOT EXISTS `module_classes` (
  `typeId` int(11) NOT NULL,
  `moduleCode` varchar(10) NOT NULL,
  `classHours` decimal(10,2) NOT NULL,
  PRIMARY KEY (`typeId`,`moduleCode`),
  KEY `typeId` (`typeId`,`moduleCode`),
  KEY `moduleCode` (`moduleCode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `module_classes`
--

INSERT INTO `module_classes` (`typeId`, `moduleCode`, `classHours`) VALUES
(1, 'CC3001NI', '2.00'),
(1, 'CC3002NI', '2.00'),
(1, 'CC3003NI', '2.00'),
(1, 'CC3004NI', '2.00'),
(1, 'CC3005NI', '2.00'),
(1, 'CC3301NI', '2.00'),
(2, 'CC3001NI', '1.50'),
(2, 'CC3002NI', '1.50'),
(2, 'CC3003NI', '1.50'),
(2, 'CC3004NI', '1.50'),
(2, 'CC3005NI', '1.50'),
(2, 'CC3301NI', '1.50'),
(3, 'CC3002NI', '1.50'),
(4, 'CC3001NI', '1.50'),
(4, 'CC3003NI', '1.50'),
(4, 'CC3004NI', '1.50'),
(4, 'CC3005NI', '1.50'),
(4, 'CC3301NI', '1.50');

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE IF NOT EXISTS `teachers` (
  `teacherId` varchar(20) NOT NULL,
  `teacherName` varchar(50) NOT NULL,
  PRIMARY KEY (`teacherId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`teacherId`, `teacherName`) VALUES
('TH1', 'Abhinav Dahal'),
('TH2', 'Rohit Pandey'),
('TH3', 'Prakash Shrestha'),
('TH4', 'Manish Kansakar'),
('TH5', 'Prashant Lal Shrestha'),
('TH6', 'Sanjeev Udash'),
('TH7', 'Mukesh Regmi'),
('TH8', ' Sailesh Neupane');

-- --------------------------------------------------------

--
-- Table structure for table `teacher_modules`
--

CREATE TABLE IF NOT EXISTS `teacher_modules` (
  `teacherId` varchar(20) NOT NULL,
  `moduleCode` varchar(10) NOT NULL,
  `typeId` int(11) NOT NULL,
  `identifier` varchar(10) NOT NULL,
  PRIMARY KEY (`teacherId`,`moduleCode`,`typeId`),
  UNIQUE KEY `identifier` (`identifier`),
  KEY `teacherId` (`teacherId`),
  KEY `typeId` (`typeId`),
  KEY `moduleCode` (`moduleCode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teacher_modules`
--

INSERT INTO `teacher_modules` (`teacherId`, `moduleCode`, `typeId`, `identifier`) VALUES
('TH3', 'CC3001NI', 1, 'CC3001NI_1'),
('TH3', 'CC3001NI', 2, 'CC3001NI_2'),
('TH3', 'CC3001NI', 4, 'CC3001NI_4'),
('TH4', 'CC3002NI', 1, 'CC3002NI_1'),
('TH4', 'CC3002NI', 2, 'CC3002NI_2'),
('TH4', 'CC3002NI', 3, 'CC3002NI_3'),
('TH2', 'CC3003NI', 1, 'CC3003NI_1'),
('TH2', 'CC3003NI', 2, 'CC3003NI_2'),
('TH2', 'CC3003NI', 4, 'CC3003NI_4'),
('TH5', 'CC3004NI', 1, 'CC3004NI_1'),
('TH5', 'CC3004NI', 2, 'CC3004NI_2'),
('TH5', 'CC3004NI', 4, 'CC3004NI_4'),
('TH4', 'CC3005NI', 1, 'CC3005NI_1'),
('TH1', 'CC3005NI', 2, 'CC3005NI_2'),
('TH1', 'CC3005NI', 4, 'CC3005NI_4'),
('TH7', 'CC3301NI', 1, 'CC3301NI_1'),
('TH7', 'CC3301NI', 2, 'CC3301NI_2'),
('TH7', 'CC3301NI', 4, 'CC3301NI_4');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `classrooms`
--
ALTER TABLE `classrooms`
  ADD CONSTRAINT `classrooms_ibfk_1` FOREIGN KEY (`typeId`) REFERENCES `class_types` (`typeId`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `group_module`
--
ALTER TABLE `group_module`
  ADD CONSTRAINT `group_module_ibfk_1` FOREIGN KEY (`groupCode`) REFERENCES `groups` (`groupCode`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `group_module_ibfk_2` FOREIGN KEY (`moduleCode`) REFERENCES `modules` (`moduleCode`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `module_classes`
--
ALTER TABLE `module_classes`
  ADD CONSTRAINT `module_classes_ibfk_1` FOREIGN KEY (`typeId`) REFERENCES `class_types` (`typeId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `module_classes_ibfk_2` FOREIGN KEY (`moduleCode`) REFERENCES `modules` (`moduleCode`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `teacher_modules`
--
ALTER TABLE `teacher_modules`
  ADD CONSTRAINT `teacher_modules_ibfk_2` FOREIGN KEY (`teacherId`) REFERENCES `teachers` (`teacherId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `teacher_modules_ibfk_3` FOREIGN KEY (`typeId`) REFERENCES `class_types` (`typeId`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `teacher_modules_ibfk_4` FOREIGN KEY (`moduleCode`) REFERENCES `modules` (`moduleCode`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
