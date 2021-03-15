clear all

net.trainParam.max_fail=50;
net.trainParam.min_grad=10^-25;
net.trainParam.goal=10^-8;
net.trainParam.max_mu=10^20;
net.trainParam.epochs=1000;

inputs = [0 1 0 1; 0 0 1 1];
targets = [0 1 1 0];
P=[-0.1 1;-0.1 1];
net=newff(P,[2,1],{'tansig','tansig'});
%*
net=train(net,inputs,targets);
outputs=sim(net,inputs); 