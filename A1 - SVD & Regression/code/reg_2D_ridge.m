clc
clear 

Train = readmatrix('2d_team_1_train.txt');
Dev = readmatrix('2d_team_1_dev.txt');

m = 10;
train_error(1:m) = 0;
dev_error(1:m) = 0;
itr = 1;

lnLambda = -15;
Lambda = exp(lnLambda);

for Jump = 5
    X1 = Train(1:Jump:1000, 1:1);
    X2 = Train(1:Jump:1000, 2:2);
    T = Train(1:Jump:1000, 3:3);
    Y1 = Dev(1:Jump:1000, 1:1);
    Y2 = Dev(1:Jump:1000, 2:2);
    D = Dev(1:Jump:1000, 3:3);
    for M = 3:12
        count = 1;
        for i = M:-1:0
            for j = 0:i
                Phi(1:1000/Jump, count:count) = X1.^(i-j) .* X2.^j;
                count = count + 1;
            end
        end

        d(1:count-1) = Lambda;
        L = diag(d);
        W = ((Phi' * Phi) + L) \ Phi' * T;

        scatter3(X1, X2, T, 'filled', 'r');
        hold on;

        syms f(x1, x2)
        f(x1, x2) = 0;
        count = 1;
        for i = M:-1:0
            for j = 0:i
                f(x1, x2) = f(x1, x2) + (W(count) * (x1.^(i-j) * x2.^j));
                count = count + 1;
            end
        end
        fsurf(f,[-1,1]);
        title(sprintf('Plot for M = %d, N = %d and ln(lambda) = %d', M, 1000/Jump, lnLambda))
        xlabel('x1');
        ylabel('x2');
        zlabel('f');
        legend({'Data', 'Estimation'}, 'Location', 'northwest');
        box on
        
        i = 1;
        for j = 1:Jump:1000
            train_error(itr) = train_error(itr) + ((f(X1(i), X2(i)) - T(i)).^2);
            dev_error(itr) = dev_error(itr) + ((f(Y1(i), Y2(i)) - D(i)).^2);
            i = i + 1;
        end
        train_error(itr) = (train_error(itr)^(0.5))/(1000/Jump);
        dev_error(itr) = (dev_error(itr)^(0.5))/(1000/Jump);
        itr = itr + 1;

        [az, el] = view;
        az = 60;
        el = 9;
        view (az, el);
        filename = sprintf('Plot_reg_2D_ridge_%d_%d_%d.jpg', 1000/Jump, M, lnLambda);
        saveas(gca, filename);
        hold off;
    end
end

[valt, mint] = min(train_error);
[vald, mind] = min(dev_error);

x = 3:12;

figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'all');
plot(x, train_error, '-s', x, dev_error, '-s', 'LineWidth', 2);
title(sprintf('Error Plots for N = %d and ln(lambda) = %d', 1000/Jump, lnLambda));
xlabel('Model Complexity');
ylabel('Root Mean Squared Error');
hold on;
plot(x(mint), valt, 'k*', x(mind), vald, 'k*');
legend({'Training', 'Development', 'Min of Train', 'Min of Dev'}, 'Location', 'northeast');
saveas(figure1,sprintf('error_plot_vs_M_%d_%d.jpg', (1000/Jump), lnLambda));