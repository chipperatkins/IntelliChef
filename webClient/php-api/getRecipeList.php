<?php
$mysqli = new mysqli('127.0.0.1', 'root', 'rolltidebois', 'intellichef');

if($mysqli->connect_errno) {
	echo "Sorry, connection failed.";
	exit;
}

$sql = "SELECT * FROM recipe";
$result = $mysqli->query($sql);

if($result != $mysqli->query($sql)) {
	echo "Errno: " . $mysqli->errno . "\n";
	echo "Error: " . $mysqli->error . "\n";
	exit;
}

if($result->num_rows === 0) {
	echo "There are no rows in the result";
}
$stack = array();

while($row = $result->fetch_assoc()) {
	array_push($stack, $row);
}

echo json_encode($stack);

#phpinfo();
?>
