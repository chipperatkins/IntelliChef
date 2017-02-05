<?php
$str = [ "Hello, World", "Sucks to suck" ];

$mysqli = new mysqli('127.0.0.1', 'root', 'rolltidebois', 'intellichef');

if($mysqli->connect_errno) {
	echo "Sorry, connection failed.";
	exit;
}
else {
	echo "Connection succeeded.<br>";
}

$sql = "SELECT name FROM description";
if(!$result = $mysqli->query($sql)) {
	echo "Shit's broke. \n"; 
	echo "Errno: " . $mysqli->errno . "\n";
	echo "Error: " . $mysqli->error . "\n";
	exit;
}

if($result->num_rows === 0) {
	echo "There are no rows in the result";
}
else { echo $result->num_rows . " Rows exist in result <br>"; }

echo json_encode($result->fetch_assoc()), '<br>';
echo json_encode($result->fetch_assoc()), '<br>';
#phpinfo();
?>
