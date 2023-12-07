%more than 10 uses lots of ram and matlab does not like it, I
%assume that is normal for over 4 million matrix entries
for k = 1:10
    mat = rand(2.^k);
    tic;
    recursive_lu(mat);
    time(k) = toc;
end

for i = 1:k
    X(i) = i;
end

%time graph
figure(1)
plot(X, time);
title("Runtimes of matrices with size 2^{k}");
xlabel("k");
ylabel("Runtime(s)");

%seems like cubic complexity, hard to tell exactly just off of time graph,
%but it looks very similar to O(n^3) complexity

%log graph
figure(2)
plot(X, log(time));
title("Log (ln) of runtimes of matrices with size 2^{k}");
xlabel("k");
ylabel("ln(runtime)");