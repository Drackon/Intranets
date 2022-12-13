<?php
$idParam=json_decode($_POST['UpCantParam']); 
// Check connection
$servername = "localhost";
$username = "crud";
$password = "Admin123";
$dbname = "axausuarios";
// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
if (!($conn->connect_error)) {
    $query = "UPDATE productos SET Cantidad = ? WHERE Nombre = ?";   // $query is a simple variable (string)
    $stmt = $conn->prepare($query);  // create a query statement 'controller' (variable name $stmt)
    //PARA EL PRIMER PARAMETRO MIRAR LA URL Mysqli-stmt_bind_params de los apuntes
	//*******************************************************************************
    $stmt->bind_param('is', $idParam->Cantidad, $idParam->producto);  // 'i': integer
    $result=$stmt->execute();
    $stmt->close();
    $conn->close();
  }
else{
  die("Connection failed: " . $conn->connect_error);
} 
?>