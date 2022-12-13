-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 13-12-2022 a las 10:15:04
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

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `BuscMarca` (IN `pmarca` VARCHAR(200))   BEGIN 
	select Nombre, Marca, Precio, Cantidad from productos WHERE Marca = pmarca ;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `BuscNombre` (IN `pnombre` VARCHAR(200))   BEGIN 
	select Nombre, Marca, Precio, Cantidad from productos WHERE Nombre= pnombre ;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `BuscPrecio` (IN `pprecio` INT)   BEGIN 
	select Nombre, Marca, Precio, Cantidad from productos WHERE Precio = pprecio ;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `insertar` (IN `pNombre` VARCHAR(200), IN `pMarca` VARCHAR(200), IN `pPrecio` INT, IN `pCantidad` INT)   BEGIN 
	INSERT INTO productos (Nombre, Marca, Precio, Cantidad) VALUES (pNombre,pMarca,pPrecio,pCantidad);
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `subida` (IN `porcentaje` INT, IN `pNombre` VARCHAR(200))   BEGIN
		UPDATE productos SET Precio = (Precio + (Precio*porcentaje)/100) where nombre = pNombre ;
	END$$

--
-- Funciones
--
CREATE DEFINER=`root`@`localhost` FUNCTION `CamPrecio` (`precio` INTEGER) RETURNS DOUBLE DETERMINISTIC BEGIN
       	declare result varchar(10);
        IF productos.precio > productos.old.precio THEN
			set result = 'Subida';
		else
			set result = 'Bajada';
		END IF;
        RETURN result;
        INSERT INTO cambio_precios (Cambio) VALUES (result);
    END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `DifPrecio` (`precio` INTEGER) RETURNS DOUBLE DETERMINISTIC BEGIN
       	declare a int;
        set a = productos.precio - productos.old.precio;
        RETURN a;
        INSERT INTO cambio_precios (Diferencia) VALUES (a);
    END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `busqueda_genreal`
-- (Véase abajo para la vista actual)
--
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

CREATE TABLE `cambio_precios` (
  `idProducto` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Diferencia` int(11) NOT NULL,
  `Cambio` varchar(255) DEFAULT NULL,
  `Data` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

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
(6, 'Iphone 14', 'Iphone', 1469, 5),
(7, 'Honor Magic 4 Lite', 'LG', 249, 11),
(8, 'LG G7 ThinQ', 'LG', 259, 18),
(9, 'Xiaomi Note 11', 'Xiaomi', 180, 16),
(10, 'Xiaomi 12T Pro', 'Xiaomi', 1000, 8),
(11, 'Redmi Note 11 Pro+', 'Xiaomi', 400, 8),
(12, 'Xiaomi Redmi note 9', 'Xiaomi', 230, 11),
(22, 'iphone 13', 'iphone', 806, 3);

--
-- Disparadores `productos`
--
DELIMITER $$
CREATE TRIGGER `delete_data` BEFORE DELETE ON `productos` FOR EACH ROW BEGIN
    INSERT INTO productos_eliminados (Nombre, Marca, Data)
    VALUES (old.Nombre, old.Marca, now());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos_eliminados`
--

CREATE TABLE `productos_eliminados` (
  `id` int(11) NOT NULL,
  `Nombre` varchar(255) NOT NULL,
  `Marca` varchar(255) NOT NULL,
  `Data` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `productos_eliminados`
--

INSERT INTO `productos_eliminados` (`id`, `Nombre`, `Marca`, `Data`) VALUES
(1, 'Iphone 13', 'Iphone', '2022-12-07 08:23:15'),
(3, 'Iphone 13', 'Iphone', '2022-12-07 09:16:21'),
(4, 'Iphone 11', 'Iphone', '2022-12-07 09:16:52');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

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
