<?php
// Check connection
$servername = "localhost";
$username = "crud";
$password = "Admin123";
$dbname = "axausuarios";
// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);
if (!($conn->connect_error)) {
    $query = "SELECT * FROM Busqueda_genreal";   // $query is a simple variable (string)
    $stmt = $conn->prepare($query);  // create a query statement 'controller' (variable name $stmt)
    $stmt->execute();                // execute the statement 
    $resultset = $stmt->get_result(); // get the mysqli resultset
    $jsonArray= array(); // create array to store the fetched data 
    for ($i = 0; $i<$resultset->num_rows; $i++) { 
      $row = $resultset->fetch_assoc(); // fetch each register (table row) 
      array_push($jsonArray,$row);
      //echo $i;
    }
    $stmt->close();  // close prepared statement
    $conn->close(); // close connection   
	  header('Content-Type: application/json; charset=utf-8');  // add dthe required header
    echo json_encode($jsonArray); //  print the json enncoded data
  }
else{
  die("Connection failed: " . $conn->connect_error);
}
?>