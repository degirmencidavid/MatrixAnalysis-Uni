%A,b are self explanatory, er is the tolerance
%I set x to be whatever b is, in the case of the question, it is a
%column of 100 1s so it is a fine starting point. Perhaps this should
%be set and defined outside of the function in other cases, but it
%suffices here.
%rather than using a for loop and an if else(like in the notes), this returns x by default if
%the first condition in the while loop is not met, that is to say if
%the norm(r,2)<=er then it will just end the loop. If this wasn't
%matlab, I'd do it identically to the algorithm in the notes.
%I also set a preliminary value for a delta (del)

function [rArr,x,itr] = SD(A,b,er,maxItr)
    rArr = [];
    x = b;
    itr = 1;%iteration step
    r = b - A*x;
    del = r'*r;
    while((norm(r,2)>er) && (itr <= maxItr))
        rArr = [rArr,r];
        q = A*r;
        alph = del / (q'*r);
        x = x + alph*r;
        r = r - alph*q;
        del = r'*r;
        itr = itr+1;
    end
end