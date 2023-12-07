%initialisation
Y = [];
m = 20;
%if m >= 17, the truncation error is so small, it is determined as 0 by
%matlab *


for n = 0:m
    %more initialisation
    A = [0,1;-1,0];
    sum = [1,0;0,1];
    currentTerm = [1,0;0,1];
    %for loop to calculate finitely truncated exponential from definition
    for i = 1:n
        currentTerm = currentTerm * A / i;
        sum = sum + currentTerm;
        %Y is an array that will containt the truncation error, represented
        %as the difference in the norms of the expm value and the truncated
        %value
        Y(n) = abs(norm(expm(A)) - norm(sum));
        %Z(n) = abs(norm(expm(A) - sum));
    end
end

%array for x and creating log arrays
X = [];
logX = [];
logY = [];
for i = 1:m
    X(i) = i;
    logX(i) = log(X(i));
    logY(i) = log(Y(i));
end

%plotting
plot(X, Y);
%*
xlim([0 17]);
%plot(logX, logY);
title("Decay of Truncation Error of the Matrix Exponential");
xlabel("Number of steps");
ylabel("Truncation error");
