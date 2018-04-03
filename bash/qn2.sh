#!/bin/bash
tcount1=0
tcount2=0

print_tree(){
local count1=0
local count2=0
if [[ -f "$1" ]];
then
tcount1=$(cat $1|tr '\n' ' ' |grep -oE "[^0-9][\.\?\!].|[0-9][\.][^0-9]|[0-9][\!\?]."|wc -w)
#tcount2=$(cat $1|tr '\n' ' ' |sed 's/ /  /g'|sed 's/?/??/g'|sed 's/!/!!/g'|grep -oE " [0-9]+ | [0-9]+\.[^0-9]|^[0-9]+ |^[0-9]+\.[^0-9]|[^.][0-9]+[\?\!]|[^0-9]\.[0-9]+[\?\!]|[^0-9]\.[0-9]+ |[\?\!][0-9]+ |[^0-9]\.[0-9]+\.[^0-9]|[\?\!][0-9]+\.[^0-9]| -[0-9]+ | -[0-9]+\.[^0-9]|^-[0-9]+ |^-[0-9]+\.[^0-9]|[^.]-[0-9]+[\?\!]|[^0-9]\.-[0-9]+[\?\!]|[^0-9]\.-[0-9]+ |[\?\!]-[0-9]+ |[^0-9]\.-[0-9]+\.[^0-9]|[\?\!]-[0-9]+\.[^0-9]"|wc -w)
tcount2=$(cat $1|tr '\n' ' '| sed 's/[0-9]\+\.[0-9]\+/hello/g'|grep -oE '[0-9]+'|wc -w)
wod=""
for i in `seq 1 $2`;
do
wod="$wod\t"
done
echo  -e "$wod(F)$(basename $1)-$tcount1-$tcount2"
elif [[ -d "$1" ]];
then
local tabs=$(($2+1))
for i in $(ls "$1");
do
print_tree "$1/$i" $tabs
count1=$(($count1+$tcount1))
count2=$(($count2+$tcount2))
done
wod=""
for i in `seq 1 $2`;
do
wod="$wod\t"
done
echo -e "$wod(D)$(basename $1)-$count1-$count2"
tcount1=$count1
tcount2=$count2

fi
}
print_tree $1 0

