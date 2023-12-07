function [L,U] = recursive_lu(A)
    
    %some notes about my code:
    %This doesn't return the same L,U as matlab's lu() method, but it still
    %provides an L,U that satisfy the relationship A=LU. I think this is
    %probably because lu() uses a much more sophisticated algorithm.
    %Additionally, I think that it would have been possible to create a
    %more efficient algorithm, which incurs two recursive calls and splits
    %the matrix differently, rather than row,col by row,col per call.
    
    %m is useless, but size() returns both dimensions
    [m,n] = size(A);
    
    %base case
    if n == 1
        L = 1;
        U = A;
        return;
    end
    
    %setting up ALU form
    A11 = A(1,1);
    A12 = A(1,2:n);
    A21 = A(2:n,1);
    A22 = A(2:n,2:n);
    
    L11 = 1;
    U11 = A11;
    U12 = A12;
    L21 = A21 / U11;
    %for loop to fill op array as the outer product
    for j = 1:n-1
            for k = 1:n-1
            %op(k,j) =  U12(j) * L21(k) / A11; wrong way around
            op(k,j) =  A21(k) * A12(j) / A11;
            %calculating outer product and dividing by scalar A11
            end
    end
    
    %debugging
    %disp(op);
    %disp(A22);

    S = A22 - op;
    
    %recursive call
    [L22, U22] = recursive_lu(S);
    
    L12(1:n-1) = 0;
    U21(1:n-1) = 0;
    U21 = transpose(U21);
    %without transposing, U21 is wrong way around    
    
    %setting up current L,U to pass up
    L = [L11, L12; L21, L22];
    U = [U11, U12; U21, U22];
    return;
end