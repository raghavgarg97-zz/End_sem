#!/usr/bin/awk
BEGIN{
count_com=0
count_str=0
is_com1=0
is_com2=0
is_str=0
}
{	
	if(is_com2==1)count_com+=1
	n=split($0,arr,"")
	for(i=1;i<=n;i++)
	{
		if(arr[i]~/\// && arr[i+1]~/\// ){
		if(is_str==0 && (is_com1==0 && is_com2==0)){
		is_com1=1
		count_com+=1
		}
		}
		if(arr[i]~/\// && arr[i+1]~/\*/ ){
		if(is_str==0 && (is_com1==0 && is_com2==0)){
		is_com2=1
		count_com+=1
		}
		}
		
		if(arr[i]~/\*/ && arr[i+1]~/\//){
		if(is_com1==0){
		is_com2=0		
		}				
		}
		if(arr[i]=="\"")
		{
		if(is_com1==0 && is_com2==0){
		if(is_str==0){
			is_str=1
			count_str+=1
		}
		else if(is_str==1 && arr[i-1]!="\\"){
		is_str=0
		}
		}
		}
	}
	is_com1=0

}
END{
	print count_com"-"count_str
}
