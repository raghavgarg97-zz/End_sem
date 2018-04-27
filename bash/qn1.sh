#!/bin/bash

print_One(){
case $1 in
0) echo "";;
1) echo "one";;
2) echo "two";;
3) echo "three";;
4) echo "four";;
5) echo "five";;
6) echo "six";;
7) echo "seven";;
8) echo "eight";;
9) echo "nine";;
esac
}
print_Two(){
num=$1
char1=`echo ${num:0:1}`
char2=`echo ${num:1:1}`
var=$(print_One $char2)
foo=""
case $char1 in
0) foo="$var";;
1) case $char2 in
	0) echo "ten";;
	1) echo "eleven";;
	2) echo "twelve";;
	3) echo "thirteen";;
	4) echo "fourteen";;
	5) echo "fifteen";;
	6) echo "sixteen";;
	7) echo "seventeen";;
	8) echo "eighteen";;
	9) echo "nineteen";;
	esac ;;
2) foo="twenty $var";;
3) foo="thirty $var";;
4) foo="fourty $var";;
5) foo="fifty $var";;
6) foo="sixty $var";;
7) foo="seventy $var";;
8) foo="eighty $var";;
9) foo="ninety $var";;
esac
echo $foo
}

print_Hun(){

num=$1
char1=`echo ${num:0:1}`
char2=`echo ${num:1:1}`
char3=`echo ${num:2:1}`
num1=$(print_One "$char1")
num2=$(print_Two "$char2$char3")
if [ "$char1" == 0 ];
then
echo "$num2"
else
echo "$num1 Hundred $num2"
fi
}

print_Th(){
num=$1
char1=`echo ${num:0:1}`
char2=`echo ${num:1:1}`
char3=`echo ${num:2:1}`
char4=`echo ${num:3:1}`
num1=$(print_One "$char1")
num3=$(print_Hun "$char2$char3$char4")
if [ "$char1" == "0" ]; 
then
echo "$num3"
else
echo "$num1 Thousand $num3"
fi
}
: '
print_seven(){


num=$1
char1=`echo ${num:0:1}`
char2=`echo ${num:1:1}`
char3=`echo ${num:2:1}`
char4=`echo ${num:3:1}`
char5=`echo ${num:4:1}`
char6=`echo ${num:5:1}`
char7=`echo ${num:6:1}`
if [ "$char1" != "0" ];
then
ind2=$(print_Two "$char1$char2")
  ind=$(print_Two "$char3$char4")
  ind1=$(print_Hun "$char5$char6$char7")
   if [ "$ind" == "" ];
  then 
  word="$ind2 lakh $ind1"
  else
  word="$ind2 lakh $ind thousand $ind1"
  fi
else
ind2=$(print_One "$char1")
  ind=$(print_Two "$char2$char3")
  ind1=$(print_Hun "$char4$char5$char6")
  if [ "$ind" == "" ];
  then 
  word="$ind2 lakh $ind1"
  else
  word="$ind2 lakh $ind thousand $ind1"
  fi
fi

}'

if [ $# == 0 ];
	then
	echo "Enter command"
	exit
	fi
txt=$0
zero="0"
open=`echo $txt|fold -w 1`
for i in $open;
do
if [ "$i" != "0" ];
then
break
fi
txt=${txt#$zero}
done
len1=`echo $txt|wc -c`
let len1-=1
if [ $len1 == 0 ];
then
echo "zero"
exit
fi
if [ $len1 -gt 11 ];
then
echo "invalid input"
exit
fi
regex='^[0-9]*$'
if [[ $txt =~ $regex ]];
then
char1=`echo ${txt:0:1}`
char2=`echo ${txt:1:1}`
char3=`echo ${txt:2:1}`
char4=`echo ${txt:3:1}`
char5=`echo ${txt:4:1}`
char6=`echo ${txt:5:1}`
char7=`echo ${txt:6:1}`
char8=`echo ${txt:7:1}`
char9=`echo ${txt:8:1}`
char10=`echo ${txt:9:1}`
char11=`echo ${txt:10:1}`
case $len1 in
1)ind=$(print_One $txt)
  word="$ind";;
2)ind=$(print_Two $txt)
  word="$ind";;
