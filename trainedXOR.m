function [output] = trainedXOR(y1,y2)
    w1OR = [
        6.4088,   -5.1701;
        6.4217,   -5.1674;
        2.8390,   -7.7462;
    ];

    w2OR =[
        7.6671
        7.7434
       11.3409
    ];
    % ===== Estimating
    z_1 = w1OR(1,1)*y1 + w1OR(2,1)*y2 - w1OR(3,1); 
    z_2 = w1OR(1,2)*y1 + w1OR(2,2)*y2 - w1OR(3,2); 

    z = w2OR(1)*ro(z_1) + w2OR(2)*ro(z_2) - w2OR(3);
    y = ro(z);
    if y>0.5
        output=1;
    else
        output=0;
    end

end