
<?php

// Creates connection
$con=mysqli_connect("localhost","username","password","dbname");

// Check connection
if (mysqli_connect_errno())
{
	echo "Failed to connect oy MySQL: " . mysqli_connect_error();
}

// This SQL statement selects ALL from the table 'Locations'
$sql = "SELECT * FROM Locations";

// Check if there are results
if (

?>
