
function validate(){
	var name=document.getElementById("name").value;
	var address=document.getElementById("address").value;
	var mobile=document.getElementById("mobile").value;
	var account=document.getElementById("account").value;
	var password=document.getElementById("password").value;
	var email=document.getElementById("email").value;
	var isbreak=0;

	if(name.length>20 || name.length==0){
		document.getElementById("name_mes").innerHTML="  Max 20 and minimum 0 characters allowed ";
		isbreak=1;
	}
	if(/[^a-z ]/i.test(name)){
		var val=document.getElementById("name_mes");
		if(name.length>20 || name.length==0)
		val.innerHTML="  Max 20 and minimum 0 characters allowed and  Only alphabets and spaces allowed";
		else val.innerHTML=" Only alphabets and spaces allowed";
		isbreak=1;	
	}
	if(name.length<=20 && name.length>0 && !(/[^a-z ]/i.test(name))){
			document.getElementById("name_mes").innerHTML="";
	}

	if(address.length>100 || address.length==0){
		document.getElementById("address_mes").innerHTML=" Maximum 100 characters of alphabets allowed";
		isbreak=1;	
	}
	else{
		document.getElementById("address_mes").innerHTML="";
	}

	var res=email.split("@");

	if(res.length!=2 ){
		document.getElementById("email_mes").innerHTML=" Enter proper email of format someone@xyz.com";
		isbreak=1;
	}
	else{
			var end=res[1].split(".");

			if(end.length!=2 ){
				document.getElementById("email_mes").innerHTML=" Enter proper email of format someone@xyz.com";
				isbreak=1;
			}
			else{
				if(/[^a-z]/i.test(res[0])){
					document.getElementById("email_mes").innerHTML=" Enter proper email of format someone@xyz.com";
					isbreak=1;
				}
				else if(end[1]!="com"){
					document.getElementById("email_mes").innerHTML=" Enter proper email of format someone@xyz.com";
					isbreak=1;
				}
				else{
					document.getElementById("email_mes").innerHTML="";
				}
				
				
			}
		}
	
	if(!(/^[1-9][0-9]{9}$/.test(mobile))){
		var val=document.getElementById("mobile_mes");
		val.innerHTML=" Monile number is not valid";
		isbreak=1;
	}
	if( /^[1-9][0-9]{9}$/.test(mobile)){
		document.getElementById("mobile_mes").innerHTML="";	
	}

	if(account.length!=5){
		document.getElementById("account_mes").innerHTML=" account number length should be exactly 5 digit ";
				isbreak=1;
	}
	if(!(/^[0-9]{5}$/.test(account))){
		var val2=document.getElementById("account_mes");
		val2.innerHTML=" account number length should be exactly 5 digit and Only Numbers are allowed";
		isbreak=1;
	}
	if(/^[0-9]{5}$/.test(account)){
		document.getElementById("account_mes").innerHTML="";	
	}

	if(password.length>20 || password.length==0){
		document.getElementById("password_mes").innerHTML="  Max 20 and minimum 0 characters allowed ";
		isbreak=1;
	}
	if(/[^a-z0-9]/i.test(password)){
		var val=document.getElementById("password_mes");
		if(password.length>20 || password.length==0)
		val.innerHTML="  Max 20 and minimum 0 characters allowed and  Only alphabets and numbers allowed";
		else val.innerHTML=" Only alphabets and numbers allowed";
		isbreak=1;	
	}
	if(password.length<=20 && password.length>0 && !(/[^a-z0-9]/i.test(password))){
			document.getElementById("password_mes").innerHTML="";
	}




	if(isbreak==1)return false;
}
