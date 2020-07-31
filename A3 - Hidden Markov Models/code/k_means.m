clear
clc
load ('digit_roc_counts.mat');
%K-Means
N=0;
Nd = 0;
for i=1:39
   N = N + size(Train9{i}, 1); 
end
for i=1:12
   Nd = Nd + size(Dev9{i}, 1); 
end

d = 38;
K = 5;
Nk(1:K) = 0;
Means(1:d, 1:K) = 0;
r(1:N, 1:K) = 0;
dist(K) = 0;

train_(N, d) = 0;
dev_(Nd, d) = 0;
count = 1;
for i=1:39
    l = size(Train9{i} ,1);
    for j = 1:l
        train_(count, :) = Train9{i}(j, :);
        count = count + 1;
    end
end
count = 1;
for i=1:12
    l = size(Dev9{i} ,1);
    for j = 1:l
        dev_(count, :) = Dev9{i}(j, :);
        count = count + 1;
    end
end
train = train_';
dev = dev_';

for i = 1:K
    Means(:, i) = train(:, randi(N));
end

for itr = 1:10
    r(1:N, 1:K) = 0;
    for i = 1:N
        for j = 1:K
            dist(j) = (train(:, i) - Means(:, j))' * (train(:, i) - Means(:, j)); 
        end
        [m, id] = min(dist);
        r(i, id) = 1;
    end
    
    for i = 1:K
        Means(:, i) = 0;
        count = 0;
        for j = 1:N
            Means(:, i) = Means(:, i) + (r(j, i) * train(:, j));
            count = count + r(j, i);
        end
        Nk(i) = count;
        Means(:, i) = Means(:, i)/count;
    end
end

fileID = fopen(sprintf('seq_Train9_%d.txt', K), 'w');
for n = 1:39
    l = size(Train9{n}, 1);
    for i = 1:l
        for j = 1:K
            dist(j) = (train(:, i) - Means(:, j))' * (train(:, i) - Means(:, j)); 
        end
        [m, id] = min(dist);
        fprintf(fileID, '%d ', id-1);
    end
    fprintf(fileID, '\n');
end
fclose(fileID);

fileID = fopen(sprintf('seq_Dev9_%d.txt', K), 'w');

for n = 1:12
    l = size(Dev9{n}, 1);
    for i = 1:l
        for j = 1:K
            dist(j) = (dev(:, i) - Means(:, j))' * (dev(:, i) - Means(:, j)); 
        end
        [m, id] = min(dist);
        fprintf(fileID, '%d ', id-1);
    end
    fprintf(fileID, '\n');
end