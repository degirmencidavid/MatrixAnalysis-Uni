%pretty much the same as my sd, except, of course, using the cg algorithm
%instead
function [rArr,x,itr] = CG(A,b,er,maxItr)
    rArr = [];
    x = b;
    r = b - A*x;
    d = r;
    itr = 1;
    del = r'*r;
    while((norm(r,2)>er) && (itr<= maxItr))
        rArr = [rArr,r];
        q = A*r;
        qd = A*d;
        alph = del / (qd'*d);
        x = x + alph*d;
        r = r - alph*A*d;
        del0 = del;
        del = r'*r;
        if (norm(r,2)>er)
            beta = del / del0;
            d = r + beta*d;
        end
        itr = itr + 1;
    end    
end
