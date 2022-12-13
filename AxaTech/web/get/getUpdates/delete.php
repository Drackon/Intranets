<?php
$idadd= json_decode($_POST['DeleteParam']);
//Establecer parametros para la conexión
$servername = "localhost";
$username = "crud";
$password = "Admin123";
$dbname = "axausuarios";
// Create connection
$conn = new mysqli($servername, $username, $password,$dbname);
// Check connection
if (!($conn->connect_error)) {
  //  echo "llego hasta aqui";
  $query = "DELETE FROM productos WHERE Nombre = ? ";
    // prepare statement
      $stmt = $conn->prepare($query);  // create a query statement 'controller' (variable name $stmt)
    //PARA EL PRIMER PARAMETRO MIRAR LA URL Mysqli-stmt_bind_params de los apuntes
    //*******************************************************************************
      $stmt->bind_param('s', $idadd->Nombre);  // 'i': integer
      $result=$stmt->execute();  
      $stmt->close();  // close prepared statement
      $conn->close(); // close connection
      header('Content-Type: application/json; charset=utf-8');  // add dthe required header
    //MIRAR ESTA SENTENCIA PARA INSERTS, UPDATES Y DELETES
    //*******************************************************************************
    //$returnValue=['status'=>$result]; 
}
else{
    die("Connection failed: " . $conn->connect_error);
  } 
?>