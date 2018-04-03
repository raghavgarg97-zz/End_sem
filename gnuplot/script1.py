import sys
from sys import argv
import math

x=[]
y=[]
z=[]

with open("params.txt") as f:
    for line in f:
        a=line.split(" ")
	for i in a:
		x.append(int(i))


with open("threads.txt") as f:
    for line in f:
        a=line.split(" ")
	for i in a:
		y.append(int(i))


with open("runtest") as f:
    for line in f:
        a=line.split(" ")
	z.append(a[3])
#PLOT 2 DATA

average=[]
variance=[]
index1=0
index2=0

count=0
element=0
squareval=0
processed_1=open("analyse","w+")
for k in range(0,len(x)):
	for j in range(0,5):
		count=j*100+k*500;
		for i in range(0,100):
			element=element+int(z[count])
			count=count+1		
		average.append(float(element)/100)
		element=0
		

for k in range(0,len(x)):
	index1=k*5
	for j in range(0,5):
		index2=index1+j
		count=j*100+k*500;
		local_speedup=float(average[index1])/float(average[index2])
		for i in range(0,100):
			t=(float(average[index1])/int(z[count]))-local_speedup
			squareval=squareval+t*t
			count=count+1		
		variance.append(squareval/100)
		squareval=0

processed_1.write('\n')

for i in range(0,len(x)):
	processed_1.write(str(x[i])+' ')
	for j in range(0,5):

		ind=i*5+j
		processed_1.write(str(average[ind])+' ')
	for j in range(0,5):
		ind=i*5+j
		processed_1.write(str(variance[ind])+' ')
	processed_1.write('\n')
	

count=0
processed_1.write('\n')
'''for i in average:
	print str(i)+'\n'
'''
#PLOT 1 DATA

for i in range(0,5):
	for j in range(0,len(x)):
		count=i*100+j*500;
		for k in range(0,100):
			element=z[count]
			count=count+1		
			processed_1.write(str(x[j])+' '+str(element)+'\n')
	processed_1.write('\n')






	

















