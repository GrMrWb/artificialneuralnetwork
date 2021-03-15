clear all
x=[0 0 -1; 0 1 -1; 1 0 -1; 1 1 -1];
T=[0; 1; 1; 0];
lambda=0.85;scale=1;
w1OR=scale*(2*rand(3,2)-1);%values between+/-scale
w2OR=scale*(2*rand(3,1)-1);
epochs=3000;

error=zeros(epochs,4);
for epoch=1:epochs
    avg=0;
    for i=1:4
        % ===== Estimating
        z_1 = w1OR(1,1)*x(i,1)+w1OR(2,1)*x(i,2) - w1OR(3,1); 
        h(1) = ro(z_1);
        z_2 = w1OR(1,2)*x(i,1)+w1OR(2,2)*x(i,2) - w1OR(3,2); 
        h(2) = ro(z_2);

        z = w2OR(1)*ro(z_1) + w2OR(2)*ro(z_2) - w2OR(3);
        y = ro(z);
        h(3) = -1;
    % ===== Back Propagation
        % ===== Updating Weights on the Output Layer
        for k=1:3
            w2OR(k) = w2OR(k) - lambda*(y-T(i))*y*(1-y)*h(k);
        end
        % ===== Updating Weights on the Hidden Layer
        for k=1:2
            for j=1:3
                w1OR(j,k)=w1OR(j,k) - lambda*(y-T(i))*y*(1-y)*w2OR(k)*h(k)*(1-h(k))*x(i,j);
               end
        end
        avg(i) = ((y-T(i))^2)/2;
    end
    error(epoch,:)=avg;
end
figure
hold on
title('Error as a function of epochs')
xlabel('Epoch')
ylabel('Error')
plot(error)
yline(0.005,'--','error < 0.005','LineWidth',2)
legend('x1=0, x2=0','x1=0, x2=1','x1=1, x2=0','x1=1, x2=1','error =     0.005')

%% Best Values
w1OR = [
    6.4088,   -5.1701;
    6.4217,   -5.1674;
    2.8390,   -7.7462;
]

w2OR =[
    7.6671;
    7.7434;
   11.3409;
]

for i=1:4
    % ===== Estimating
    z_1 = w1OR(1,1)*x(i,1)+w1OR(2,1)*x(i,2) - w1OR(3,1); 
    h(1) = ro(z_1);
    z_2 = w1OR(1,2)*x(i,1)+w1OR(2,2)*x(i,2) - w1OR(3,2); 
    h(2) = ro(z_2);

    z = w2OR(1)*ro(z_1) + w2OR(2)*ro(z_2) - w2OR(3);
    y = ro(z)
    h(3) = -1;
end