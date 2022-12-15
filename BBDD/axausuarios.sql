-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-12-2022 a las 08:25:03
-- Versión del servidor: 10.4.27-MariaDB
-- Versión de PHP: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `axausuarios`
--
CREATE DATABASE IF NOT EXISTS `axausuarios` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `axausuarios`;

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `BuscMarca`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BuscMarca` (IN `pmarca` VARCHAR(200))   BEGIN 
	select Nombre, Marca, Precio, Cantidad from productos WHERE Marca = pmarca ;
	END$$

DROP PROCEDURE IF EXISTS `BuscNombre`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BuscNombre` (IN `pnombre` VARCHAR(200))   BEGIN 
	select Nombre, Marca, Precio, Cantidad from productos WHERE Nombre= pnombre ;
	END$$

DROP PROCEDURE IF EXISTS `BuscPrecio`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `BuscPrecio` (IN `pprecio` INT)   BEGIN 
	select Nombre, Marca, Precio, Cantidad from productos WHERE Precio = pprecio ;
	END$$

DROP PROCEDURE IF EXISTS `insertar`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar` (IN `pNombre` VARCHAR(200), IN `pMarca` VARCHAR(200), IN `pPrecio` INT, IN `pCantidad` INT)   BEGIN 
	INSERT INTO productos (Nombre, Marca, Precio, Cantidad) VALUES (pNombre,pMarca,pPrecio,pCantidad);
	END$$

DROP PROCEDURE IF EXISTS `subida`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `subida` (IN `porcentaje` INT, IN `pNombre` VARCHAR(200))   BEGIN
UPDATE productos SET productos.Precio = (productos.Precio + (productos.Precio*porcentaje)/100) 
where productos.nombre = pNombre ;
END$$

--
-- Funciones
--
DROP FUNCTION IF EXISTS `CamPrecio`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `CamPrecio` (`precio` INT) RETURNS DOUBLE DETERMINISTIC BEGIN
       	declare result varchar(10);
        IF productos.precio > precios_viejo.precio THEN
			set result = 'Subida';
		else
			set result = 'Bajada';
		END IF;
        RETURN result;
    END$$

DROP FUNCTION IF EXISTS `DifPrecio`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `DifPrecio` (`precio` INTEGER) RETURNS DOUBLE DETERMINISTIC BEGIN
       	declare a int;
        set a = productos.precio - precios_viejos.precio;
        RETURN a;
        
    END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `busqueda_genreal`
-- (Véase abajo para la vista actual)
--
DROP VIEW IF EXISTS `busqueda_genreal`;
CREATE TABLE `busqueda_genreal` (
`idProducto` int(11)
,`Nombre` varchar(255)
,`Marca` varchar(255)
,`Precio` int(11)
,`Cantidad` int(11)
);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cambio_precios`
--

