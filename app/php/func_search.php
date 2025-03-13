<body style="text-align: center; font-size: 2vw; width: 100%;
    height: auto;
    margin: 0;
    padding: 0;
    background-image: url(../img/bg.jpg);
    background-repeat: repeat;">
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
    $database = new mysqli('mysql_db', 'root', 'rootpass', 'dictionary');
    
    if (!$database)
    { 
        echo "Error";
        exit; 
    }
    $posted = $_POST['posted'];
    $posted = trim($posted); 
    $posted = htmlspecialchars($posted);

    $q1 = "SELECT dict_articles.article_id, dict_articles.term, dict_articles.part_speech, definitions.def_name, translations.transl_name, translations.transcription, contexts.rus_cont, contexts.eng_cont, contexts.source
    FROM dict_articles, definitions, translations, contexts, dict_cont, dict_transl
    WHERE dict_articles.definition = definitions.def_id AND contexts.cont_id = dict_cont.context AND dict_articles.article_id = dict_cont.article_forcont AND translations.transl_id = dict_transl.translation AND dict_articles.article_id = dict_transl.article_fortransl AND dict_articles.term LIKE '%$posted%';";
    $q2 = "SELECT dict_articles.term, contexts.rus_cont, contexts.eng_cont, contexts.source FROM dict_articles, contexts, dict_cont WHERE contexts.cont_id = dict_cont.context AND dict_articles.article_id = dict_cont.article_forcont AND dict_articles.term LIKE '%$posted%';";

    $result1 = mysqli_query($database, $q1); 
    $result2 = mysqli_query($database, $q2);
    $num_rows = mysqli_num_rows($result2);
    
    $row = mysqli_fetch_array($result1);
        echo "
        <b>$row[term]</b>
        <br>
        <i>$row[part_speech]</i>
        <hr>
        $row[transl_name] - /$row[transcription]/
        <hr>
        $row[def_name]
        <hr>";
    for ($i=0; $i<$num_rows; $i++){
        $row = mysqli_fetch_array($result2);
        echo"
        $row[rus_cont]
        <br>
        <br>
        $row[eng_cont]
        <hr>
        $row[source]
        <hr>";
    }
}
?>
    </div>
<body>