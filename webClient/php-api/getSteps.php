<?php
$mysqli = new mysqli('127.0.0.1', 'root', 'rolltidebois', 'intellichef');

if($mysqli->connect_errno) {
	echo "Sorry, connection failed.";
	exit;
}

$parts = parse_str($_SERVER['QUERY_STRING']);
#echo $id, '<br>';

$sql = "SELECT text, s.stepNum, length FROM steps s, time t WHERE s.recipeID=$id and t.stepNum=s.stepNum;";
if(!$result = $mysqli->query($sql)) {
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
