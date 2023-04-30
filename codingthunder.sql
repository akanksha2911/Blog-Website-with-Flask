-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 30, 2023 at 09:42 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codingthunder`
--

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE `contact` (
  `sno` int(11) NOT NULL,
  `name` text NOT NULL,
  `phone` varchar(12) NOT NULL,
  `msg` varchar(300) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`sno`, `name`, `phone`, `msg`, `date`, `email`) VALUES
(1, 'first entry', '1234567890', 'meri pehli entry', '2023-04-22 03:58:59', 'pehli@gmail.com'),
(3, 'Akanksha Gupta', '7451048731', 'Hello. How are you? I like your blogs and I am very excited to read your further blogs.', '2023-04-25 16:35:36', 'akankshaguptafzd2002@gmail.com'),
(4, 'Akanksha Gupta', '7451048731', 'hello', '2023-04-25 16:39:32', 'g.akanksha2911@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `content` varchar(400) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `slug` varchar(30) NOT NULL,
  `img_file` varchar(100) NOT NULL,
  `tagline` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `content`, `date`, `slug`, `img_file`, `tagline`) VALUES
(1, 'Edited post', 'Feeling so proud to edit this post. All thanks to code with harry.', '2023-04-28 11:24:55', 'first-edit', 'post-bg.jpg', 'This post with sno 1 is edited'),
(2, 'Machine Learning', 'Machine learning is a branch of artificial intelligence (AI) and computer science which focuses on the use of data and algorithms to imitate the way that humans learn, gradually improving its accuracy.', '2023-04-30 13:27:34', 'ml', 'ml.jpg', 'Machine Learning way to learn'),
(3, 'Cryptography ', 'Cryptography is a method of protecting information and communications through the use of codes, so that only those for whom the information is intended can read and process it.', '2023-04-30 13:23:36', 'crypto-graphy', 'crypt.jpg', 'Cryptography in the New Era '),
(4, 'Stock Market', 'The term stock market refers to several exchanges in which shares of publicly held companies are bought and sold. Such financial activities are conducted through formal exchanges and via over-the-counter (OTC) marketplaces that operate under a defined set of regulations. ', '2023-04-30 13:23:48', 'stock-market', 'stock.jpg', 'Stock Market Begins'),
(5, 'Data with Artificial Intelligence', 'The ability for AI to transform enterprises in every industry can be clearly seen in our day-to-day life. As per the recent survey statistics, nearly 50% of the Enterprise IT organization are piloting, shaping, and implementing Artificial Intelligence (AI) based solutions.', '2023-04-30 13:23:55', 'data', 'data.jpg', 'Value the power of data');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contact`
--
ALTER TABLE `contact`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contact`
--
ALTER TABLE `contact`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
