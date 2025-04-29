-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 17, 2024 at 08:17 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `video_tape`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `admin_name` varchar(255) NOT NULL,
  `admin_password` varchar(255) NOT NULL,
  `role` varchar(20) NOT NULL DEFAULT 'admin',
  `token` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `admin_name`, `admin_password`, `role`, `token`, `created_at`, `updated_at`) VALUES
(1, 'admin12', '56789453', 'admin', '', '2024-12-17 05:12:39', '2024-12-17 05:12:39'),
(2, 'admin12', '$2b$10$xwiB/JzyqZEpQGyVJLfZbOmul5gKmvGUWCGl86lh3aOWc.VtDI95K', 'admin', NULL, '2024-12-17 14:04:34', '2024-12-17 14:04:34');

-- --------------------------------------------------------

--
-- Table structure for table `tapes`
--

CREATE TABLE `tapes` (
  `id` int(11) NOT NULL,
  `tape_title` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `tape_genre` enum('horror','thriller','romance','comedy','action','family') NOT NULL,
  `tape_price` varchar(50) NOT NULL,
  `tape_year` int(4) NOT NULL,
  `tape_image` varchar(100) NOT NULL,
  `level` double NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tapes`
--

INSERT INTO `tapes` (`id`, `tape_title`, `description`, `tape_genre`, `tape_price`, `tape_year`, `tape_image`, `level`, `created_at`, `updated_at`) VALUES
(1, 'Titanic', 'Rose, who is being forced to marry a wealthy man, falls in love with Jack, a talented artist, aboard the unsinkable Titanic. Unfortunately, the ship hits an iceberg, endangering their lives.', 'romance', 'Rp. 350.000', 1997, '/assets/titanic.JPG', 4.6, '2024-12-04 12:23:23', '2024-12-04 12:23:23'),
(2, 'Beautiful Wedding', 'After a crazy night in Las Vegas, Abby and Travis wake up as accidental newlyweds, then travel to Mexico for an even wilder honeymoon. As chaos ensues, they must decide if the belong together, or if this marriage is a disaster waiting to happen.', 'romance', 'Rp. 150.000', 2024, '/assets/beautifulWedding.jpeg', 3, '2024-12-04 12:23:23', '2024-12-04 12:23:23'),
(3, 'Mariposa', 'New student Acha falls for Iqbal, a high-achieving student who\'s torn between love and family pressure.', 'romance', 'Rp. 201.000', 2020, '/assets/mariposa.JPG', 3.5, '2024-12-04 12:23:23', '2024-12-04 12:23:23'),
(4, 'It Ends With Us', 'Lily Bloom moves to Boston to chase her lifelong dream of opening her own business. A chance meeting with charming neurosurgeon Ryle Kincaid soon sparks an intense connection, but as the two fall deeply in love, she begins to see sides of Ryle that remind her of her parents\' relationship. When Lily\'s first love, Atlas Corrigan, suddenly reenters her life, her relationship with Ryle gets upended, leaving her with an impossible choice.', 'romance', 'Rp. 215.000', 2024, '/assets/itEndsWith.JPG', 4.099999904632568, '2024-12-04 12:23:23', '2024-12-04 12:23:23'),
(5, 'Purple Hearts', 'Cassie, a struggling singer-songwriter agrees to marry a troubled Marine, Luke for military benefits. The line between real and pretend begins to blur.', 'romance', 'Rp. 235.000', 2022, '/assets/purpleHearts.JPG', 4.199999809265137, '2024-12-04 12:23:23', '2024-12-04 12:23:23'),
(6, 'Sweet & Sour', 'Faced with real-world opportunities and challenges, a couple endures the highs and lows of trying to make a long-distance relationship survive.', 'romance', 'Rp. 200.500', 2021, '/assets/sweetSour.JPG', 4.5, '2024-12-04 12:23:23', '2024-12-04 12:23:23'),
(7, 'The Black Phone', 'Finney Shaw is a shy but clever 13-year-old boy who\'s being held in a soundproof basement by a sadistic, masked killer. When a disconnected phone on the wall starts to ring, he soon discovers that he can hear the voices of the murderer\'s previous victims -- and they are dead set on making sure that what happened to them doesn\'t happen to Finney.', 'horror', 'Rp. 150.000', 2021, '/assets/blackPhone.JPG', 4.300000190734863, '2024-12-04 12:23:23', '2024-12-04 12:23:23'),
(8, 'The Conjuring 2', 'Peggy, a single mother of four children, seeks the help of occult investigators Ed and Lorraine Warren when she and her children witness strange, paranormal events in their house.', 'horror', 'Rp. 322.000', 2016, '/assets/conjuring2.JPG', 3.700000047683716, '2024-12-04 12:23:23', '2024-12-04 12:23:23'),
(9, 'Consumed', 'A camping trip goes horribly wrong when a couple encounter a revenge-seeking madman who\'s hunting a skin-stealing monster deep in the woods.', 'horror', 'Rp. 100.000', 2024, '/assets/consumed.jpeg', 2.200000047683716, '2024-12-04 12:23:23', '2024-12-04 12:23:23'),
(10, 'Danur', 'Eight-year-old Risa is left alone by her busy parents and makes friends with three ghosts, until things begin to change.', 'horror', 'Rp. 189.000', 2017, '/assets/danur.JPG', 2.5, '2024-12-04 12:23:23', '2024-12-04 12:23:23'),
(11, 'Danur 2', 'As Risa\'s ability to see ghosts continues to disrupt her life, her uncle\'s peculiar behavior leads her to discover a haunting mystery at his new house. Risa (Prilly Latuconsina), a teenage girl who has 3 ghost friends named Peter (Gamaharitz), William (Alexander Bain) and Jhansen (Kevin Bzezovski).', 'horror', 'Rp. 227.000', 2018, '/assets/danur2.JPG', 2.700000047683716, '2024-12-04 12:23:23', '2024-12-04 12:23:23'),
(12, 'KKN di Desa Penari', 'When some students visit a village for community service, they run into a dancer\'s wrathful spirit that unleashes a cascade of horrors upon them.', 'horror', 'Rp. 229.000', 2022, '/assets/kkn.JPG', 2.9000000953674316, '2024-12-04 12:23:23', '2024-12-04 12:23:23'),
(13, 'Pengabdi Setan', 'After dying from a strange illness that she suffered for three years, a mother returned home to pick up her children.', 'horror', 'Rp. 289.000', 2017, '/assets/pengabdiSetan.JPG', 4.800000190734863, '2024-12-04 12:23:23', '2024-12-04 12:23:23'),
(14, 'Pengabdi Setan 2', 'Several years after a terrible incident cost their mother and youngest sibling their lives, Rini and her siblings Toni and Bondi live with their father in flats. They believe living in flats with many people is safe, but they soon realize this might be dangerous if they don\'t know their neighbors. On a night full of terror, Rini and her family must save themselves.', 'horror', 'Rp. 300.000', 2022, '/assets/pengabdiSetan2.JPG', 4.599999904632568, '2024-12-04 12:23:23', '2024-12-04 12:23:23'),
(15, 'Smile 2', 'About to embark on a new world tour, global pop sensation Skye Riley begins to experience increasingly terrifying and inexplicable events. Overwhelmed by the escalating horrors and pressures of fame, she must face her dark past to regain control of her life before it spirals out of control.', 'horror', 'Rp. 199.000', 2024, '/assets/smile2.jpeg', 4, '2024-12-04 12:23:23', '2024-12-04 12:23:23'),
(16, 'The Unholy', 'Alice, a girl with hearing impairment, is able to hear, speak and even heal the ill after having visions of the Virgin Mary. But when a journalist probes into the matter, he unearths a conspiracy.', 'horror', 'Rp. 159.500', 2021, '/assets/theUnholy.JPG', 4.300000190734863, '2024-12-04 12:23:23', '2024-12-04 12:23:23'),
(17, 'Bewitched', 'Jack Wyatt, an actor, intends to star opposite an unknown face as his actress in a movie. He then comes across Isabel in the auditions and decides to cast her, unaware of the fact that she is a witch.', 'comedy', 'Rp. 98.500', 2005, '/assets/bewitched.JPG', 3.5, '2024-12-04 12:23:23', '2024-12-04 12:23:23'),
(18, 'Cek Toko Sebelah', 'After Erwin receives an offer to work in Singapore, his father falls ill and needs him to work at his shop. But his older and irresponsible brother Yohan feels that his father favours Erwin over him.', 'comedy', 'Rp. 327.000', 2016, '/assets/cekToko.JPG', 5, '2024-12-04 12:23:23', '2024-12-04 12:23:23'),
(19, 'Family Switch', 'When family members switch bodies with each other during a rare planetary alignment, their hilarious journey to find their way back to normal will bring them closer together than they ever thought possible.', 'comedy', 'Rp. 123.000', 2023, '/assets/familySwitch.JPG', 3.200000047683716, '2024-12-04 12:23:23', '2024-12-04 12:23:23'),
(20, 'My Stupid Boss', 'A woman takes a job as secretary to the bumbling and impossible boss of a large company and comes to regret it.', 'comedy', 'Rp. 244.000', 2016, '/assets/myStupid.JPG', 5, '2024-12-04 12:23:23', '2024-12-04 12:23:23'),
(21, 'Yes Day', 'Always feeling like they have to say \"no\" to their kids, Allison and Carlos decide to give their three kids a \"Yes Day,\" during which the kids have 24 hours to make the rules.', 'comedy', 'Rp. 156.000', 2021, '/assets/yesDay.JPG', 2.799999952316284, '2024-12-04 12:23:23', '2024-12-04 12:23:23'),
(22, 'Barbie Dolphin Magic', 'Barbie and her sisters arrive at a tropical resort for a vacation. However, when a rare Gemstone dolphin goes missing, Barbie joins hands with Isla, a mysterious girl she befriends, to find it.', 'family', 'Rp. 130.000', 2017, '/assets/barbie.JPG', 0, '2024-12-04 12:23:23', '2024-12-04 12:23:23'),
(23, 'Despicable Me 4', 'Gru welcomes a new member to the family, Gru Jr., who\'s intent on tormenting his dad. However, their peaceful existence soon comes crashing down when criminal mastermind Maxime Le Mal escapes from prison and vows revenge against Gru.', 'family', 'Rp. 267.000', 2024, '/assets/despicable.JPG', 0, '2024-12-04 12:23:23', '2024-12-04 12:23:23'),
(24, 'The Garfield', 'After an unexpected reunion with his long-lost father, a scruffy street cat, Garfield is forced to leave his perfectly pampered life in order to take part in a high-stakes heist. And an incredible outdoor adventure begins!', 'family', 'Rp. 190.000', 2024, '/assets/garfield.JPG', 0, '2024-12-04 12:23:23', '2024-12-04 12:23:23'),
(25, 'Home Alone ', 'Eight-year-old Kevin is accidentally left behind when his family leaves for France. At first, he\'s happy to be in charge; but when thieves try to break into his home, he puts up a fight like no other.', 'family', 'Rp. 189.500', 1990, '/assets/homeAlone.JPG', 0, '2024-12-08 13:10:14', '2024-12-08 13:10:14'),
(26, 'Moana', 'Moana, daughter of chief Tui, embarks on a journey to return the heart of goddess Te Fitti from Maui, a demigod, after the plants and the fish on her island start dying due to a blight.', 'family', 'Rp. 276.000', 2016, '/assets/moana.JPG', 0, '2024-12-08 13:10:14', '2024-12-08 13:10:14'),
(27, 'Matilda', 'Matilda has a dysfunctional relationship with her parents and brother. At school, she hates the principal for torturing her and a teacher, so she uses her telekinetic abilities to deal with her.', 'family', 'Rp. 218.000', 1996, '/assets/matilda.JPG', 0, '2024-12-08 13:11:10', '2024-12-08 13:11:10'),
(28, '13 Bombs', 'A counterterrorist unit must race against the clock to stop a wave of deadly bomb attacks across the Indonesian capital.', 'action', 'Rp. 201.000', 2023, '/assets/13Bom.JPG', 0, '2024-12-08 13:29:42', '2024-12-08 13:29:42'),
(29, 'Ballerina', 'Grieving the loss of a best friend she could not protect, former bodyguard Ok-ju sets out to fulfil her dear friend\'s last wish: sweet, sweet revenge.', 'action', 'Rp. 189.500', 2023, '/assets/ballerina.JPG', 0, '2024-12-08 13:29:42', '2024-12-08 13:29:42'),
(30, 'Black Adam', 'Grieving the loss of a best friend she could not protect, former bodyguard Ok-ju sets out to fulfil her dear friend\'s last wish: sweet, sweet revenge.', 'action', 'Rp. 223.000', 2022, '/assets/blackAdam.JPG', 0, '2024-12-08 13:31:32', '2024-12-08 13:31:32'),
(31, 'The Fall Guy', 'After leaving the business one year earlier, battle-scarred stuntman Colt Seavers springs back into action when the star of a big studio movie suddenly disappears. As the mystery surrounding the missing actor deepens, Colt soon finds himself ensnared in a sinister plot that pushes him to the edge of a fall more dangerous than any stunt.', 'action', 'Rp. 256.000', 2024, '/assets/fallGuy.JPG', 0, '2024-12-08 13:31:32', '2024-12-08 13:31:32'),
(32, 'John Wick 2', 'John Wick, a retired hitman, visits Italy to pay off an inescapable blood debt. However, he soon finds himself cornered by every killer in the business due to an enormous bounty on his head.', 'action', 'Rp. 289.500', 2017, '/assets/johnWick2.JPG', 0, '2024-12-08 13:33:36', '2024-12-08 13:33:36'),
(33, 'Kingdom Planet of the Apes', 'Many years after the reign of Caesar, a young ape goes on a journey that will lead him to question everything he\'s been taught about the past and make choices that will define a future for apes and humans alike.', 'action', 'Rp. 213.500', 2024, '/assets/kingdomPlanet.JPG', 0, '2024-12-08 13:33:36', '2024-12-08 13:33:36'),
(34, 'Officer Black Belt', 'Kim Seon-min, a probation officer whose goal is crime prevention, begins closely monitoring people subject to electronic ankle bracelets together with Lee Jeong-do, a ninth-degree black belt in martial arts including taekwondo, kendo and judo.', 'action', 'Rp. 189.750', 2024, '/assets/officerBlack.JPG', 0, '2024-12-08 13:36:33', '2024-12-08 13:36:33'),
(35, 'Unstoppable', 'A former gangster turned seafood distributor, Dong-Chul (Don Lee), comes home to find his wife missing and his house in disarray. He then resorts to his old ways to rescue her from a human trafficking ring.', 'action', 'Rp. 156.900', 2018, '/assets/unstoppable.JPG', 0, '2024-12-08 13:36:33', '2024-12-08 13:36:33'),
(36, 'CTRL', 'Nella and Joe are the perfect influencer couple, but when he cheats on her, she turns to an AI app to erase him digitally from her life, only to discover that he has disappeared in real life as well.', 'thriller', 'Rp. 223.250', 2024, '/assets/ctrl.JPG', 0, '2024-12-08 13:52:43', '2024-12-08 13:52:43'),
(37, 'Bird Box', 'Years after an unseen entity wreaks havoc on humankind by compelling people to commit suicide, Malorie and her two children, blindfolded, undertake a dangerous journey in a bid to survive.', 'horror', 'Rp. 203.000', 2018, '/assets/birdBox.JPG', 0, '2024-12-08 13:52:43', '2024-12-08 13:52:43'),
(38, 'Forgotten', 'When his abducted brother returns, seemingly a different man with no memory of the past 19 days, Jin-seok chases after the truth behind the mysterious kidnapping.', 'thriller', 'Rp. 190.900', 2017, '/assets/forgotten.JPG', 0, '2024-12-08 13:54:46', '2024-12-08 13:54:46'),
(39, 'Late Night Devil', 'In 1977 a live television broadcast goes horribly wrong, unleashing evil into the nation\'s living rooms.', 'horror', 'Rp. 154.600', 2023, '/assets/lateNight.JPG', 0, '2024-12-08 13:54:46', '2024-12-08 13:54:46'),
(40, 'Now You See Me', 'The Horsemen, a group of four street magicians, rob a huge sum of money that belongs to insurance magnate Arthur Tressler. The group is chased by FBI agent Dylan Rhodes and Interpol agent Alma Dray.', 'thriller', 'Rp. 251.000', 2013, '/assets/nowYouSee.JPG', 0, '2024-12-08 13:56:32', '2024-12-08 13:56:32'),
(41, 'Unlocked', 'A woman\'s life is turned upside-down after a dangerous man gets a hold of her lost cell phone and uses it to track her every move.', 'thriller', 'Rp. 230.000', 2023, '/assets/unlocked.JPG', 0, '2024-12-08 13:56:32', '2024-12-08 13:56:32'),
(42, 'It\'s What\'s Inside', 'A pre-wedding reunion descends into a psychological nightmare for a group of college friends when a surprise guest arrives with a mysterious suitcase that starts to tear the group apart.', 'horror', 'Rp. 199.999', 2024, '/assets/whatsInside.JPG', 0, '2024-12-08 13:59:56', '2024-12-08 13:59:56'),
(43, 'Army of Thieves', 'A mysterious woman recruits bank teller Dieter to assist in a heist of impossible to crack safes across Europe.', 'thriller', 'Rp. 178.900', 2021, '/assets/armyThieves.JPG', 0, '2024-12-08 13:59:56', '2024-12-08 13:59:56'),
(44, 'The Weekend Away', 'When her best friend vanishes during a girls trip to Croatia, a woman races to figure out what happened. However, each clue yields another unsettling deception.', 'thriller', 'Rp. 179.000', 2022, '/assets/theWeekend.JPG', 0, '2024-12-08 14:04:13', '2024-12-08 14:04:13'),
(45, 'Panic Room', 'Meg and Sarah hide in a panic room in their house when intruders break in. Unfortunately for them, the intruders want something that is hidden inside the room and will stop at nothing to claim it.', 'thriller', 'Rp. 132.000', 2002, '/assets/panicRoom.JPG', 0, '2024-12-08 14:04:13', '2024-12-08 14:04:13');

-- --------------------------------------------------------

--
-- Table structure for table `trending_tapes`
--

CREATE TABLE `trending_tapes` (
  `id` int(11) NOT NULL,
  `tape_name` varchar(50) NOT NULL,
  `tape_title` varchar(50) NOT NULL,
  `tape_image` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `trending_tapes`
--

INSERT INTO `trending_tapes` (`id`, `tape_name`, `tape_title`, `tape_image`, `created_at`, `updated_at`) VALUES
(1, 'Bruno Mars ft. Rose', 'APT', '/assets/APT.png', '2024-12-04 12:22:56', '2024-12-04 12:22:56'),
(2, 'One Directions', 'Best Song Ever', '/assets/bestSongEver.png', '2024-12-04 12:22:56', '2024-12-04 12:22:56'),
(3, 'Billie Eilish', 'Happier Than Ever', '/assets/happierThanEver.png', '2024-12-04 12:22:56', '2024-12-04 12:22:56'),
(4, 'BTS', 'Life Goes On ', '/assets/lifeGoesOn.png', '2024-12-04 12:22:56', '2024-12-04 12:22:56'),
(5, 'Taylor Swift', 'Red', '/assets/red.png', '2024-12-04 12:25:33', '2024-12-04 12:25:33'),
(6, 'Sabrina Carpenter', 'Espresso', '/assets/sabrinaCarpenter.png', '2024-12-04 12:25:33', '2024-12-04 12:25:33');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `token` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `token`, `created_at`, `updated_at`) VALUES
(1, 'Zhafirah Kamila H', 'zhafirah@gmail.com', '$2a$10$HDasqLLtQMBDU9JbGUUW2.qfnpnsNcyZeOwOvbtLSyIXJjJGUf92K', NULL, '2024-11-26 11:37:23', '2024-11-26 11:37:23'),
(3, 'Inner Journey', 'tazkie@gmail.com', '$2a$10$X6KgZfBfxkWDKesk/rgim.itd90oPd1BxLLvY26tXGXIveC7pRIye', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjMsIm5hbWUiOiJJbm5lciBKb3VybmV5IiwiZW1haWwiOiJ0YXpraWVAZ21haWwuY29tIiwiaWF0IjoxNzMyODY2MTc3LCJleHAiOjE3MzI5NTI1Nzd9.5Jcr-oyTQoQGo_k5WUcpFEcetuP7swT2w83UMgu1H6I', '2024-11-26 12:46:51', '2024-11-29 07:42:57'),
(4, 'Park Jimin', 'JiminPark@gmail.com', '$2b$10$NaIxTbOE3PlkkCM7bi5vsegQwt943nPJD2XVHbMdMRD1oVrJ.6ymS', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NCwiaWF0IjoxNzM0NDYwNzMwLCJleHAiOjE3MzQ0NjQzMzB9.0sUFUDXvBR6GkNLADFBbYHKiku1KOHEUBt_BuCHfbEY', '2024-12-14 22:32:15', '2024-12-14 22:32:15');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tapes`
--
ALTER TABLE `tapes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trending_tapes`
--
ALTER TABLE `trending_tapes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tapes`
--
ALTER TABLE `tapes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `trending_tapes`
--
ALTER TABLE `trending_tapes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
