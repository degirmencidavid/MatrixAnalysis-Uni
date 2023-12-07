%tol is for e)
function [r,x,itr] = jacobi(A,b,n,tol)
    D = diag(diag(A));
    L = tril(A)-D;
    U = triu(A)-D;
    r = zeros(n,1);
    x = zeros(size(b));
    itr = [];
    for k = 1:n
        x = D\(b - (U+L)*x);
        r(k) = norm(b - A*x, Inf);
        %the iteration check is here
        if(r(k)/norm(b,inf)<=tol)
            itr = [itr,k];
        end
    end
end