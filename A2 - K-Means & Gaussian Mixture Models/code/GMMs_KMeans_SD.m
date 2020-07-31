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

% Dimension
iterationsk = 10;
iterationsg = 10;
d = 2;
N = 1250;
K = 6;
Nk1(1:K) = 0;
Nk2(1:K) = 0;

% Case 1 Class 1
% K-Means Step
Means1(1:d, 1:K) = 0;
r(1:2*N, 1:K) = 0;
dist(K) = 0;
for i = 1:K
    Means1(:, i) = train(:, randi(N));
end

for itr = 1:iterationsk
    for i = 1:N
        for j = 1:K
            r(i, j) = 0;
        end
    end
    for i = 1:N
        for j = 1:K
            dist(j) = (train(:, i) - Means1(:, j))' * (train(:, i) - Means1(:, j)); 
        end
        [m, id] = min(dist);
        r(i, id) = 1;
    end
    for i = 1:K
        Means1(:, i) = 0;
        count = 0;
        for j = 1:N
            Means1(:, i) = Means1(:, i) + (r(j, i) * train(:, j));
            count = count + r(j, i);
        end
        Nk1(i) = count;
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
        Sigma1(:, :, i) = Sigma1(:, :, i) + r(j, i) * ((train(:, j) - Means1(:, i)) * (train(:, j) - Means1(:, i))');
        count = count + r(j, i);
    end
    Sigma1(:, :, i) = Sigma1(:, :, i)/count;
    Pi1(i) = count/N;
end

for itr = 1:iterationsg
    for i = 1:N
        llhood = 0;
        for j = 1:K
            llhood = llhood + (Pi1(j) * mvnpdf(train(:,i)', Means1(:,j)', Sigma1(:,:,j)));
        end
        for j = 1:K
            r(i, j) = (Pi1(j) * mvnpdf(train(:,i)', Means1(:,j)', Sigma1(:,:,j)))/llhood;
        end
    end
    for i = 1:K
        Means1(:, i) = 0;
        count = 0;
        for j = 1:N
            Means1(:, i) = Means1(:, i) + (r(j, i) * train(:, j));
            count = count + r(j, i);
        end
        Nk1(i) = count;
        Means1(:, i) = Means1(:, i)/count;
    end
    for i = 1:K
        Sigma1(:, :, i) = 0;
        count = 0;
        for j = 1:N
            Sigma1(:, :, i) = Sigma1(:, :, i) + r(j, i) * (train(:, j) - Means1(:, i)) * (train(:, j) - Means1(:, i))';
            count = count + r(j, i);
        end
        Sigma1(:, :, i) = Sigma1(:, :, i)/count;
        Pi1(i) = count/N;
    end
end

% Case 1 Class 2
% K-Means Step
Means2(1:d, 1:K) = 0;
r(1:N, 1:K) = 0;
dist(K) = 0;
for i = 1:K
    Means2(:, i) = train(:, 2*randi(N));
end

for itr = 1:iterationsk
    for i = N:2*N
        for j = 1:K
            r(i, j) = 0;
        end
    end
    for i = N:2*N
        for j = 1:K
            dist(j) = (train(:, i) - Means2(:, j))' * (train(:, i) - Means2(:, j)); 
        end
        [m, id] = min(dist);
        r(i, id) = 1;
    end
    for i = 1:K
        Means2(:, i) = 0;
        count = 0;
        for j = N:2*N
            Means2(:, i) = Means2(:, i) + (r(j, i) * train(:, j));
            count = count + r(j, i);
        end
        Nk2(i) = count;
        Means2(:, i) = Means2(:, i)/count;
    end
end

% GMM
Sigma2(1:d, 1:d, 1:K) = 0;
Pi2(1:K) = 0;
llhood(1:K) = 0;
for i = 1:K
    count = 0;
    for j = N:2*N
        Sigma2(:, :, i) = Sigma2(:, :, i) + r(j, i) * ((train(:, j) - Means2(:, i)) * (train(:, j) - Means2(:, i))');
        count = count + r(j, i);
    end
    Sigma2(:, :, i) = Sigma2(:, :, i)/count;
    Pi2(i) = count/N;
end

for itr = 1:iterationsg
    for i = N:2*N
        llhood = 0;
        for j = 1:K
            llhood = llhood + (Pi2(j) * mvnpdf(train(:,i)', Means2(:,j)', Sigma2(:,:,j)));
        end
        for j = 1:K
            r(i, j) = (Pi2(j) * mvnpdf(train(:,i)', Means2(:,j)', Sigma2(:,:,j)))/llhood;
        end
    end
    for i = 1:K
        Means2(:, i) = 0;
        count = 0;
        for j = N:2*N
            Means2(:, i) = Means2(:, i) + (r(j, i) * train(:, j));
            count = count + r(j, i);
        end
        Nk2(i) = count;
        Means2(:, i) = Means2(:, i)/count;
    end
    for i = 1:K
        Sigma2(:, :, i) = 0;
        count = 0;
        for j = N:2*N
            Sigma2(:, :, i) = Sigma2(:, :, i) + r(j, i) * (train(:, j) - Means2(:, i)) * (train(:, j) - Means2(:, i))';
            count = count + r(j, i);
        end
        Sigma2(:, :, i) = Sigma2(:, :, i)/count;
        Pi2(i) = count/N;
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
gamma1(length(xy), K) = 0;
gamma2(length(xy), K) = 0;

for i = 1:length(xy)
    llhood = 0;
    for j = 1:K
        llhood = llhood + (Pi1(j) * mvnpdf(xy(i, :), Means1(:,j)', Sigma1(:,:,j)));
    end
    for j = 1:K
        gamma1(i, j) = (Pi1(j) * mvnpdf(xy(i, :), Means1(:,j)', Sigma1(:,:,j)))/llhood;
    end
    m1 = llhood;
    %for j = 1:K
    %    m1 = m1 + Pi1(j)*gamma1(i, j);
    %end
    
    llhood = 0;
    for j = 1:K
        llhood = llhood + (Pi1(j) * mvnpdf(xy(i, :), Means2(:,j)', Sigma2(:,:,j)));
    end
    for j = 1:K
        gamma2(i, j) = (Pi1(j) * mvnpdf(xy(i, :), Means2(:,j)', Sigma2(:,:,j)))/llhood;
    end
    m2 = llhood;
    %for j = 1:K
    %    m2 = m2 + Pi2(j)*gamma2(i, j);
    %end
    
    if(m1 > m2)
        idx(i) = 1;
    else
        idx(i) = 2;
    end
end

decisionmap = reshape(idx, image_size);
%figure;
figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'all');
imagesc(xrange,yrange,decisionmap);
hold on;
set(gca,'ydir','normal');
%cmap = [1 1 0.5; 0 1 0];
cmap = [1 0.4 0.4; 0 0.7 0];

colormap(cmap);

h(1) = scatter(train(1:1, 1:N), train(2:2, 1:N), 5, 'filled', 'g'); hold on;
h(2) = scatter(train(1:1, (N + 1):2*N), train(2:2, (N + 1):2*N), 5, 'filled', 'b'); hold on;
h(3) = scatter(Means1(1:1, 1:K), Means1(2:2, 1:K), 40, 'filled', 'sr'); hold on;
h(4) = scatter(Means2(1:1, 1:K), Means2(2:2, 1:K), 40, 'filled', 'sk'); hold on;
for i = 1:K
    G = gmdistribution(Means1(:,i)', Sigma1(:,:,i));
    f = @(x, y) pdf(G, [x y]);
    h(4 + 2*i - 1) = fcontour(f, [-14 2 -14 2], 'y');
    hold on;
    G = gmdistribution(Means2(:,i)', Sigma2(:,:,i));
    f = @(x, y) pdf(G, [x y]);
    h(4 + 2*i) = fcontour(f, [-14 2 -14 2], 'c');
    hold on;
end
hold off;
title(sprintf('Case 1: Decision Surfaces for K = %d', K))
xlabel('x1');
ylabel('x2');
legend(h(1:2), {'class 1', 'class 2'}, 'Location', 'southeast');
hold off;
saveas(figure1,sprintf('GMM_Synthetic_case_1_%d.jpg', K));

% Case 2 Class 1
% K-Means Step
Means1(1:d, 1:K) = 0;
r(1:2*N, 1:K) = 0;
dist(K) = 0;
for i = 1:K
    Means1(:, i) = train(:, randi(N));
end

for itr = 1:iterationsk
    for i = 1:N
        for j = 1:K
            r(i, j) = 0;
        end
    end
    for i = 1:N
        for j = 1:K
            dist(j) = (train(:, i) - Means1(:, j))' * (train(:, i) - Means1(:, j)); 
        end
        [m, id] = min(dist);
        r(i, id) = 1;
    end
    for i = 1:K
        Means1(:, i) = 0;
        count = 0;
        for j = 1:N
            Means1(:, i) = Means1(:, i) + (r(j, i) * train(:, j));
            count = count + r(j, i);
        end
        Nk1(i) = count;
        Means1(:, i) = Means1(:, i)/count;
    end
end

% GMM
Sigma1(1:d, 1:d, 1:K) = 0;
diagSigma1(1:d, 1:d, 1:K) = 0;
Pi1(1:K) = 0;
llhood(1:K) = 0;
for i = 1:K
    count = 0;
    for j = 1:N
        Sigma1(:, :, i) = Sigma1(:, :, i) + r(j, i) * ((train(:, j) - Means1(:, i)) * (train(:, j) - Means1(:, i))');
        count = count + r(j, i);
    end
    Sigma1(:, :, i) = Sigma1(:, :, i)/count;
    for j = 1:K
        for k = 1:d
            diagSigma1(k, k, j) = Sigma1(k, k, j);
        end
    end
    Pi1(i) = count/N;
end

for itr = 1:iterationsg
    for i = 1:N
        llhood = 0;
        for j = 1:K
            llhood = llhood + (Pi1(j) * mvnpdf(train(:,i)', Means1(:,j)', diagSigma1(:,:,j)));
        end
        for j = 1:K
            r(i, j) = (Pi1(j) * mvnpdf(train(:,i)', Means1(:,j)', diagSigma1(:,:,j)))/llhood;
        end
    end
    for i = 1:K
        Means1(:, i) = 0;
        count = 0;
        for j = 1:N
            Means1(:, i) = Means1(:, i) + (r(j, i) * train(:, j));
            count = count + r(j, i);
        end
        Nk1(i) = count;
        Means1(:, i) = Means1(:, i)/count;
    end
    for i = 1:K
        Sigma1(:, :, i) = 0;
        count = 0;
        for j = 1:N
            Sigma1(:, :, i) = Sigma1(:, :, i) + r(j, i) * (train(:, j) - Means1(:, i)) * (train(:, j) - Means1(:, i))';
            count = count + r(j, i);
        end
        Sigma1(:, :, i) = Sigma1(:, :, i)/count;
        for j = 1:K
            for k = 1:d
                diagSigma1(k, k, j) = Sigma1(k, k, j);
            end
        end
        Pi1(i) = count/N;
    end
end

% Case 2 Class 2
% K-Means Step
Means2(1:d, 1:K) = 0;
r(1:N, 1:K) = 0;
dist(K) = 0;
for i = 1:K
    Means2(:, i) = train(:, 2*randi(N));
end

for itr = 1:iterationsk
    for i = N:2*N
        for j = 1:K
            r(i, j) = 0;
        end
    end
    for i = N:2*N
        for j = 1:K
            dist(j) = (train(:, i) - Means2(:, j))' * (train(:, i) - Means2(:, j)); 
        end
        [m, id] = min(dist);
        r(i, id) = 1;
    end
    for i = 1:K
        Means2(:, i) = 0;
        count = 0;
        for j = N:2*N
            Means2(:, i) = Means2(:, i) + (r(j, i) * train(:, j));
            count = count + r(j, i);
        end
        Nk2(i) = count;
        Means2(:, i) = Means2(:, i)/count;
    end
end

% GMM
Sigma2(1:d, 1:d, 1:K) = 0;
diagSigma2(1:d, 1:d, 1:K) = 0;
Pi2(1:K) = 0;
llhood(1:K) = 0;
for i = 1:K
    count = 0;
    for j = N:2*N
        Sigma2(:, :, i) = Sigma2(:, :, i) + r(j, i) * ((train(:, j) - Means2(:, i)) * (train(:, j) - Means2(:, i))');
        count = count + r(j, i);
    end
    Sigma2(:, :, i) = Sigma2(:, :, i)/count;
    for j = 1:K
        for k = 1:d
            diagSigma2(k, k, j) = Sigma2(k, k, j);
        end
    end
    Pi2(i) = count/N;
end

for itr = 1:iterationsg
    for i = N:2*N
        llhood = 0;
        for j = 1:K
            llhood = llhood + (Pi2(j) * mvnpdf(train(:,i)', Means2(:,j)', diagSigma2(:,:,j)));
        end
        for j = 1:K
            r(i, j) = (Pi2(j) * mvnpdf(train(:,i)', Means2(:,j)', diagSigma2(:,:,j)))/llhood;
        end
    end
    for i = 1:K
        Means2(:, i) = 0;
        count = 0;
        for j = N:2*N
            Means2(:, i) = Means2(:, i) + (r(j, i) * train(:, j));
            count = count + r(j, i);
        end
        Nk2(i) = count;
        Means2(:, i) = Means2(:, i)/count;
    end
    for i = 1:K
        Sigma2(:, :, i) = 0;
        count = 0;
        for j = N:2*N
            Sigma2(:, :, i) = Sigma2(:, :, i) + r(j, i) * (train(:, j) - Means2(:, i)) * (train(:, j) - Means2(:, i))';
            count = count + r(j, i);
        end
        Sigma2(:, :, i) = Sigma2(:, :, i)/count;
        for j = 1:K
            for k = 1:d
                diagSigma2(k, k, j) = Sigma2(k, k, j);
            end
        end
        Pi2(i) = count/N;
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
gamma1(length(xy), K) = 0;
gamma2(length(xy), K) = 0;

for i = 1:length(xy)
    llhood = 0;
    for j = 1:K
        llhood = llhood + (Pi1(j) * mvnpdf(xy(i, :), Means1(:,j)', diagSigma1(:,:,j)));
    end
    for j = 1:K
        gamma1(i, j) = (Pi1(j) * mvnpdf(xy(i, :), Means1(:,j)', diagSigma1(:,:,j)))/llhood;
    end
    m1 = llhood;
    %for j = 1:K
    %    m1 = m1 + Pi1(j)*gamma1(i, j);
    %end
    
    llhood = 0;
    for j = 1:K
        llhood = llhood + (Pi1(j) * mvnpdf(xy(i, :), Means2(:,j)', diagSigma2(:,:,j)));
    end
    for j = 1:K
        gamma2(i, j) = (Pi1(j) * mvnpdf(xy(i, :), Means2(:,j)', diagSigma2(:,:,j)))/llhood;
    end
    m2 = llhood;
    %for j = 1:K
    %    m2 = m2 + Pi2(j)*gamma2(i, j);
    %end
    
    if(m1 > m2)
        idx(i) = 1;
    else
        idx(i) = 2;
    end
end

decisionmap = reshape(idx, image_size);
%figure;
figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'all');
imagesc(xrange,yrange,decisionmap);
hold on;
set(gca,'ydir','normal');
cmap = [1 1 0.5; 0 1 1];
%cmap = [1 0.4 0.4; 0 0.7 0];

colormap(cmap);

h(1) = scatter(train(1:1, 1:N), train(2:2, 1:N), 5, 'filled', 'g'); hold on;
h(2) = scatter(train(1:1, (N + 1):2*N), train(2:2, (N + 1):2*N), 5, 'filled', 'b'); hold on;
h(3) = scatter(Means1(1:1, 1:K), Means1(2:2, 1:K), 40, 'filled', 'sr'); hold on;
h(4) = scatter(Means2(1:1, 1:K), Means2(2:2, 1:K), 40, 'filled', 'sk'); hold on;
for i = 1:K
    G = gmdistribution(Means1(:,i)', diagSigma1(:,:,i));
    f = @(x, y) pdf(G, [x y]);
    h(4 + 2*i - 1) = fcontour(f, [-14 2 -14 2], 'm');
    hold on;
    G = gmdistribution(Means2(:,i)', diagSigma2(:,:,i));
    f = @(x, y) pdf(G, [x y]);
    h(4 + 2*i) = fcontour(f, [-14 2 -14 2], 'c');
    hold on;
end
hold off;
title(sprintf('Case 2: Decision Surfaces for K = %d', K))
xlabel('x1');
ylabel('x2');
legend(h(1:2), {'class 1', 'class 2'}, 'Location', 'southeast');
hold off;
saveas(figure1,sprintf('GMM_Synthetic_case_2_%d.jpg', K));