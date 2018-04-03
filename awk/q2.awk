#!/usr/bin/awk
BEGIN{
}
{
	sender=$3
	split($5,temp,":")
	receiver=temp[1]
	split($1,time,":")
	val=time[3]+time[2]*60+time[1]*3600
	if((sender,receiver,0) in arr){
	arr[sender,receiver,6]=val
	arr[sender,receiver,0]+=1
	}
	else{
	arr[sender,receiver,5]=val
	arr[sender,receiver,6]=val
	arr[sender,receiver,0]+=1
	}
	if($NF!=0){
	arr[sender,receiver,1]+=1
	split($9,sequence,":")
	split(sequence[2],seqo,",")
	for(k=sequence[1]+1;k<=seqo[1];k++){
		if((sender,receiver,k) in brr){
		arr[sender,receiver,2]+=1
		arr[sender,receiver,3]+=1
	}
	else{
		brr[sender,receiver,k]=0
		arr[sender,receiver,2]+=1	
	}

	}

	}
	
	
}
END{
packets=0;data_packets=0;bytes=0;retrans=0;xput=0;
for(i in arr){
split(i,box,SUBSEP)
if((box[1],box[2]) in crr){
}
else{
for(j=0;j<=6;j++){
if((box[1],box[2],j) in arr){
	v[j]=arr[box[1],box[2],j]
if((box[2],box[1],5) in arr){
	if(j==5){
	val1=arr[box[1],box[2],5]
	val2=arr[box[2],box[1],5]
	val3=arr[box[1],box[2],6]
	val4=arr[box[2],box[1],6]
	if(val2<val1)val1=val2
	if(val4>val3)val3=val4
	v[7]=val3-val1
	v[4]=(v[2]-v[3])/v[7]
}
}
else{v[4]=0}
}
else{v[j]=0}
}
crr[box[1],box[2]]=0
crr[box[2],box[1]]=0
split(box[1],boxf1,".")
split(box[2],boxf2,".")
print "Connection(A="boxf1[1]"."boxf1[2]"."boxf1[3]"."boxf1[4]":"boxf1[5]" B="boxf2[1]"."boxf2[2]"."boxf2[3]"."boxf2[4]":"boxf2[5]")"
print "A-->B #packets="v[0]",#datapackets="v[1]",#bytes="v[2]",#retrans="v[3]" xput="int(v[4])" bytes/sec"
for(j=0;j<=3;j++){
if((box[2],box[1],j) in arr){
	v[j]=arr[box[2],box[1],j]
}
else v[j]=0
}
if(v[7]!=0){v[4]=(v[2]-v[3])/v[7]}else v[4]=0
print "B-->A #packets="v[0]",#datapackets="v[1]",#bytes="v[2]",#retrans="v[3]" xput="int(v[4])" bytes/sec"
print " "
for(j=0;j<=7;j++)v[j]=0
}

}
}
