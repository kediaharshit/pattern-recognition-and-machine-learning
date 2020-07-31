clc; clear;
count = 1;
load('digit.mat');
for i=1:39
    Train{count} = Train1{i};  
    count = count+1;
end
for i=1:39
    Train{count} = Train3{i};  
    count = count+1;
end
for i=1:39
    Train{count} = Train4{i};  
    count = count+1;
end
for i=1:39
    Train{count} = Train7{i};  
    count = count+1;
end
for i=1:39
    Train{count} = Train9{i};  
    count = count+1;
end

count = 1;
for i=1:12
    Dev{count} = Dev1{i};
    count = count+1;
end
for i=1:12
    Dev{count} = Dev3{i};
    count = count+1;
end
for i=1:12
    Dev{count} = Dev4{i};
    count = count+1;
end
for i=1:12
    Dev{count} = Dev7{i};
    count = count+1;
end
for i=1:12
    Dev{count} = Dev9{i};
    count = count+1;
end


N=0;
Nd = 0;
for i=1:195
   N = N + size(Train{i}, 1); 
end
for i=1:60
   Nd= Nd + size(Dev{i}, 1);
end
d=38;

K = 11;
Nk(1:K) = 0;
Means(1:d, 1:K) = 0;
r(1:N, 1:K) = 0;
dist(K) = 0;

train_(N, d) = 0;
dev_(Nd, d) = 0;
count = 1;
for i=1:195
    l = size(Train{i} ,1);
    for j = 1:l
        train_(count, :) = Train{i}(j, :);
        count = count + 1;
    end
end
count = 1;
for i=1:60
    l = size(Dev{i} ,1);
    for j = 1:l
        dev_(count, :) = Dev{i}(j, :);
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
