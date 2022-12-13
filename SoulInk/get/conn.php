<?php
$idParam=json_decode($_POST['param']); 

$servername = "localhost";
$username = "Admin";
$password = "Admin123";
$dbname = "soulusuarios";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
 if (!($conn->connect_error)) {
     $query = "SELECT * FROM users WHERE username = ? and password = ?";   // $query is a simple variable (string)
        // prepare statement
     $stmt = $conn->prepare($query);  // create a query statement 'controller' (variable name $stmt)
//     //PARA EL PRIMER PARAMETRO MIRAR LA URL Mysqli-stmt_bind_params de los apuntes
// 	//*******************************************************************************
     $stmt->bind_param('ss', $idParam->user,$idParam->pass );  // 's': string
     $result=$stmt->execute();

// 	//*****************BLOQUE DE CODIGO NO NECESARIO PARA INSERTS, UPDATES Y DELETES. ¿¿Por qué??
     $resultset = $stmt->get_result(); // get the mysqli resultset
     $jsonArray= array(); // create array to store the fetched data 
    
     for ($i = 0; $i<$resultset->num_rows; $i++) { 
        $row = $resultset->fetch_assoc(); // fetch each register (table row) 
       array_push($jsonArray,$row);
     }	
// 	/*********************************************************************************************/
	
      $stmt->close();  // close prepared statement
      $conn->close(); // close connection
    
     header('Content-Type: application/json; charset=utf-8');  // add dthe required header
// 	//MIRAR ESTA SENTENCIA PARA INSERTS, UPDATES Y DELETES
// 	//*******************************************************************************
 	//$returnValue=['status'=>$result];  
     echo json_encode($jsonArray); //  print the json enncoded data
   }
 else{
   die("Connection failed: " . $conn->connect_error);
 } 
?>








