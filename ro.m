function [y] = ro(z)
    for i=1:length(z)
       y(i)=1 / (1+exp(-z(i))); 
    end
end