clc
clear 

Train = readmatrix('2d_team_1_train.txt');
Dev = readmatrix('2d_team_1_dev.txt');

m = 15;
%train_error(1:m) = 0;
%dev_error(1:m) = 0;
itr = 1;

for Jump = 1
    X1 = Train(1:Jump:1000, 1:1);
    X2 = Train(1:Jump:1000, 2:2);
    T = Train(1:Jump:1000, 3:3);
    Y1 = Dev(1:Jump:1000, 1:1);
    Y2 = Dev(1:Jump:1000, 2:2);
    D = Dev(1:Jump:1000, 3:3);
    F(1:Jump:1000) = 0;
    for M = 4
        count = 1;
        for i = M:-1:0
            for j = 0:i
                Phi(1:1000/Jump, count:count) = X1.^(i-j) .* X2.^j;
                count = count + 1;
            end
        end

        [U, S, V] = svd(Phi);
        d = diag(S);
        d = d.^-1;
        S = diag(d);
        if(count > 1000/Jump)
            S((1000/Jump)+1 : count-1, :) = 0;
        else
            S(:, count : 1000/Jump) = 0;
        end
        W = V * S * U' * T;

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
        title(sprintf('Plot for M = %d and N = %d', M, 1000/Jump))
        xlabel('x1');
        ylabel('x2');
        zlabel('f');
        legend({'Data', 'Estimation'}, 'Location', 'northwest');
        box on
        
        i = 1;
        for j = 1:Jump:1000
            %train_error(itr) = train_error(itr) + ((f(X1(i), X2(i)) - T(i)).^2);
            %dev_error(itr) = dev_error(itr) + ((f(Y1(i), Y2(i)) - D(i)).^2);
            F(i) = f(Y1(i), Y2(i));
            i = i + 1;
        end
        %train_error(itr) = (train_error(itr)^(0.5))/(1000/Jump);
        %dev_error(itr) = (dev_error(itr)^(0.5))/(1000/Jump);
        %itr = itr + 1;

        [az, el] = view;
        az = 60;
        el = 9;
        view (az, el);
        filename = sprintf('Plot_reg_2D_poly_%d_%d.jpg', 1000/Jump, M);
        saveas(gca, filename);
        hold off;
    end
end

%[valt, mint] = min(train_error);
%[vald, mind] = min(dev_error);

x = -20:0.1:20;
coeff = [1, 0];

figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'all');
%plot(x, train_error, '-s', x, dev_error, '-s', 'LineWidth', 2);
plot(x, polyval(coeff, x), 'r');
hold on;
scatter(D, F, 5, 'filled');
title(sprintf('Scatter Plot for M = %d and N = %d', M, 1000/Jump));
xlabel('Target Output');
ylabel('Model Output');
%hold on;
%plot(x(mint), valt, 'k*', x(mind), vald, 'k*');
%legend({'Training', 'Development', 'Min of Train', 'Min of Dev'}, 'Location', 'northeast');
%saveas(figure1,sprintf('error_plot_vs_M_%d.jpg', 1000/Jump));
saveas(figure1,sprintf('scatter_plot.jpg'));