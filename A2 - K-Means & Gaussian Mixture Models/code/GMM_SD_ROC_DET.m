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

for i = 1:1250
    tmean1(1) = tmean1(1) + train(1, i);
    tmean1(2) = tmean1(2) + train(2, i);
end
for i = 1251:2500
    tmean2(1) = tmean2(1) + train(1, i);
    tmean2(2) = tmean2(2) + train(2, i);
end
tmean1 = tmean1/1250;
tmean1 = tmean1';
tmean2 = tmean2/1250;
tmean2 = tmean2';

% ROC DET initialization
ROC(1:2, 1:101, 1:2) = 0;
DET(1:2, 1:501, 1:2) = 0;

% Dimension
d = 2;
N = 1250;
K = 6;

% Case 1
% K-Means1 Step
Nk(1:K) = 0;
Means1(1:d, 1:K) = 0;
r1(1:N, 1:K) = 0;
dist(K) = 0;
for i = 1:K
    Means1(:, i) = train(:, randi(N));
end

for itr = 1:10
    for i = 1:N
        for j = 1:K
            r1(i, j) = 0;
        end
    end
    for i = 1:N
        for j = 1:K
            dist(j) = (train(:, i) - Means1(:, j))' * (train(:, i) - Means1(:, j)); 
        end
        [m, id] = min(dist);
        r1(i, id) = 1;
    end
    for i = 1:K
        Means1(:, i) = 0;
        count = 0;
        for j = 1:N
            Means1(:, i) = Means1(:, i) + (r1(j, i) * train(:, j));
            count = count + r1(j, i);
        end
        Nk(i) = count;
        Means1(:, i) = Means1(:, i)/count;
    end
end

