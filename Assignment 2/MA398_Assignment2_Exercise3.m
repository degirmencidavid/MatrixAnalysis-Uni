%3(a)
%for loop to go through multiple values of n, increment to put k values in
%an array
incr = 1;
%n is the number of points between [-1,1], X is the matrix of x_0 ... x_n
for n = [1 5 10 20 40 60 80 100]
    X = linspace(-1,1,n);
    %generating vandermonde matrix and calculating condition number
    V = vandermonde(X,n-1);
    k = cond(V);
    kVals(incr) = k;
    incr = incr+1;
end


%3(c)

%going through the 101, 256 and 512 points between [-1,1]
for n = [101 256 512]
    
    %function
    f = @(x) 1/(1+25*x^2);
    %plotting function (xr,yr) is the regular plot of the function, 
    xr = linspace(-1,1,n);
    yr = zeros(1,length(xr));%preallocate memory for yr
    %filling in yr values
    for i = 1:length(xr)
        yr(i) = f(xr(i));
    end
    %the plot itself
    figure;
    plot(xr,yr);
    title(sprintf('n = %d', n));
    hold on
    %plotting interpolant (xr, yi) with xr the same as before and yi being the
    %interpolation

    %interpolation

    %vandermonde
    ni = length(xr);%interpolation number
    V = vandermonde(xr,length(xr)-1);%creating vandermonde matrix of xr space
    weights = inv(V)*yr';%weighting for app
    poly = @(x) x.^(0:ni-1)*weights;%polynomial interpolant formula

    %data point filling
    yi = zeros(1,length(xr));%preallocate memory for yi
    %filling in yi values
    for i = 1:length(xr)
        yi(i) = poly(xr(i));
    end

    %the plot itself
    plot(xr,yi);
    ylim([-2 2]);
    legend("Function","Polynomial interpolation");
    hold off
    
end



%3(d)
%due to how I've done this, I think that a different solution would
%work better, I propose using chebyshev nodes, I have written more
%about this


%below is pretty much the same code as for 3(c) but with chebyshev, it
%would probably be better to just put this as it's own function at this
%point but it's fine for now
%nodes
f = @(x) 1/(1+25*x^2);

increm = 1;%increment counter
for nc = [1 5 10 20 32 64 128]
    
    chebX = cos(pi*(2*(1:nc)-1)/(2*nc));
    chebY = zeros(1,length(chebX));

    for i = 1:length(chebX)
        chebY(i) = f(chebX(i));
    end


    V = [];
    ni = length(chebX);
    V = vandermonde(chebX,length(chebX)-1);
    weights = inv(V)*chebY';
    poly = @(x) x.^(0:ni-1)*weights;

    xr = linspace(-1,1,101);
    yr = zeros(1,length(xr));

    for i = 1:length(xr)
        yr(i) = f(xr(i));
    end

    yi = zeros(1,length(xr));

    for i = 1:length(xr)
        yi(i) = poly(xr(i));
    end

    figure;
    plot(xr,yr);
    ylim([-2 2]);
    title(sprintf('n = %d', nc));
    hold on

    plot(xr,yi);
    ylim([-2 2]);
    legend("Function","Chebyshev fit");
    hold off
        
end