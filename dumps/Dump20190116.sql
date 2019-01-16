-- MySQL dump 10.13  Distrib 8.0.13, for Win64 (x86_64)
--
-- Host: localhost    Database: filmovidb
-- ------------------------------------------------------
-- Server version	8.0.13

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `genre`
--

DROP TABLE IF EXISTS `genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `genre` (
  `idgenre` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`idgenre`),
  UNIQUE KEY `idgenre_UNIQUE` (`idgenre`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre`
--

LOCK TABLES `genre` WRITE;
/*!40000 ALTER TABLE `genre` DISABLE KEYS */;
INSERT INTO `genre` VALUES (2,'Action'),(3,'Comedy'),(4,'Crime'),(1,'Drama'),(5,'Historical'),(6,'Horor'),(7,'Musical'),(8,'Science-fiction'),(11,'Thriller'),(9,'War'),(10,'Western');
/*!40000 ALTER TABLE `genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language`
--

DROP TABLE IF EXISTS `language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `language` (
  `idlanguage` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `code` varchar(45) NOT NULL,
  PRIMARY KEY (`idlanguage`),
  UNIQUE KEY `idlanguage_UNIQUE` (`idlanguage`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language`
--

LOCK TABLES `language` WRITE;
/*!40000 ALTER TABLE `language` DISABLE KEYS */;
INSERT INTO `language` VALUES (1,'English','en'),(2,'Italian','it'),(3,'Spanish','es'),(4,'German','ge'),(5,'Français','fr');
/*!40000 ALTER TABLE `language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `movie`
--

DROP TABLE IF EXISTS `movie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `movie` (
  `idmovie` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `imbd_id` varchar(45) DEFAULT NULL,
  `release_date` varchar(45) DEFAULT NULL,
  `runtime` varchar(45) DEFAULT NULL,
  `vote_count` int(11) NOT NULL,
  `vote_average` double NOT NULL,
  `genre_idgenre` int(11) DEFAULT NULL,
  `language_idlanguage` int(11) DEFAULT NULL,
  `overview` varchar(20000) NOT NULL,
  `movie_image` longtext,
  PRIMARY KEY (`idmovie`),
  UNIQUE KEY `idfilm_UNIQUE` (`idmovie`),
  KEY `fk_movie_genre_idx` (`genre_idgenre`),
  KEY `fk_movie_language1_idx` (`language_idlanguage`),
  CONSTRAINT `fk_movie_genre` FOREIGN KEY (`genre_idgenre`) REFERENCES `genre` (`idgenre`),
  CONSTRAINT `fk_movie_language1` FOREIGN KEY (`language_idlanguage`) REFERENCES `language` (`idlanguage`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `movie`
--

LOCK TABLES `movie` WRITE;
/*!40000 ALTER TABLE `movie` DISABLE KEYS */;
INSERT INTO `movie` VALUES (2,'The Poseidon Adventure','tt0069113','1972-12-01','117',370,7.33613815450329,2,1,'The Poseidon Adventure was one of the first Catastrophe films and began the Disaster Film genre. Director Neame tells the story of a group of people that must fight for their lives aboard a sinking ship. Based on the novel by Paul Gallico.','http://image.tmdb.org/t/p/w185//o7mRqnYg3YJNXxHUWa0TeSzR84d.jpg'),(3,'Dogville','tt0276919','2003-05-19','178',1063,7.80188146754468,4,1,'A barren soundstage is stylishly utilized to create a minimalist small-town setting in which a mysterious woman named Grace hides from the criminals who pursue her. The town is two-faced and offers to harbor Grace as long as she can make it worth their effort, so Grace works hard under the employ of various townspeople to win their favor. Tensions flare, however, and Grace\'s status as a helpless outsider provokes vicious contempt and abuse from the citizens of Dogville.','http://image.tmdb.org/t/p/w185//g1xLrof2RVgtHBB4fLvR5Xr8l5x.jpg'),(4,'Absolut','tt0442896','2005-04-20','94',1,12,11,5,'Two guys against globalization want to plant a virus in the network of a finance corporation. On the day of the attack Alex has an accident and cannot remember anything.','http://image.tmdb.org/t/p/w185//6YemisOilgHbBp6UtgoONHg8eJk.jpg'),(5,'Spider-Man','tt0145487','2002-05-01','121',8882,7.00011258725513,2,1,'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers.','http://image.tmdb.org/t/p/w185//rZd0y1X1Gw4t5B3f01Qzj8DYY66.jpg'),(13,'The Girl in the Spider\'s Web','1','2018-10-26','1',2,7,1,1,'Lisbeth Salander and Mikael Blomkvist find themselves caught in a web of spies, cyber-criminals and corrupt government officials - both in Sweden and in the United States - whom are only known as The Spider Society.','http://image.tmdb.org/t/p/w185//w4ibr8R702DCjwYniry1D1XwQXj.jpg'),(15,'Barrio Brawler','1','2013-08-27','220',2,3,1,1,'A martial arts instructor must enter the world of illegal pit fighting in order to save his family and his dojo.','http://image.tmdb.org/t/p/w185//emSt011zMTnIAo1h7zviQHB55Yb.jpg'),(18,'Batman v Superman: Dawn of Justice','1','2016-03-23','1',11128,5.8,1,1,'Fearing the actions of a god-like Super Hero left unchecked, Gotham City’s own formidable, forceful vigilante takes on Metropolis’s most revered, modern-day savior, while the world wrestles with what sort of hero it really needs. And with Batman and Superman at war with one another, a new threat quickly arises, putting mankind in greater danger than it’s ever known before.','http://image.tmdb.org/t/p/w185//cGOPbv9wA5gEejkUN892JrveARt.jpg'),(19,'Man on Wire','1','2008-07-25','1',420,7.6,1,1,'On August 7th 1974, French tightrope walker Philippe Petit stepped out on a high wire, illegally rigged between New York\'s World Trade Center twin towers, then the world\'s tallest buildings. After nearly an hour of performing on the wire, 1,350 feet above the sidewalks of Manhattan, he was arrested. This fun and spellbinding documentary chronicles Philippe Petit\'s \"highest\" achievement.','http://image.tmdb.org/t/p/w185//86kXY7u0HWSIK27RqRnu4r0cADz.jpg'),(20,'Iron Man 2','1','2010-04-28','131',10895,6.7,1,1,'With the world now aware of his dual life as the armored superhero Iron Man, billionaire inventor Tony Stark faces pressure from the government, the press and the public to share his technology with the military. Unwilling to let go of his invention, Stark, with Pepper Potts and James \'Rhodey\' Rhodes at his side, must forge new alliances – and confront powerful enemies.','http://image.tmdb.org/t/p/w185//ArqpkNYGfcTIA6umWt6xihfIZZv.jpg'),(23,'Inglourious Basterds','1','2009-08-18','1',10705,8.1,1,1,'In Nazi-occupied France during World War II, a group of Jewish-American soldiers known as \"The Basterds\" are chosen specifically to spread fear throughout the Third Reich by scalping and brutally killing Nazis. The Basterds, lead by Lt. Aldo Raine soon cross paths with a French-Jewish teenage girl who runs a movie theater in Paris which is targeted by the soldiers.','http://image.tmdb.org/t/p/w185//ai0LXkzVM3hMjDhvFdKMUemoBe.jpg');
/*!40000 ALTER TABLE `movie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user` (
  `iduser` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `firstName` varchar(45) NOT NULL,
  `lastName` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `admin` tinyint(4) NOT NULL,
  PRIMARY KEY (`iduser`),
  UNIQUE KEY `iduser_UNIQUE` (`iduser`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'vladimir','Vladimir','Serdar','bravo',0),(2,'nikola','Nikola','Nikolic','acer',0),(3,'milan','Milan','Markovic','milan123',0),(4,'admin','admin','admin','admin',1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voted`
--

DROP TABLE IF EXISTS `voted`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `voted` (
  `idvoted` int(11) NOT NULL AUTO_INCREMENT,
  `myVote` varchar(45) DEFAULT NULL,
  `user_iduser` int(11) NOT NULL,
  `movie_idmovie` int(11) NOT NULL,
  PRIMARY KEY (`idvoted`),
  UNIQUE KEY `idvoted_UNIQUE` (`idvoted`),
  KEY `fk_voted_user1_idx` (`user_iduser`),
  KEY `fk_voted_movie1_idx` (`movie_idmovie`),
  CONSTRAINT `fk_voted_movie1` FOREIGN KEY (`movie_idmovie`) REFERENCES `movie` (`idmovie`),
  CONSTRAINT `fk_voted_user1` FOREIGN KEY (`user_iduser`) REFERENCES `user` (`iduser`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voted`
--

LOCK TABLES `voted` WRITE;
/*!40000 ALTER TABLE `voted` DISABLE KEYS */;
INSERT INTO `voted` VALUES (10,'5',1,2),(11,'2',1,3),(12,'3',1,4),(14,'5',2,2),(15,'4',2,2),(16,'5',2,4),(24,'4',2,5),(26,'4',3,4),(27,'5',3,2),(28,'1',1,15),(29,'3',1,13),(30,'2',3,15),(31,'4',3,13),(32,'4',3,5);
/*!40000 ALTER TABLE `voted` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-01-16 22:32:25
