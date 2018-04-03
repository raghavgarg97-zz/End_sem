#!/bin/bash
IFS=$'\n'
print_tree(){
local count1=0
local count2=0
if [[ -f "$1" ]];
then
a=$(basename $1)
var=$(echo $a|grep -oE '.c$'|wc -l)
if [ $var == "1" ];then
str=$(awk -f q1.awk $1)
count1=`echo $str|cut -d "-" -f1`
count2=`echo $str|cut -d "-" -f2`
echo "$count1-$count2"
else echo "0-0"
fi
elif [[ -d "$1" ]];
then
for i in $(ls "$1");
do
str=$(print_tree "$1/$i") 
tcount1=`echo $str|cut -d "-" -f1`
tcount2=`echo $str|cut -d "-" -f2`
count1=$(($count1+$tcount1))
count2=$(($count2+$tcount2))
done
echo "$count1-$count2"
fi
}
print_tree $1 

