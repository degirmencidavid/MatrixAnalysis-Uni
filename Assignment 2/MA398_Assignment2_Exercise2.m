%note that my part (g) is in this file and is quite intensive
%looping through 3 images, re is an increment counter
re = 0;
for X = ["BlackCat.jpg" "LinesTilted.jpg" "LinesVertical.jpg"]
    
    re = re+1;%increment for re
    
    %reading image as matrix, 
    A = double(rgb2gray(imread(X)));

    %getting resolution
    [m,n] = size(A);
    
    %set p
    p = min([m,n]);

    %calculate svd
    [U,S,V] = svd(A);

    %plotting rank k approx for k = 0,p and 2 evenly spaced values between
    %ch and if statement to disable this for testing purposes
    ch = 1;
    if ch == 1
        
        %plotting original image
        figure, subplot(2,3,1);
        image(A), axis off;
        colormap("gray");
        title("Original Image " + X);
        
        
        i = 2;%indexing for subplot
        %plotting, alpha and beta are ranks determined by each image which
        %I have decided and specified by using a switch case
        switch re
            case 1
                alpha = 10;
                beta = 40;
            case 2
                alpha = 10;
                beta = 40;
            case 3
                alpha = floor(p/3);
                beta = floor(2*p/3);
        end
        
        for k = [0 1 alpha beta p]
            subplot(2,3,i);
            appA = U(:,1:k) * S(1:k,1:k) * V(:,1:k)';
            image(appA), axis off;
            colormap("gray");
            %[x,y] = size(appA);
            title(sprintf('Rank %d approximation', k));
            i = i+1;
        end
    end

    
    %below is for testing
    %for testing so if statement and chz are to activate or disable
    chz = 0;
    if chz == 1
        %plotting separate for important features being discernable

        %switch case to choose which image to resolve for easier testing
        img = 1;
        switch img
            case 1
                arr = [20 40];
            case 2
                arr = [20 40];
            case 3
                arr = [20 40];
        end

            i = 1;%indexing for subplot
        for k = arr
            figure;
            appA = U(:,1:k) * S(1:k,1:k) * V(:,1:k)';
            image(appA), axis off;
            colormap("gray");
            %[x,y] = size(appA);
            title(sprintf('Rank %d approximation ' + X, k));
            i = i+1;
        end
    end
    
end


%2(g)
%doing svd stuffs, this is intensive
A = double(rgb2gray(imread("BlackCat.jpg")));
[m,n] = size(A);
p = min([m,n]);
[U,S,V] = svd(A);
kVals = [1:4 5:5:120, 130:10:300, 320:50:1670, 1791];
detail = [];
for i = 1:length(kVals)
    k = kVals(i);
    appA = U(:,1:k) * S(1:k,1:k) * V(:,1:k)';
    det = (norm(A) - norm(A-appA))*100/norm(A);
    detail = [detail, det];
end
figure;
plot(kVals, detail);
title("Detail vs value of k");
xlabel("k");
ylabel("Detail of original image (percent)");
