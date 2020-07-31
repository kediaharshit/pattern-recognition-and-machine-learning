clc; clear;

Train = readmatrix('1d_team_1_train.txt');
Dev = readmatrix('1d_team_1_dev.txt');

%max degree of polynomial
m=11;
Jump = 1;

%train_error(1:1, 1:5) = 0;
%dev_error(1:1, 1:5) = 0;
itr = 1;
N = 200/Jump;

X1 = Train(1:Jump:200, 1:1);
T = Train(1:Jump:200, 2:2);

Y1 = Dev(1:Jump:200, 1:1);
D = Dev(1:Jump:200, 2:2);
    

lnLambda = -5;
Lambda = exp(lnLambda);


for M = m   
    %N = 200/Jump;
    %highest degree at first  column
    count = 1;
    %M = 11;
   % X1 = Train(1:Jump:200, 1:1);
    %T = Train(1:Jump:200, 2:2);

    %Y1 = Dev(1:Jump:200, 1:1);
   % D = Dev(1:Jump:200, 2:2);
    
    for i = 1:1:M+1
        Phi(1:N, i:i) = X1.^(M+1-i);
        count = count +1;
    end

    d(1:count-1) = Lambda;
    L = diag(d);
    W = ((Phi' * Phi) + L) \ Phi' * T;
    
    scatter(X1, T, 15);
    hold on;
    
    t = 0:0.05:5;
    plot(t, polyval(W,t),'LineWidth', 2);
    title(sprintf('Plot for M = %d, N = %d and ln(lambda) = %d', M, N, lnLambda))
    xlabel('X');
    ylabel('Y');
    
    legend({'Data', 'Estimation'}, 'Location', 'southwest');
    box on
    imgname1 = sprintf('Plot_1D_%d_%d_%d.jpg',lnLambda,N,M);
    saveas(gca, imgname1);
    hold off;
    
    %for i = 1:200/Jump
     %   train_error(itr) = train_error(itr)+ (T(i)- polyval(W,X1(i)))^2;
      %  dev_error(itr) = dev_error(itr) + (D(i) - polyval(W,Y1(i)))^2;
   % end
    
   % train_error(itr) = (train_error(itr)/N)^0.5;
   % dev_error(itr) =  (dev_error(itr)/N)^0.5;
   % itr = itr+1;
end

%train_error = ((train_error ./N).^0.5);
%dev_error = ((dev_error ./N).^0.5);

%[valt, mint] = min(train_error);
%[vald, mind] = min(dev_error);
for i = 1:200
    val(i) = polyval(W, Y1(i)); 
end

figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'all');

scatter(val,D, 5);
coeff = [1, 0];
x = -2.5:0.1:2.5; 
plot(x, polyval(coeff,x), 'r' );
p(1).MarkerSize = 20;
p(2).MarkerSize = 20;
saveas(figure1,sprintf('scatter_plot_1D.jpg', lnLambda, M));


%plot(x, train_error, '-s', x, dev_error, '-s', 'LineWidth', 2);
%title(sprintf('Error Plots for M = %d and ln(lambda) = %d',M, lnLambda));
%xlabel('Number of data points used');
%xlabel('ln of Regularization Parameter');
%ylabel('Root Mean Squared Error');
%hold on;
%plot(x(mint), valt, 'k*', x(mind), vald, 'k*');
%legend({'Training', 'Development', 'Min of Train', 'Min of Dev'}, 'Location', 'northeast');
%p(1).MarkerSize = 20;
%p(2).MarkerSize = 20;
%saveas(figure1,sprintf('error_plot_vs_N_%d_%d.jpg', lnLambda, M));


