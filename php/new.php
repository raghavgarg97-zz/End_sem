<!DOCTYPE HTML>  
<html>
<head>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="myown.css">
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400;300' rel='stylesheet' type='text/css'>
<script type='text/javascript' src="script.js"></script>
</head>
<body>  



<?php
// define variables and set to empty values
$db = new SQLite3('bank_info.db');
$db->query("create table records(name varchar(20), addresss varchar(100), email varchar(30), mobile integer, acc_no varchar(5), b_password varchar(20))");
$db->query("create table balance(acc_no varchar(5), b_password varchar(20), money integer)");

function isexist($db, $email)
{
  $info = $db->query("select * from records where email like '".$email."'");
  if ($info->fetchArray())
    return false;
  else
    return true;
}


function valid($db,$value)
{
  $info = $db->query("select * from balance where acc_no like '".$value[4]."'");
  $row = $info->fetchArray();
  if ($row[1] != $value[5])
    return false;
  else
    return true;
}

function update_acc($db,$account)
{
  $info= $db->query("select * from balance where acc_no like '".$account."'");
  $row = $info->fetchArray();
  if ($row[2] > 1000)
  {
    $db->query("update balance set money = ".($row[2] - 1000)." where acc_no = '".$account."' ");
    return true;
  }
  else
    return false;
}


function trim_input($data)
{
  $data = trim($data);
  $data = stripslashes($data);
  $data = htmlspecialchars($data);
  return $data;
}

$message="";

if ($_SERVER["REQUEST_METHOD"] == "POST")
{
  $value = array();
  $value[0] = trim_input($_POST["name"]);
  $value[1] = trim_input($_POST["address"]);
  $value[2] = trim_input($_POST["email"]);
  $value[3] = trim_input($_POST["mobile"]);
  $value[4] = trim_input($_POST["account"]);
  $value[5] = trim_input($_POST["password"]);
  $qstr = "insert into records values ('".$value[0]."', '".$value[1]."', '".$value[2]."', '".$value[3]."', '".$value[4]."', '".$value[5]."')";

  if(isexist($db,$value[2])){
  	if(valid($db,$value)){
  		if(update_acc($db,$value[4])){
  			   $message="Registration Successful";
          $insres = $db->query($qstr);
  		}
  		else
        $message="Insufficient Balance";
        }
    else
        $message="Invalid Login/Password";
  }
  else
        $message="Already Registered";

echo "<script type=\"text/javascript\">alert('".$message."');</script>";
}

   


?>

<body>
<div class="heading">
<h2><center>Lets Build Stuff</center></h2>
<h4><center>Registraction Process</center></h4>
</div>
	<form  onsubmit="return validate()" method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">
	 <font color="white"><label>Name:  </label>	</font>  <input type="text" id="name" name="name" ><p id="name_mes"> </p><br><br>
	 <font color="white"> <label>Address:  </label></font>	  <input type="text" name="address" id="address" size="35" ><p id="address_mes"></p><br><br>
	 <font color="white"> <label>Email:  </label></font>	  <input type="text" name="email" id="email"><p id="email_mes"></p><br><br>
	 <font color="white"> <label>Mobile:  </label></font>	  <input type="text" name="mobile" id="mobile"><p id="mobile_mes"></p><br><br>
	 <font color="white"> <label>Account:  </label></font>	  <input type="text" name="account" id="account"><p id="account_mes"></p><br><br>
	  <font color="white"> <label>Password:  </label></font>	  <input type="password" name="password" id="password"><p id="password_mes"></p><br><br><br><br>

	  <input type="submit" value="Submit" align="center">
	</form> 

<br>
<a href="viewall.php" style="color:white;margin-left: 30px">See All Registrations</a>



</body>
</html>
