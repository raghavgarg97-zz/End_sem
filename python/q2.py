import re
import sys
import numpy as np
import matplotlib.pyplot as plt
import math
fo=open('../train.csv','r')
lst1=[]
lst2=[]
text=fo.readline()
text=fo.readline()
while text:
	content=re.split(r',',text)
	data1=float(content[0])
	data2=float(re.split(r'\n',content[1])[0])
	lst1.append(data1)
	lst2.append(data2)
	text=fo.readline()
fo.close()
old_X_train=np.array(lst1)
Y_train=np.array(lst2)
One=np.ones((len(old_X_train),1))
X_train=np.column_stack((One,old_X_train))

fo=open('../test.csv','r')
lst1=[]
lst2=[]
text=fo.readline()
text=fo.readline()
while text:
	content=re.split(r',',text)
	data1=float(content[0])
	data2=float(re.split(r'\n',content[1])[0])
	lst1.append(data1)
	lst2.append(data2)
	text=fo.readline()
fo.close()
old_X_test=np.array(lst1)
Y_test=np.array(lst2)
One=np.ones((len(old_X_test),1))
X_test=np.column_stack((One,old_X_test))

w=np.random.rand(2,)
t=X_train.dot(w)

plt.figure(1)
plt.plot(old_X_train,Y_train,'bo')
plt.xlabel('Features')

plt.plot(old_X_train,t,'r')
plt.xlabel('Features')
plt.ylabel('X*w/Label')
plt.show()
w_direct=(np.linalg.inv((X_train.transpose()).dot(X_train))).dot((X_train.transpose()).dot(Y_train))
t=X_train.dot(w_direct)
plt.figure(2)
plt.plot(old_X_train,Y_train,'bo')

plt.plot(old_X_train,t,'r')
plt.xlabel('Features')
plt.ylabel('X*w/Label')
plt.show()


for i in range(2):	
	#loss=0
	for j in range(0,len(X_train)):
		ar=(0.00000001*((X_train[j])*(X_train[j].dot(w)-Y_train[j])))
		w[0]=w[0]-ar[0]
		w[1]=w[1]-ar[1]
		if j%100==0:
			t=X_train.dot(w)
			plt.plot(old_X_train,t,'r')
		
		#loss += (w[0] + w[1] * X_train[j][1] - Y_train[j])*(w[0] + w[1] * X_train[j][1] - Y_train[j])
	#print (loss) / len(X_train)
	

plt.plot(old_X_train,Y_train,'b')
plt.plot(old_X_train,X_train.dot(w),'r')		
plt.show()
sum1=0.0
sum2=0.0
#sum3=0.0
#sum4=0.0
for i in range(0,len(X_test)):
	sum1=sum1+(w[0]+w[1]*X_test[i][1]-Y_test[i])*(w[0]+w[1]*X_test[i][1]-Y_test[i])
	sum2=sum2+(w_direct[0]+w_direct[1]*X_test[i][1]-Y_test[i])*(w_direct[0]+w_direct[1]*X_test[i][1]-Y_test[i])
#for i in range(0,len(X_train)):
#	sum3=sum3+(w[0]+w[1]*X_train[i][1]-Y_train[i])*(w[0]+w[1]*X_train[i][1]-Y_train[i])
#	sum4=sum4+(w_direct[0]+w_direct[1]*X_train[i][1]-Y_train[i])*(w_direct[0]+w_direct[1]*X_train[i][1]-Y_train[i])
print math.sqrt(sum1/len(X_test))
print math.sqrt(sum2/len(X_test))
#print math.sqrt(sum3/len(X_train))
#print math.sqrt(sum4/len(X_train))


















