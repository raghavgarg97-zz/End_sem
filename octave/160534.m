#1
m=csvread("train.csv",1,0);
x_train1=m(:,1);
y_train=m(:,2);
x_1=ones(length(x_train1),1);
x_train=[x_1,x_train1];

#2
w=randn(2,1);

#3
hold on;
scatter(x_train1,y_train);
xlabel("X_train");
ylabel("Y_train");
 title ("First Plot");
plot(x_train1,x_train*w);
pause(5);
close;

#4
w_direct=inv((x_train')*x_train)*((x_train')*y_train);
hold on;
scatter(x_train1,y_train);
xlabel("X_train");
ylabel("Y_train");
 title ("Second Plot");
plot(x_train1,x_train*w_direct);
pause(5);
close;

#5
hold on;
scatter(x_train1,y_train);
xlabel("X_train");
ylabel("Y_train");
 title ("third Plot");

for i=1:2,
for j=1:length(x_train1),
	w=w-0.00000001*((x_train(j,:)*w)-y_train(j,:))*(x_train(j,:)');
	if mod(j,100)==0,
		plot(x_train1,x_train*w);
	end;
end;
end;
pause(5);
close;


#6

m=csvread("test.csv",1,0);
x_test1=m(:,1);
y_test=m(:,2);
x_2=ones(length(x_test1),1);
x_test=[x_2,x_test1];
pred_1=x_test*w;
pred_2=x_test*w_direct;
y1=sqrt(mean((pred_1-y_test).^2))
y2=sqrt(mean((pred_2-y_test).^2))

