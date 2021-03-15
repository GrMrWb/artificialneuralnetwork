clear all

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
for k=1:64
    A(1,1:2,k)=X(k,1:2) ;
    A(2,1:2,k)=X(k,3:4) ;
    A(3,1:2,k)=X(k,5:6) ;
end