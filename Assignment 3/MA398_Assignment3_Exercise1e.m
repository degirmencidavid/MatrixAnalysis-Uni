%e)ii)
truexarr = [];
e0arr = [];
for n = 1:100
    %making A and b
    A = zeros(n);
    b = zeros(n,1);
    x = zeros(n,1);
    for i = 1:n
        A(i,i) = 4.1;
        b(i) = 1.0;
        if i ~= n
            A(i,i+1) = 2.0;
            A(i+1,i) = 2.0;
        end
    end
    truex = A\b;
    e0 = norm(truex - x,inf);
    e0arr = [e0arr;e0];    
end

plot(linspace(100,1),e0arr);
xlabel("n");
ylabel("||e_{0}||_{inf}");

%e)iii) (this takes a little while ~30 seconds)
%n is multiples of 128 up to 4096
nspace = [128 256 512 1024 2048 4096];
it = [];
itj = [];
for n = nspace
    %making A and b
    A = zeros(n);
    b = zeros(n,1);
    x = zeros(n,1);
    for i = 1:n
        A(i,i) = 4.1;
        b(i) = 1.0;
        if i ~= n
            A(i,i+1) = 2.0;
            A(i+1,i) = 2.0;
        end
    end
    %w=1 is G-S
    %it always seems to be 265, so I have capped the number of iterations
    %to 266 to speed it up
    [rk,xk,itr] = sor(A,b,266,1,1e-9);
    it = [it,itr(1)];
    %jacobi caps out at 840, so I only do 841 iterations
    [rkj,xkj,itrj] = jacobi(A,b,841,1e-9);
    itj = [itj,itrj(1)];
end



figure;
plot(nspace,it);
hold on
plot(nspace,itj);
hold off
title("Number of iterations of G-S for varying size of A");
xlabel("n");
ylabel("Number of iterations for G-S");
legend("G-S","Jacobi");
    
%e)iv)
n = 256;
A = zeros(n);
b = zeros(n,1);
x = zeros(n,1);
for i = 1:n
    A(i,i) = 4.1;
    b(i) = 1.0;
    if i ~= n
        A(i,i+1) = 2.0;
        A(i+1,i) = 2.0;
    end
end

[rk,xk,itr] = jacobi(A,b,1000,1e-9);
it = itr(1);
%this is the number of iterations for jacobi
disp(it);

%couldn't get sor to work for 0.2 and 0.4
wspace = linspace(0.6,2,8);
itrsarr = [];

for w = wspace
    [rks,xks,itrs] = sor(A,b,1000,w,1e-9);
    itrsarr = [itrsarr,itrs(1)];
end
figure;
plot(wspace,itrsarr);
title("Iteration changing with \omega values and n=256");
xlabel("\omega");
ylabel("Number of iterations");

%e)v)
n = 256;
A = zeros(n);
b = zeros(n,1);
x = zeros(n,1);
for i = 1:n
    A(i,i) = 4.1;
    b(i) = 1.0;
    if i ~= n
        A(i,i+1) = 2.0;
        A(i+1,i) = 2.0;
    end
end

tolspace = [1e-1 1e-2 1e-4 1e-8];
it = [];
itrsarr = [];
for tol = tolspace
    %jacobi
    [rk,xk,itr] = jacobi(A,b,1000,tol);
    it = [it, itr(1)];
    %sor with w=0.6
    [rks,xks,itrs] = sor(A,b,1000,0.6,tol);
    itrsarr = [itrsarr,itrs(1)];
end

figure;
plot(tolspace,it);
hold on
plot(tolspace,itrsarr);
hold off
title("Number of iterations with varying \epsilon and n=256")
xlabel("\epsilon")
ylabel("Number of iterations");

%the relationship between tol and the number of iterations makes sense,
%since the more generous tol is, the less iterations it takes
    