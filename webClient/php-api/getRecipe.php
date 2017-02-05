<?php
$mysqli = new mysqli('127.0.0.1', 'root', 'rolltidebois', 'intellichef');

if($mysqli->connect_errno) {
	echo "Sorry, connection failed.";
	exit;
}

$parts = parse_str($_SERVER['QUERY_STRING']);
echo $id, '<br>';

$sql = "SELECT text FROM description d, recipe r WHERE r.name=d.name;";
if(!$result = $mysqli->query($sql)) {
	echo "Errno: " . $mysqli->errno . "\n";
	echo "Error: " . $mysqli->error . "\n";
	exit;
}

if($result->num_rows === 0) {
	echo "There are no rows in the result";
}

echo json_encode($result->fetch_assoc()), '<br>';
#phpinfo();
?>
