clear;
clc;

load('pooled_means_15.mat');
for i=1:38
dev_data{i} = readmatrix(sprintf('team1_dev_3B/dev (%d).txt',i));
end
K = 15;
N = 0;
for i=1:38
   N = N + size(dev_data{i}, 1); 
end

fileID = fopen(sprintf('seq_dev_3B.txt'), 'w');
for n = 1:38
    l = size(dev_data{n}, 1);
    train = dev_data{n}';
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