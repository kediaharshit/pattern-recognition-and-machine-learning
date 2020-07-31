clc
clear 

Train = readmatrix('train.txt');
Dev = readmatrix('dev.txt');

train = Train(1:end, 1:2);
train = train';
train_class = Train(1:end, 3:3);

dev = Dev(1:end, 1:2);
dev = dev';
dev_class = Dev(1:end, 3:3);

tmean1(1:2) = 0;
tmean2(1:2) = 0;
tmean3(1:2) = 0;

for i = 1:350
    tmean1(1) = tmean1(1) + train(1, i);
    tmean1(2) = tmean1(2) + train(2, i);
end
for i = 351:700
    tmean2(1) = tmean2(1) + train(1, i);
    tmean2(2) = tmean2(2) + train(2, i);
end
for i = 701:1050
    tmean3(1) = tmean3(1) + train(1, i);
    tmean3(2) = tmean3(2) + train(2, i);
end
tmean1 = tmean1/350;
tmean1 = tmean1';
tmean2 = tmean2/350;
tmean2 = tmean2';
tmean3 = tmean3/350;
tmean3 = tmean3';

tC1(1:2, 1:2) = 0;
tC2(1:2, 1:2) = 0;
tC3(1:2, 1:2) = 0;
tVar = 0;

for i = 1:350
    tC1 = tC1 + (train(1:2, i:i) - tmean1)*(train(1:2, i:i) - tmean1)';
    tVar = tVar + (train(1:2, i:i) - tmean1)'*(train(1:2, i:i) - tmean1);
end
for i = 351:700
    tC2 = tC2 + (train(1:2, i:i) - tmean2)*(train(1:2, i:i) - tmean2)';
    tVar = tVar + (train(1:2, i:i) - tmean2)'*(train(1:2, i:i) - tmean2);
end
for i = 701:1050
    tC3 = tC3 + (train(1:2, i:i) - tmean3)*(train(1:2, i:i) - tmean3)';
    tVar = tVar + (train(1:2, i:i) - tmean3)'*(train(1:2, i:i) - tmean3);
end
tC = tC1 + tC2 + tC3;
tC = tC/1050;
tC1 = tC1/350;
tC2 = tC2/350;
tC3 = tC3/350;
tNC = tC;
tNC(1,2) = 0;
tNC(2,1) = 0;
tNC1 = tC1;
tNC1(1,2) = 0;
tNC1(2,1) = 0;
tNC2 = tC2;
tNC2(1,2) = 0;
tNC2(2,1) = 0;
tNC3 = tC3;
tNC3(1,2) = 0;
tNC3(2,1) = 0;
tVar = tVar/2100;

% ROC DET initialization
ROC(1:5, 1:501, 1:2) = 0;
DET(1:5, 1:501, 1:2) = 0;

