clear all

%% Generating Patterns
for k=0:63
    Xstr (1:6)= dec2bin(k,6) ;
    for j =1:6
        Xnum(j)=str2num(Xstr(j)) ;
    end
    X( k+1 ,1:6)=Xnum ( 1 : 6 ) ;
end
X(:,7)= -1;
T=zeros(64 ,2) ;
idx1 =[ 8 , 12 , 14 , 15 , 29 , 45 , 53 , 57];
T(idx1,1)= 1;
idx2 =[ 16 , 61];
T( idx2 , 2 )= 1;

%% Training the model
x=X;
T=T;
lambda=0.90;scale=1;
w1=scale*(2*rand(7,6)-1);%values between+/-scale
w2=scale*(2*rand(7,2)-1);
epochs=5000;

error=zeros(epochs,1);
for epoch=1:epochs
    sum=0;
    for i=1:64
        % ===== Estimating
        % Neuron 1
        z_1 = w1(1,1)*x(i,1)+w1(2,1)*x(i,2)+w1(3,1)*x(i,3)+w1(4,1)*x(i,4)+w1(5,1)*x(i,5)+w1(6,1)*x(i,6) - w1(7,1); 
        h(1) = ro(z_1);
        % Neuron 2
        z_2 = w1(1,2)*x(i,1)+w1(2,2)*x(i,2)+w1(3,2)*x(i,3)+w1(4,2)*x(i,4)+w1(5,2)*x(i,5)+w1(6,2)*x(i,6) - w1(7,2);
        h(2) = ro(z_2);
        % Neuron 3
        z_3 = w1(1,3)*x(i,1)+w1(2,3)*x(i,2)+w1(3,3)*x(i,3)+w1(4,3)*x(i,4)+w1(5,3)*x(i,5)+w1(6,3)*x(i,6) - w1(7,3); 
        h(3) = ro(z_3);
        % Neuron 4
        z_4 = w1(1,4)*x(i,1)+w1(2,4)*x(i,2)+w1(3,4)*x(i,3)+w1(4,4)*x(i,4)+w1(5,4)*x(i,5)+w1(6,4)*x(i,6) - w1(7,4);
        h(4) = ro(z_4);
        % Neuron 5
        z_5 = w1(1,5)*x(i,1)+w1(2,5)*x(i,2)+w1(3,5)*x(i,3)+w1(4,5)*x(i,4)+w1(5,5)*x(i,5)+w1(6,5)*x(i,6) - w1(7,5); 
        h(5) = ro(z_5);
        % Neuron 6
        z_6 = w1(1,6)*x(i,1)+w1(2,6)*x(i,2)+w1(3,6)*x(i,3)+w1(4,6)*x(i,4)+w1(5,6)*x(i,5)+w1(6,6)*x(i,6) - w1(7,6);
        h(6) = ro(z_6);

        out1 = w2(1,1)*ro(z_1) + w2(2,1)*ro(z_2) + w2(3,1)*ro(z_3) + w2(4,1)*ro(z_4) + w2(5,1)*ro(z_5) + w2(6,1)*ro(z_6)  - w2(7,1);
        y1 = ro(out1);
        out2 = w2(1,2)*ro(z_1) + w2(2,2)*ro(z_2) + w2(3,2)*ro(z_3) + w2(4,2)*ro(z_4) + w2(5,2)*ro(z_5) + w2(6,2)*ro(z_6)  - w2(7,2);
        y2 = ro(out2);
        h(7) = -1;
        
%         if y1>0.5 && y2<0.5
%             T(i,1)
%             T(i,2)
%         end
    % ===== Back Propagation
        % ===== Updating Weights on the Output Layer
        for k=1:7
            w2(k,1) = w2(k,1) - lambda*(y1-T(i,1))*y1*(1-y1)*h(k);
            w2(k,2) = w2(k,2) - lambda*(y2-T(i,2))*y2*(1-y2)*h(k);
        end
        % ===== Updating Weights on the Hidden Layer
        for k=1:6
            for j=1:7
                w1(j,k)=w1(j,k) - lambda*((y1-T(i,1))*y1*(1-y1)*w2(k,1)*h(k)*(1-h(k))*x(i,j)+(y2-T(i,2))*y2*(1-y2)*w2(k,2)*h(k)*(1-h(k))*x(i,j));
            end
        end
        sum = sum + (((y1-T(i,1))^2)+((y2-T(i,2))^2))/2;
    end
    error(epoch,:)=sum/64;
end
figure
hold on
title('Error as a function of epochs')
xlabel('Epoch')
ylabel('Error')
plot(log10(error))
%yline(0.005,'--','error < 0.005','LineWidth',2)

%% Using the model
pattern=zeros(64,1);

for i=1:64
    % ===== Estimating
    z_1 = w1(1,1)*x(i,1)+w1(2,1)*x(i,2)+w1(3,1)*x(i,3)+w1(4,1)*x(i,4)+w1(5,1)*x(i,5)+w1(6,1)*x(i,6) - w1(7,1); 
    h(1) = ro(z_1);
    z_2 = w1(1,2)*x(i,1)+w1(2,2)*x(i,2)+w1(3,2)*x(i,3)+w1(4,2)*x(i,4)+w1(5,2)*x(i,5)+w1(6,2)*x(i,6) - w1(7,2);
    h(2) = ro(z_2);
    z_3 = w1(1,3)*x(i,1)+w1(2,3)*x(i,2)+w1(3,3)*x(i,3)+w1(4,3)*x(i,4)+w1(5,3)*x(i,5)+w1(6,3)*x(i,6) - w1(7,3); 
    h(3) = ro(z_3);
    z_4 = w1(1,4)*x(i,1)+w1(2,4)*x(i,2)+w1(3,4)*x(i,3)+w1(4,4)*x(i,4)+w1(5,4)*x(i,5)+w1(6,4)*x(i,6) - w1(7,4);
    h(4) = ro(z_4);
    z_5 = w1(1,5)*x(i,1)+w1(2,5)*x(i,2)+w1(3,5)*x(i,3)+w1(4,5)*x(i,4)+w1(5,5)*x(i,5)+w1(6,5)*x(i,6) - w1(7,5); 
    h(5) = ro(z_5);
    z_6 = w1(1,6)*x(i,1)+w1(2,6)*x(i,2)+w1(3,6)*x(i,3)+w1(4,6)*x(i,4)+w1(5,6)*x(i,5)+w1(6,6)*x(i,6) - w1(7,6);
    h(6) = ro(z_6);

    out1 = w2(1,1)*ro(z_1) + w2(2,1)*ro(z_2) + w2(3,1)*ro(z_3) + w2(4,1)*ro(z_4) + w2(5,1)*ro(z_5) + w2(6,1)*ro(z_6)  - w2(7,1);
    y1 = ro(out1);
    out2 = w2(1,2)*ro(z_1) + w2(2,2)*ro(z_2) + w2(3,2)*ro(z_3) + w2(4,2)*ro(z_4) + w2(5,2)*ro(z_5) + w2(6,2)*ro(z_6)  - w2(7,2);
    y2 = ro(out2);
    h(7) = -1;

    outputNN(i)=trainedXOR(y1,y2);
    if y1>0.5 && y2<0.5 % y1==1 && y2==0
        pattern(i)=3;
    elseif y1<0.5 && y2>0.5 % y1==0 && y2==1
        pattern(i)=4;
    else
       pattern(i)= 0;
    end

    if T(i,2)==1 || T(i,1)==1
        y2;
        y1;
    end
end
figures_identified = unique(pattern)
counter = hist(pattern,figures_identified)

