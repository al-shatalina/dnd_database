<form action="php/func_search.php" method="post">
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.3/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
    <input type="hidden" name="posted" value="true"> 
      <label for="tags"><input name="posted" type=text class="submit" id="tags" onkeyup="function()">
    <label>
     <input type="submit" value="Поиск"><br>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
  <script src="https://code.jquery.com/ui/1.13.3/jquery-ui.js"></script>
  <script>
  $(function() {
    var availableTags = [];
    $("#tags").autocomplete({
      source: availableTags
    });
  } );
      
  </script>
    </form>