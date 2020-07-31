%first two commands are for clearing the command window and the workspace
clc
clear

%reading the image and converting all values to double for EVD functions
swan = imread('29.jpg');
Swan = double(swan);

%getting Eigenvalue Decomposition of the matrix 
[V,D] = eig(Swan);

%getting the Singular Value decomposition using EVD
[u, s] = eig(Swan * Swan');
s = sqrt(s);
v = Swan\u*s;

%converting diagnol matrices to vectors and sorting them 
evec = diag(D);
svec = diag(s);
evec = reshape(evec, [1,256]);
svec = reshape(svec, [1,256]);

%to get the sorted indices of the vectors
[eout, eindices] = sort(evec, 'descend');
[sout, sindices] = sort(svec, 'descend');

%initializing the plotting arrays and counter for the error plot
evd_error = zeros(1, 256);
svd_error = zeros(1, 256);
x = 1:256;
count = 1;

%loop to recreate images with EVD and SVD using top (i) values
for i = 1:256
    for j = 1:256
        if eindices(j) <= i
            evec(j) = D(j,j);
        else 
            evec(j) = 0;
        end
        if sindices(j) <= i
            svec(j) = s(j,j);
        else 
            svec(j) = 0;
        end
    end
    
    %creating diagnol matrices out of the recreated vectors
    d = diag(evec);
    S = diag(svec);
    
    %Recreated image matrices
    evd_Swan = V*d/V;
    svd_Swan = u*S*v';
    
    %calculating and storing the error in the image matrices
    evd_err = norm(Swan - evd_Swan, 'fro')/norm(Swan, 'fro');
    svd_err = norm(Swan - svd_Swan, 'fro')/norm(Swan, 'fro');
    evd_error(count) = evd_err;
    svd_error(count) = svd_err;
    count = count + 1;
    
    %converting the obtained matrices to integer values for image plotting
    evd_swan = uint8(evd_Swan);
    svd_swan = uint8(svd_Swan);
    
    %saving the images and the error images with appropriate names  
    imwrite(evd_swan, sprintf('evd_%d_29.jpg', i));
    imwrite(uint8(Swan - evd_Swan), sprintf('evd_%d_29_error.jpg', i));
    imwrite(svd_swan, sprintf('svd_%d_29.jpg', i));
    imwrite(uint8(Swan - svd_Swan), sprintf('svd_%d_29_error.jpg', i));
end

%code for plotting the error against the number of values used and saving
figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'all');
plot(x, evd_error, x, svd_error, 'LineWidth', 2);
title('Frobenious Norm Error');
xlabel('Number of eigen/singular values used');
ylabel('Error in the reconstructed image');
legend({'EVD', 'SVD'}, 'Location', 'northeast');
saveas(figure1,'error_plot.jpg');