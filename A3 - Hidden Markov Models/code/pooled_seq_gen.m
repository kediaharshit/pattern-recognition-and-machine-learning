clc; clear;
%load('digit.mat');
load('pooled_means_11.mat');
%K = 11;
d=38;
N=0;
Nd = 0;
dist(K) = 0;
for i=1:39
   N = N + size(Train3{i}, 1); 
end
for i=1:12
   Nd = Nd + size(Dev3{i}, 1); 
end
train_(N, d) = 0;
dev_(Nd, d) = 0;
count = 1;
for i=1:39
    l = size(Train3{i} ,1);
    for j = 1:l
        train_(count, :) = Train3{i}(j, :);
        count = count + 1;
    end
end
count = 1;
for i=1:12
    l = size(Dev3{i} ,1);
    for j = 1:l
        dev_(count, :) = Dev3{i}(j, :);
        count = count + 1;
    end
end
train = train_';
dev = dev_';

fileID = fopen(sprintf('seq_Train3_%d.txt', K), 'w');
for n = 1:39
    l = size(Train3{n}, 1);
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

fileID = fopen(sprintf('seq_Dev3_%d.txt', K), 'w');
for n = 1:12
    l = size(Dev3{n}, 1);
    for i = 1:l
        for j = 1:K
            dist(j) = (dev(:, i) - Means(:, j))' * (dev(:, i) - Means(:, j)); 
        end
        [m, id] = min(dist);
        fprintf(fileID, '%d ', id-1);
    end
    fprintf(fileID, '\n');
end
fclose(fileID);