import sys
from sys import argv
import re
num=argv[1]
is_neg=0
if num[0]=='-':
	is_neg=1
	num=num[1:]
base=argv[2]
base=int(base)
lst=re.split(r'\.',num)
if len(lst)>2:
	print "invalid input"
	sys.exit(0)	
limit=min(10,base)
check=base-10
count=0
num1=lst[0]
width=len(num1)-1
mult=1
while width>=0:
	character=num1[width]
	if 48<=ord(character)<48+limit:
		count+=((ord(character)-48)*mult)
		mult=mult*base
		width-=1
	elif 65<=ord(character)<65+check:
		count+=((ord(character)-55)*mult)
		mult=mult*base
		width-=1
	else:
		print "invalid input"
		sys.exit(0)	
mult=1.0/base
width=0
if(len(lst)>1):
	num1=lst[1]
	while width<=len(num1)-1:
		character=num1[width]
		if 48<=ord(character)<48+limit:
			count+=((ord(character)-48)*mult)
			mult=mult/base
			width+=1
		elif 65<=ord(character)<65+check:
			count+=((ord(character)-55)*mult)
			mult=mult/base
			width+=1
		else:
			print "invalid input"
			sys.exit(0)	
if is_neg:
	print "-"+str(count)
else:
	print count

