% GMM
Sigma1(1:d, 1:d, 1:K) = 0;
Pi1(1:K) = 0;
llhood(1:K) = 0;
for i = 1:K
    count = 0;
    for j = 1:N
        Sigma1(:, :, i) = Sigma1(:, :, i) + r1(j, i) * ((train(:, j) - Means1(:, i)) * (train(:, j) - Means1(:, i))');
        count = count + r1(j, i);
    end
    Sigma1(:, :, i) = Sigma1(:, :, i)/count;
    Pi1(i) = count/N;
end

for itr = 1:10
    for i = 1:N
        llhood = 0;
        for j = 1:K
            llhood = llhood + (Pi1(j) * mvnpdf(train(:,i)', Means1(:,j)', Sigma1(:,:,j)));
        end
        for j = 1:K
            r1(i, j) = (Pi1(j) * mvnpdf(train(:,i)', Means1(:,j)', Sigma1(:,:,j)))/llhood;
        end
    end
    for i = 1:K
        Means1(:, i) = 0;
        count = 0;
        for j = 1:N
            Means1(:, i) = Means1(:, i) + (r1(j, i) * train(:, j));
            count = count + r1(j, i);
        end
        Nk(i) = count;
        Means1(:, i) = Means1(:, i)/count;
    end
    for i = 1:K
        Sigma1(:, :, i) = 0;
        count = 0;
        for j = 1:N
            Sigma1(:, :, i) = Sigma1(:, :, i) + r1(j, i) * (train(:, j) - Means1(:, i)) * (train(:, j) - Means1(:, i))';
            count = count + r1(j, i);
        end
        Sigma1(:, :, i) = Sigma1(:, :, i)/count;
        Pi1(i) = count/N;
    end
end

xrange = [-14 2];
yrange = [-14 2];
inc = 0.1;
[x, y] = meshgrid(xrange(1):inc:xrange(2), yrange(1):inc:yrange(2));
image_size = size(x);
xy = [x(:) y(:)];
xy = [reshape(x, image_size(1)*image_size(2),1) reshape(y, image_size(1)*image_size(2),1)];
idx(1:length(xy)) = 0;
gamma(length(xy), K) = 0;

meanclass(K) = 0;
for i = 1:K
    d1 = (Means1(:, i) - tmean1)' * (Means1(:, i) - tmean1);
    d2 = (Means1(:, i) - tmean2)' * (Means1(:, i) - tmean2);
    if(d1 < d2)
        meanclass(i) = 1;
    else
        meanclass(i) = 2;
    end
end

for i = 1:length(xy)
    llhood = 0;
    for j = 1:K
        llhood = llhood + (Pi1(j) * mvnpdf(xy(i, :), Means1(:,j)', Sigma1(:,:,j)));
    end
    for j = 1:K
        gamma(i, j) = (Pi1(j) * mvnpdf(xy(i, :), Means1(:,j)', Sigma1(:,:,j)))/llhood;
    end
    
    [m, id] = max(gamma(i, :));
    idx(i) = meanclass(id);
end

% ROC
utility(K) = 0;
count = 1;
for i = 0:0.01:1
    TP = 0;
    FP = 0;
    TN = 0;
    FN = 0;
    for k = 1:500
        x = dev(:, k);
        utility(K) = 0;
        llhood = 0;
        for j = 1:K
            llhood = llhood + (Pi1(j) * mvnpdf(x', Means1(:,j)', Sigma1(:,:,j)));
        end
        for j = 1:K
            utility(j) = (Pi1(j) * mvnpdf(x', Means1(:,j)', Sigma1(:,:,j)))/llhood;
        end
        [m, id] = max(utility);
        id = meanclass(id);
        if(id == 1)
            if(m >= i)
                TP = TP + 1;
            else
                FN = FN + 1;
            end
        end
        if(id == 2)
            if(m >= i)
                FP = FP + 1;
            else
                TN = TN + 1;
            end
        end
    end
    for k = 501:1000
        x = dev(:, k);
        utility(K) = 0;
        llhood = 0;
        for j = 1:K
            llhood = llhood + (Pi1(j) * mvnpdf(x', Means1(:,j)', Sigma1(:,:,j)));
        end
        for j = 1:K
            utility(j) = (Pi1(j) * mvnpdf(x', Means1(:,j)', Sigma1(:,:,j)))/llhood;
        end
        [m, id] = max(utility);
        id = meanclass(id);
        if(id == 2)
            if(m >= i)
                TP = TP + 1;
            else
                FN = FN + 1;
            end
        end
        if(id == 1)
            if(m >= i)
                FP = FP + 1;
            else
                TN = TN + 1;
            end
        end
    end
    FPR = FP/(FP + TN);
    TPR = TP/(TP + FN);
    FNR = FN/(FN + TP);
    ROC(1, count, :) = [FPR TPR];
    count = count + 1;
end

% Case 2
% K-Means1 Step
Nk(1:K) = 0;
Means1(1:d, 1:K) = 0;
r1(1:N, 1:K) = 0;
dist(K) = 0;
for i = 1:K
    Means1(:, i) = train(:, randi(N));
end

for itr = 1:10
    for i = 1:N
        for j = 1:K
            r1(i, j) = 0;
        end
    end
    for i = 1:N
        for j = 1:K
            dist(j) = (train(:, i) - Means1(:, j))' * (train(:, i) - Means1(:, j)); 
        end
        [m, id] = min(dist);
        r1(i, id) = 1;
    end
    for i = 1:K
        Means1(:, i) = 0;
        count = 0;
        for j = 1:N
            Means1(:, i) = Means1(:, i) + (r1(j, i) * train(:, j));
            count = count + r1(j, i);
        end
        Nk(i) = count;
        Means1(:, i) = Means1(:, i)/count;
    end
end

% GMM
Sigma1(1:d, 1:d, 1:K) = 0;
diagSigma11(1:d, 1:d, 1:K) = 0;
Pi1(1:K) = 0;
llhood(1:K) = 0;
for i = 1:K
    count = 0;
    for j = 1:N
        Sigma1(:, :, i) = Sigma1(:, :, i) + r1(j, i) * ((train(:, j) - Means1(:, i)) * (train(:, j) - Means1(:, i))');
        count = count + r1(j, i);
    end
    Sigma1(:, :, i) = Sigma1(:, :, i)/count;
    for j = 1:K
        for k = 1:d
            diagSigma11(k, k, j) = Sigma1(k, k, j);
        end
    end
    Pi1(i) = count/N;
end

for itr = 1:10
    for i = 1:N
        llhood = 0;
        for j = 1:K
            llhood = llhood + (Pi1(j) * mvnpdf(train(:,i)', Means1(:,j)', diagSigma11(:,:,j)));
        end
        for j = 1:K
            r1(i, j) = (Pi1(j) * mvnpdf(train(:,i)', Means1(:,j)', diagSigma11(:,:,j)))/llhood;
        end
    end
    for i = 1:K
        Means1(:, i) = 0;
        count = 0;
        for j = 1:N
            Means1(:, i) = Means1(:, i) + (r1(j, i) * train(:, j));
            count = count + r1(j, i);
        end
        Nk(i) = count;
        Means1(:, i) = Means1(:, i)/count;
    end
    for i = 1:K
        Sigma1(:, :, i) = 0;
        count = 0;
        for j = 1:N
            Sigma1(:, :, i) = Sigma1(:, :, i) + r1(j, i) * (train(:, j) - Means1(:, i)) * (train(:, j) - Means1(:, i))';
            count = count + r1(j, i);
        end
        Sigma1(:, :, i) = Sigma1(:, :, i)/count;
        for j = 1:K
            for k = 1:d
                diagSigma11(k, k, j) = Sigma1(k, k, j);
            end
        end
        Pi1(i) = count/N;
    end
end

xrange = [-14 2];
yrange = [-14 2];
inc = 0.1;
[x, y] = meshgrid(xrange(1):inc:xrange(2), yrange(1):inc:yrange(2));
image_size = size(x);
xy = [x(:) y(:)];
xy = [reshape(x, image_size(1)*image_size(2),1) reshape(y, image_size(1)*image_size(2),1)];
idx(1:length(xy)) = 0;
gamma(length(xy), K) = 0;

meanclass(K) = 0;
for i = 1:K
    d1 = (Means1(:, i) - tmean1)' * (Means1(:, i) - tmean1);
    d2 = (Means1(:, i) - tmean2)' * (Means1(:, i) - tmean2);
    if(d1 < d2)
        meanclass(i) = 1;
    else
        meanclass(i) = 2;
    end
end

for i = 1:length(xy)
    llhood = 0;
    for j = 1:K
        llhood = llhood + (Pi1(j) * mvnpdf(xy(i, :), Means1(:,j)', diagSigma11(:,:,j)));
    end
    for j = 1:K
        gamma(i, j) = (Pi1(j) * mvnpdf(xy(i, :), Means1(:,j)', diagSigma11(:,:,j)))/llhood;
    end
    
    [m, id] = max(gamma(i, :));
    idx(i) = meanclass(id);
end

% ROC
utility(K) = 0;
count = 1;
for i = 0:0.01:1
    TP = 0;
    FP = 0;
    TN = 0;
    FN = 0;
    for k = 1:500
        x = dev(:, k);
        utility(K) = 0;
        llhood = 0;
        for j = 1:K
            llhood = llhood + (Pi1(j) * mvnpdf(x', Means1(:,j)', diagSigma11(:,:,j)));
        end
        for j = 1:K
            utility(j) = (Pi1(j) * mvnpdf(x', Means1(:,j)', diagSigma11(:,:,j)))/llhood;
        end
        [m, id] = max(utility);
        id = meanclass(id);
        if(id == 1)
            if(m >= i)
                TP = TP + 1;
            else
                FN = FN + 1;
            end
        end
        if(id == 2)
            if(m >= i)
                FP = FP + 1;
            else
                TN = TN + 1;
            end
        end
    end
    for k = 501:1000
        x = dev(:, k);
        utility(K) = 0;
        llhood = 0;
        for j = 1:K
            llhood = llhood + (Pi1(j) * mvnpdf(x', Means1(:,j)', diagSigma11(:,:,j)));
        end
        for j = 1:K
            utility(j) = (Pi1(j) * mvnpdf(x', Means1(:,j)', diagSigma11(:,:,j)))/llhood;
        end
        [m, id] = max(utility);
        id = meanclass(id);
        if(id == 2)
            if(m >= i)
                TP = TP + 1;
            else
                FN = FN + 1;
            end
        end
        if(id == 1)
            if(m >= i)
                FP = FP + 1;
            else
                TN = TN + 1;
            end
        end
    end
    FPR = FP/(FP + TN);
    TPR = TP/(TP + FN);
    FNR = FN/(FN + TP);
    ROC(2, count, :) = [FPR TPR];
    count = count + 1;
end

figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'all');
plot(ROC(1,:,1), ROC(1,:,2), ROC(2,:,1), ROC(2,:,2), 'LineWidth', 2);
title(sprintf('ROC Curve'));
xlabel('False Positive Rate');
ylabel('True Positive Rate');
legend({'Non diagnol Covariance ', 'Diagnol Covariance'}, 'Location', 'southeast');
saveas(figure1, sprintf('GMM_SD_ROC.jpg'));