3)ind=$(print_Hun $txt)
  word="$ind";;
4)ind=$(print_Th $txt)
  word="$ind";; 
5)ind=$(print_Two "$char1$char2")
  ind1=$(print_Hun "$char3$char4$char5")
  word="$ind thousand $ind1";;
6)ind2=$(print_One "$char1")
  ind=$(print_Two "$char2$char3")
  ind1=$(print_Hun "$char4$char5$char6")
  if [ "$ind" == "" ];
  then 
  word="$ind2 lakh $ind1"
  else
  word="$ind2 lakh $ind thousand $ind1"
  fi;;
7)ind2=$(print_Two "$char1$char2")
  ind=$(print_Two "$char3$char4")
  ind1=$(print_Hun "$char5$char6$char7")
   if [ "$ind" == "" ];
  then 
  word="$ind2 lakh $ind1"
  else
  word="$ind2 lakh $ind thousand $ind1"
  fi;;
8)ind3=$(print_One "$char1")
  ind2=$(print_Two "$char2$char3")
  ind=$(print_Two "$char4$char5")
  ind1=$(print_Hun "$char6$char7$char8")
  if [ "$ind2" == "" ];
  then 
  	if [ "$ind" == "" ];
  	then
  	word="$ind3 crore $ind1"
	else 
	word="$ind3 crore $ind thousand $ind1"
	fi
  else
	if [ "$ind" == "" ];
        then 
        word="$ind3 crore $ind2 lakh $ind1"
        else 
  	word="$ind3 crore $ind2 lakh $ind thousand $ind1"
        fi
fi;;
9)ind3=$(print_Two "$char1$char2")
  ind2=$(print_Two "$char3$char4")
  ind=$(print_Two "$char5$char6")
  ind1=$(print_Hun "$char7$char8$char9")
    if [ "$ind2" == "" ];
  then 
  	if [ "$ind" == "" ];
  	then
  	word="$ind3 crore $ind1"
	else 
	word="$ind3 crore $ind thousand $ind1"
	fi
  else
	if [ "$ind" == "" ];
        then 
        word="$ind3 crore $ind2 lakh $ind1"
        else 
  	word="$ind3 crore $ind2 lakh $ind thousand $ind1"
        fi
fi;;
 
10)ind3=$(print_Hun "$char1$char2$char3")
  ind2=$(print_Two "$char4$char5")
  ind=$(print_Two "$char6$char7")
  ind1=$(print_Hun "$char8$char9$char10")
      if [ "$ind2" == "" ];
  then 
  	if [ "$ind" == "" ];
  	then
  	word="$ind3 crore $ind1"
	else 
	word="$ind3 crore $ind thousand $ind1"
	fi
  else
	if [ "$ind" == "" ];
        then 
        word="$ind3 crore $ind2 lakh $ind1"
        else 
  	word="$ind3 crore $ind2 lakh $ind thousand $ind1"
        fi
fi;;
 
  
11)ind3=$(print_Th "$char1$char2$char3$char4")
  ind2=$(print_Two "$char5$char6")
  ind=$(print_Two "$char7$char8")
  ind1=$(print_Hun "$char9$char10$char11")
    if [ "$ind2" == "" ];
  then 
  	if [ "$ind" == "" ];
  	then
  	word="$ind3 crore $ind1"
	else 
	word="$ind3 crore $ind thousand $ind1"
	fi
  else
	if [ "$ind" == "" ];
        then 
        word="$ind3 crore $ind2 lakh $ind1"
        else 
  	word="$ind3 crore $ind2 lakh $ind thousand $ind1"
        fi
fi;;
 

esac
echo $word
else
echo "invalid input"
fi






