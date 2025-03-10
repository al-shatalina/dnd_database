<body style="text-align: center; font-size: 2vw; width: 100%;
    height: auto;
    margin: 0;
    padding: 0;
    background-image: url(../img/bg.jpg);
    background-repeat: no-repeat;
    background-size: cover;">
<div style= "width: 60%;
    height: auto;
    margin: 30px 20%;
    padding-top: 10px;
    padding-bottom: 50px;
    background-color: #f9fbef;
    border: 2px solid;
        border-color: #848994; ">
<?php 

if (isset($_POST['posted'])){
    $database = new mysqli('mysql_db', 'root', 'rootpass', 'dnd');
    
    if (!$database)
    { 
        echo "Error";
        exit; 
    }
    $posted = $_POST['posted'];
    $posted = trim($posted); 
    $posted = htmlspecialchars($posted);

    $q1 = "SELECT planned_session_number, event_name, event_place, place_region, event_description 
    FROM planned_events
    JOIN places ON places.place = planned_events.event_place
    WHERE  planned_session_number LIKE '%$posted%';";
    $q2 = "SELECT actual_session_number, event_char, event_name, char_action, char_name, char_surname FROM actual_events
    JOIN planned_events ON actual_events.event = planned_events.event_id
    JOIN characters ON actual_events.event_char = characters.char_id
    WHERE actual_session_number LIKE '%$posted%';";

    $result1 = mysqli_query($database, $q1); 
    $result2 = mysqli_query($database, $q2);
    $num_rows = mysqli_num_rows($result2);

    echo "
        <b>Session Number $posted</b>
        <br>";
    for ($i=0; $i<$num_rows; $i++){
        $row = mysqli_fetch_array($result1);
        echo "
        <b><i>$row[event_name]</i></b>
        <hr>
        $row[place_region] - $row[event_place]
        <hr>
        $row[event_description]
        <hr>
        <hr>
        <b>What really happened:</b>
        <hr>";
        $row = mysqli_fetch_array($result2);
        echo "
        $row[char_name] $row[char_surname]
        <hr>
        <i>$row[char_action]</i>
        <hr>
        <hr>";
        }
        }
?>
    </div>
<body>