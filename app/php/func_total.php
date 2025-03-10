<?php

$database = new mysqli('mysql_db', 'root', 'rootpass', 'dnd');
    
    if (!$database)
    { 
        echo "Error";
        exit; 
    }

$query = "SELECT actual_session_number FROM actual_events";

$result = mysqli_query($database, $query);
$num_rows = mysqli_num_rows($result);
echo "<h3>Total events: " .$num_rows. "</h3>";
?>