DROP TABLE IF EXISTS `cambio_precios`;
CREATE TABLE `cambio_precios` (
  `idProducto` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Diferencia` int(11) NOT NULL,
  `Cambio` varchar(255) DEFAULT NULL,
  `Data` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `precios_viejos`
--

DROP TABLE IF EXISTS `precios_viejos`;
CREATE TABLE `precios_viejos` (
  `idProducto` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Precio` int(11) NOT NULL,
  `Fecha` date DEFAULT NULL,
  `cambio` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `precios_viejos`
--

INSERT INTO `precios_viejos` (`idProducto`, `Nombre`, `Precio`, `Fecha`, `cambio`) VALUES
(18, 'iphone 13', 879, '2022-12-13', 0),
(19, 'iphone 13', 0, NULL, -3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

DROP TABLE IF EXISTS `productos`;
CREATE TABLE `productos` (
  `idProducto` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Marca` varchar(255) DEFAULT NULL,
  `Precio` int(11) NOT NULL,
  `Cantidad` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`idProducto`, `Nombre`, `Marca`, `Precio`, `Cantidad`) VALUES
(3, 'Samsung galaxy s8', 'Samsung', 289, 15),
(4, 'Samsung galaxy s20', 'Samsung', 130, 30),
(6, 'Iphone 14', 'Iphone', 1466, 5),
(7, 'Honor Magic 4 Lite', 'LG', 249, 11),
(8, 'LG G7 ThinQ', 'LG', 259, 18),
(9, 'Xiaomi Note 11', 'Xiaomi', 180, 16),
(10, 'Xiaomi 12T Pro', 'Xiaomi', 1000, 8),
(11, 'Redmi Note 11 Pro+', 'Xiaomi', 400, 8),
(12, 'Xiaomi Redmi note 9', 'Xiaomi', 230, 11),
(22, 'iphone 13', 'iphone', 853, 3);

--
-- Disparadores `productos`
--
DROP TRIGGER IF EXISTS `delete_data`;
DELIMITER $$
CREATE TRIGGER `delete_data` BEFORE DELETE ON `productos` FOR EACH ROW BEGIN
    INSERT INTO productos_eliminados (Nombre, Marca, Data)
    VALUES (old.Nombre, old.Marca, now());
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `save_prec`;
DELIMITER $$
CREATE TRIGGER `save_prec` BEFORE UPDATE ON `productos` FOR EACH ROW BEGIN
    INSERT INTO precios_viejos (Nombre, Precio, Fecha)
    VALUES (old.Nombre, old.Precio, now());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos_eliminados`
--

DROP TABLE IF EXISTS `productos_eliminados`;
CREATE TABLE `productos_eliminados` (
  `id` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Marca` varchar(255) NOT NULL,
  `Data` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos_eliminados`
--

INSERT INTO `productos_eliminados` (`id`, `Nombre`, `Marca`, `Data`) VALUES
(1, 'Iphone 13', 'Iphone', '2022-12-07'),
(3, 'Iphone 13', 'Iphone', '2022-12-07'),
(4, 'Iphone 11', 'Iphone', '2022-12-07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `username`, `password`) VALUES
(1, 'antonio', 'Admin123'),
(2, 'kaiet', 'Admin123'),
(3, 'cristian', 'Admin123'),
(4, 'ainhoa', 'Admin123'),
(5, 'manolo', 'Admin123'),
(6, 'xabi', 'Admin123'),
(7, 'beñat', 'Admin123');

-- --------------------------------------------------------

--
-- Estructura para la vista `busqueda_genreal`
--
DROP TABLE IF EXISTS `busqueda_genreal`;

DROP VIEW IF EXISTS `busqueda_genreal`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `busqueda_genreal`  AS SELECT `productos`.`idProducto` AS `idProducto`, `productos`.`Nombre` AS `Nombre`, `productos`.`Marca` AS `Marca`, `productos`.`Precio` AS `Precio`, `productos`.`Cantidad` AS `Cantidad` FROM `productos``productos`  ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cambio_precios`
--
ALTER TABLE `cambio_precios`
  ADD PRIMARY KEY (`idProducto`);

--
-- Indices de la tabla `precios_viejos`
--
ALTER TABLE `precios_viejos`
  ADD PRIMARY KEY (`idProducto`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`idProducto`);

--
-- Indices de la tabla `productos_eliminados`
--
ALTER TABLE `productos_eliminados`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cambio_precios`
--
ALTER TABLE `cambio_precios`
  MODIFY `idProducto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `precios_viejos`
--
ALTER TABLE `precios_viejos`
  MODIFY `idProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `idProducto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT de la tabla `productos_eliminados`
--
ALTER TABLE `productos_eliminados`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

GRANT SELECT, INSERT, UPDATE, DELETE ON *.* TO `crud`@`localhost` IDENTIFIED BY PASSWORD '*B37ACB9927C1F3B520BBF976386EAB76A08F3367'; -- Password = Admin123

GRANT EXECUTE ON PROCEDURE `axausuarios`.`buscprecio` TO `crud`@`localhost`;

GRANT EXECUTE ON PROCEDURE `axausuarios`.`buscmarca` TO `crud`@`localhost`;

GRANT EXECUTE ON PROCEDURE `axausuarios`.`subida` TO `crud`@`localhost`;

GRANT EXECUTE ON PROCEDURE `axausuarios`.`insertar` TO `crud`@`localhost`;

GRANT EXECUTE ON PROCEDURE `axausuarios`.`buscnombre` TO `crud`@`localhost`;