% Case 1
count = 1;
for p = -50:0.1:0
    i = exp(p); 
    TP = 0;
    FP = 0;
    TN = 0;
    FN = 0;
    for j = 1:100
        x = dev(:, j);
        p1 = mvnpdf(x', tmean1', tC);
        p2 = mvnpdf(x', tmean2', tC);
        p3 = mvnpdf(x', tmean3', tC);
        if(p1 >= i)
            TP = TP + 1;
        else
            FN = FN + 1;
        end
        if(p2 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        if(p3 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
    end
    for j = 101:200
        x = dev(:, j);
        p1 = mvnpdf(x', tmean1', tC);
        p2 = mvnpdf(x', tmean2', tC);
        p3 = mvnpdf(x', tmean3', tC);
        if(p2 >= i)
            TP = TP + 1;
        else
            FN = FN + 1;
        end
        if(p1 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        if(p3 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
    end
    for j = 201:300
        x = dev(:, j);
        p1 = mvnpdf(x', tmean1', tC);
        p2 = mvnpdf(x', tmean2', tC);
        p3 = mvnpdf(x', tmean3', tC);
        if(p3 >= i)
            TP = TP + 1;
        else
            FN = FN + 1;
        end
        if(p2 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        if(p1 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
    end
    FPR = FP/(FP + TN);
    TPR = TP/(TP + FN);
    FNR = FN/(FN + TP);
    ROC(1, count, :) = [FPR TPR];
    DET(1, count, :) = [FPR FNR];
    count = count + 1;
end

% Case 2
count = 1;
for p = -50:0.1:0
    i = exp(p); 
    TP = 0;
    FP = 0;
    TN = 0;
    FN = 0;
    for j = 1:100
        x = dev(:, j);
        p1 = mvnpdf(x', tmean1', tC1);
        p2 = mvnpdf(x', tmean2', tC2);
        p3 = mvnpdf(x', tmean3', tC3);
        if(p1 >= i)
            TP = TP + 1;
        else
            FN = FN + 1;
        end
        if(p2 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        if(p3 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
    end
    for j = 101:200
        x = dev(:, j);
        p1 = mvnpdf(x', tmean1', tC1);
        p2 = mvnpdf(x', tmean2', tC2);
        p3 = mvnpdf(x', tmean3', tC3);
        if(p2 >= i)
            TP = TP + 1;
        else
            FN = FN + 1;
        end
        if(p1 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        if(p3 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
    end
    for j = 201:300
        x = dev(:, j);
        p1 = mvnpdf(x', tmean1', tC1);
        p2 = mvnpdf(x', tmean2', tC2);
        p3 = mvnpdf(x', tmean3', tC3);
        if(p3 >= i)
            TP = TP + 1;
        else
            FN = FN + 1;
        end
        if(p2 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        if(p1 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
    end
    FPR = FP/(FP + TN);
    TPR = TP/(TP + FN);
    FNR = FN/(FN + TP);
    ROC(2, count, :) = [FPR TPR];
    DET(2, count, :) = [FPR FNR];
    count = count + 1;
end

% Case 3
count = 1;
for p = -50:0.1:0
    i = exp(p); 
    TP = 0;
    FP = 0;
    TN = 0;
    FN = 0;
    for j = 1:100
        x = dev(:, j);
        p1 = mvnpdf(x', tmean1', tVar*[1 0; 0 1]);
        p2 = mvnpdf(x', tmean2', tVar*[1 0; 0 1]);
        p3 = mvnpdf(x', tmean3', tVar*[1 0; 0 1]);
        if(p1 >= i)
            TP = TP + 1;
        else
            FN = FN + 1;
        end
        if(p2 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        if(p3 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
    end
    for j = 101:200
        x = dev(:, j);
        p1 = mvnpdf(x', tmean1', tVar*[1 0; 0 1]);
        p2 = mvnpdf(x', tmean2', tVar*[1 0; 0 1]);
        p3 = mvnpdf(x', tmean3', tVar*[1 0; 0 1]);
        if(p2 >= i)
            TP = TP + 1;
        else
            FN = FN + 1;
        end
        if(p1 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        if(p3 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
    end
    for j = 201:300
        x = dev(:, j);
        p1 = mvnpdf(x', tmean1', tVar*[1 0; 0 1]);
        p2 = mvnpdf(x', tmean2', tVar*[1 0; 0 1]);
        p3 = mvnpdf(x', tmean3', tVar*[1 0; 0 1]);
        if(p3 >= i)
            TP = TP + 1;
        else
            FN = FN + 1;
        end
        if(p2 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        if(p1 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
    end
    FPR = FP/(FP + TN);
    TPR = TP/(TP + FN);
    FNR = FN/(FN + TP);
    ROC(3, count, :) = [FPR TPR];
    DET(3, count, :) = [FPR FNR];
    count = count + 1;
end

% Case 4
count = 1;
for p = -50:0.1:0
    i = exp(p); 
    TP = 0;
    FP = 0;
    TN = 0;
    FN = 0;
    for j = 1:100
        x = dev(:, j);
        p1 = mvnpdf(x', tmean1', tNC);
        p2 = mvnpdf(x', tmean2', tNC);
        p3 = mvnpdf(x', tmean3', tNC);
        if(p1 >= i)
            TP = TP + 1;
        else
            FN = FN + 1;
        end
        if(p2 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        if(p3 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
    end
    for j = 101:200
        x = dev(:, j);
        p1 = mvnpdf(x', tmean1', tNC);
        p2 = mvnpdf(x', tmean2', tNC);
        p3 = mvnpdf(x', tmean3', tNC);
        if(p2 >= i)
            TP = TP + 1;
        else
            FN = FN + 1;
        end
        if(p1 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        if(p3 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
    end
    for j = 201:300
        x = dev(:, j);
        p1 = mvnpdf(x', tmean1', tNC);
        p2 = mvnpdf(x', tmean2', tNC);
        p3 = mvnpdf(x', tmean3', tNC);
        if(p3 >= i)
            TP = TP + 1;
        else
            FN = FN + 1;
        end
        if(p2 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        if(p1 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
    end
    FPR = FP/(FP + TN);
    TPR = TP/(TP + FN);
    FNR = FN/(FN + TP);
    ROC(4, count, :) = [FPR TPR];
    DET(4, count, :) = [FPR FNR];
    count = count + 1;
end

% Case 5
count = 1;
for p = -50:0.1:0
    i = exp(p); 
    TP = 0;
    FP = 0;
    TN = 0;
    FN = 0;
    for j = 1:100
        x = dev(:, j);
        p1 = mvnpdf(x', tmean1', tNC1);
        p2 = mvnpdf(x', tmean2', tNC2);
        p3 = mvnpdf(x', tmean3', tNC3);
        if(p1 >= i)
            TP = TP + 1;
        else
            FN = FN + 1;
        end
        if(p2 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        if(p3 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
    end
    for j = 101:200
        x = dev(:, j);
        p1 = mvnpdf(x', tmean1', tNC1);
        p2 = mvnpdf(x', tmean2', tNC2);
        p3 = mvnpdf(x', tmean3', tNC3);
        if(p2 >= i)
            TP = TP + 1;
        else
            FN = FN + 1;
        end
        if(p1 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        if(p3 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
    end
    for j = 201:300
        x = dev(:, j);
        p1 = mvnpdf(x', tmean1', tNC1);
        p2 = mvnpdf(x', tmean2', tNC2);
        p3 = mvnpdf(x', tmean3', tNC3);
        if(p3 >= i)
            TP = TP + 1;
        else
            FN = FN + 1;
        end
        if(p2 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        if(p1 >= i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
    end
    FPR = FP/(FP + TN);
    TPR = TP/(TP + FN);
    FNR = FN/(FN + TP);
    ROC(5, count, :) = [FPR TPR];
    DET(5, count, :) = [FPR FNR];
    count = count + 1;
end

% ROC DET Plots for all five classes
figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'all');
plot(ROC(1,:,1), ROC(1,:,2), ROC(2,:,1), ROC(2,:,2), ROC(3,:,1), ROC(3,:,2), ROC(4,:,1), ROC(4,:,2), ROC(5,:,1), ROC(5,:,2), 'LineWidth', 2);
title(sprintf('ROC Curve'));
xlabel('False Positive Rate');
ylabel('True Positive Rate');
legend({'Case 1', 'Case 2', 'Case 3', 'Case 4', 'Case 5'}, 'Location', 'southeast');
saveas(figure1, sprintf('RD_ROC.jpg'));

figure2 = figure;
axes1 = axes('Parent',figure2);
hold(axes1,'all');
plot(DET(1,:,1), DET(1,:,2), DET(2,:,1), DET(2,:,2), DET(3,:,1), DET(3,:,2), DET(4,:,1), DET(4,:,2), DET(5,:,1), DET(5,:,2), 'LineWidth', 2);
title(sprintf('DET Curve'));
xlabel('False Alarm Rate');
ylabel('Missed Detection Rate');
legend({'Case 1', 'Case 2', 'Case 3', 'Case 4', 'Case 5'}, 'Location', 'northeast');
saveas(figure2, sprintf('RD_DET.jpg'));