<html>
<head>
	<h1><center>View All records</center></h1>
	
</head>
<body>



	<br><br>
	<form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">
	Admin Login ID:  <input type="text" name="login"><br><br>
	Admin Password:  <input type="password" name="pass"><br><br>
	<input type="submit" name="submit" value="Submit">
	</form>
	<br><br>
	<a href="new.php" style="margin-left: 30px">Another Registration</a><br><br>

	<?php

	function trim_input($data)
	{
	  $data = trim($data);
	  $data = stripslashes($data);
	  $data = htmlspecialchars($data);
	  return $data;
	}


	if ($_SERVER["REQUEST_METHOD"] == "POST")
	{
		$login = trim_input($_POST["login"]);
 	    $password = trim_input($_POST["pass"]);

 	    if($login=="admin" && $password=="cs251"){
		display();
		}	
		else no_display();
	}

	



	function display(){
		$db=new SQLite3('bank_info.db');
		echo "<br><br>";
		echo "<h2>All Records:</h2>";
	  echo "<table style=\"width:50%\">
	    <tr>     <th>Name </th><th>Address </th><th>Email</th> <th>Mobile  </th> <th>Bank-A/C</th> </tr>";
	  $results = $db->query('select * from records');
	  while ($row = $results->fetchArray())
	    echo "<tr><td>$row[0]</td><td>$row[1]</td><td>$row[2]</td><td>$row[3]</td><td>$row[4]</td> </tr>";
	  echo "</table><br>";

	}

	function no_display(){
		echo "You are not a registered user";
	}

?>




</body>
</html>
