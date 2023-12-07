%setting tolerance, iteration number and creating A and b
maxiter = 100;
tol = 0.000001;
for i = 1:100
    A(i,i) = i;
    if i ~= 100
        A(i,i+1) = 1;
        A(i+1,i) = 1;
    end
end
b = ones(100,1);

%steepest descent
[rk,xk,itr] = SD(A,b,tol,maxiter);

y = zeros(itr-1,1);
k = zeros(itr-1,1);
for i = 1:itr-1
    y(i) = norm(rk(:,i), 2);
    k(i) = i;
end
%residual norms plot
plot(k,y);
xlabel("k value");
ylabel("Residual Norm");
hold on


%conjugate gradient
[rk,xk,itr] = CG(A,b,tol,maxiter);

y2 = zeros(itr-1,1);
k2 = zeros(itr-1,1);
for i = 1:itr-1
    y2(i) = norm(rk(:,i), 2);
    k2(i) = i;
end
%residual norms plot
plot(k2,y2);
hold off

legend("Steepest Descent", "Conjugate Gradient");

figure();

%steepest descent recalculated
[rk,xk,itr] = SD(A,b,tol,maxiter);
%Thm 25.2
%ek/e0 and condi
eke0 = zeros(itr-1,1);
condi = zeros(itr-1,1);
for i = 1:itr-1   
    eke0(i) = sqrt((rk(:,i)'*rk(:,i))/(rk(:,1)'*rk(:,1)));
    condi(i) = sqrt(1 - (1/cond(A))).^i;
end
%plot ek/e0 on x axis
plot(eke0,condi);
xlabel("||e^{(k)}||_{A} / ||e^{(0)}||_{A}");
ylabel("Bound on ||e^{(k)}||_{A} / ||e^{(0)}||_{A}|");
hold on

%conjugate gradient recalculated
[rk,xk,itr] = CG(A,b,tol,maxiter);
%Thm 25.4
%ek/e0 and condi
eke0 = zeros(itr-1,1);
condi = zeros(itr-1,1);
sq = sqrt(cond(A));
sqo = (sq+1)/(sq-1);
for i = 1:itr-1
    eke0(i) = sqrt((rk(:,i)'*rk(:,i))/(rk(:,1)'*rk(:,1)));
    condi(i) = 2*((sqo.^i)+(sqo.^(-i))).^(-1);
end
%plot ek/e0 on x axis
plot(eke0,condi);
hold off

legend("Steepest Descent","Conjugate Gradient");
