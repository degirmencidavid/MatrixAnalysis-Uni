function [V] = vandermonde(x,d)
V = [];
n = length(x);%why not do this instead of taking d as an argument?
    for i = 1:n
        V = [V; x(i).^(0:n-1)];
    end  
end
        
    