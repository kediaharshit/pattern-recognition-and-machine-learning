clc; clear;
% Read Input
a = imread('28.jpg');
A = im2double(a);
%Initialise the error array

[v,d] = eig(A);
% Select maxima's one by one and add it to the matrix X and 
% calculate new image on each iteration
X(1:256, 1:256) = 0;
err_evd(1:256) = 0;

for k = 1:1:256
    max = -1;
    idx = 0;
    for j = 1:1:256
        if max < abs(d(j,j))
            max = abs(d(j,j));
            idx = j;
        end
    end
    X(idx, idx) = d(idx, idx);
    d(idx, idx) = 0;
    C = v*X*(inv(v));
    
    err_evd(k) = norm(A-C,'fro')/norm(A,'fro');
end
% Plot the error vs N graph for EVD
x = [1:256];
y = err_evd(x);
plot(x, y, 'LineWidth', 2), xlabel('N ->'), ylabel('Error\_EVD ->');


