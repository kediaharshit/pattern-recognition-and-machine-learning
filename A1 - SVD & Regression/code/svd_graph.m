clc; clear;
% Read input
inp = imread('28.jpg');
a = im2double(inp);
% Using fact that eigenvalues of A*(A') are squares of 
% singular values of matrix A 
A1 = a*(a');
A2 = (a')*a;
[U, D1] = eig(A1);
[V, D2] = eig(A2);

X1 = sqrt(D1);
X2 = sqrt(D2);
S =  (X1 + X2)/2;
err_svd(1:256) = 0;

% Compute this difference matrix to eliminate the negative multiplied
% eigenvectors(columns) hazard in U or V (either works)
dif = a*V - U*S; 
for i = 1:256
    if(dif(i,i) > 0.0001) || (dif(i,i) < -0.0001)
        U(:, i) = -U(:, i);
    end
end
% Choose K singular values and generate the new image
for k = 1:256
    S2 = S;
    N = 256-k;
    S2(1:N, 1:N) = 0;
    outp = U*S2*(V');
    % Calculate error and save in array
    err_svd(k) = norm(outp-a, 'fro')/norm(a, 'fro');
end
% Plot the error vs K grapah for SVD
x = [1:256];
y = err_svd(x);
plot(x, y, 'LineWidth', 2), xlabel('N ->'), ylabel('Error\_SVD ->');