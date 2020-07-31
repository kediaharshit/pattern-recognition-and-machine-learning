% Input is a 256x256 resolution image,
% stored on same directory as this program code
a = imread('28.jpg'); 
A = im2double(a);
% using function eig() to get eigen values in "d" 
% and eigenvector matrix in "v".
[v,d] = eig(A);
% initialising new matrix "X" to store the higher magnitude 
% eigenvalues which are chosen
X(1:256, 1:256) = 0;

% N is the number of eigenvalues we choose
N = 120;
% Find maximum based on absolute value and place them on 
% same position in matrix "X".
for i = 1:1:N
    % initialization
    max = -1;
    idx = 0;
        
    for j = 1:1:256
        % Finding maximum and index
        if max < abs(d(j,j))
            max = abs(d(j,j));
            idx = j;
        end
    end
    % Placing the maximum eigenvalue in matrix "X"
    X(idx, idx) = d(idx, idx);
    d(idx, idx) = 0;
end
% Generating image with only the chosen N eigenvalues
C = v*X*(inv(v));
% Printing the output image and error image
imwrite(C, sprintf('evd_rec_%d.jpg',N));
imwrite(A-C, sprintf('evd_err_%d.jpg',N));

% Error calculation using Frobenius norm
err_evd = norm(A-C,'fro')/norm(A,'fro')
