clc; clear;

Train = readmatrix('1d_team_1_train.txt');
Dev = readmatrix('1d_team_1_dev.txt');

%max degree of polynomial
m=11;
Jump =1;

train_error(1:1, 1:m-1) = 0;
dev_error(1:1, 1:m-1) = 0;
itr = 1;
N = 200/Jump;
X1 = Train(1:Jump:200, 1:1);
T = Train(1:Jump:200, 2:2);

Y1 = Dev(1:Jump:200, 1:1);
D = Dev(1:Jump:200, 2:2);

for M = 2:m    
    %highest degree at first  column
    for i = 1:1:M+1
        Phi(1:N, i:i) = X1.^(M+1-i);
    end

    [U,S,V] = svd(Phi);
    d = diag(S);
    d = d.^-1;
    S = diag(d);
    
    if(M+1 > N)
        S(N+1:M+1, :) = 0;
    else
        S(:, M+2:N)= 0;
    end
    W = V*S*U'*T;

    scatter(X1, T, 15);
    hold on;
    
    t = 0:0.05:5;
    plot(t, polyval(W,t),'LineWidth', 2);
    title(sprintf('Plot for M = %d and N = %d', M, N))
    xlabel('X');
    ylabel('Y');
    
    legend({'Data', 'Estimation'}, 'Location', 'southwest');
    box on
    imgname1 = sprintf('plot_1D_%d_%d.jpg',N,M);
    saveas(gca, imgname1);
    hold off;
    
    for i = 1:N
        train_error(M-1) = train_error(M-1)+ (T(i)- polyval(W,X1(i)))^2;
        dev_error(M-1) = dev_error(M-1) + (D(i) - polyval(W,Y1(i)))^2;
    end
end

train_error = ((train_error ./N).^0.5);
dev_error = ((dev_error ./N).^0.5);

[valt, mint] = min(train_error);
[vald, mind] = min(dev_error);
x = 2:m;

figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'all');

plot(x, train_error, '-s', x, dev_error, '-s', 'LineWidth', 2);
title(sprintf('Error Plots for N = %d data points', N));
xlabel('Model Complexity');
ylabel('Root Mean Squared Error');
hold on;
plot(x(mint), valt, 'k*', x(mind), vald, 'k*');
legend({'Training', 'Development', 'Min of Train', 'Min of Dev'}, 'Location', 'northeast');
p(1).MarkerSize = 20;
p(2).MarkerSize = 20;
saveas(figure1,sprintf('error_plot_N_%d.jpg', N));


