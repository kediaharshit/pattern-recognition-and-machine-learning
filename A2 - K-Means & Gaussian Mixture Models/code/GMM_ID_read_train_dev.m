clc 
clear

n = 150;
N = 36*n;
nd = 50;
Nd = 36*nd;
train(1:23, 1:N, 1:5) = 0;
dev(1:23, 1:Nd, 1:5) = 0;
count = 1;
for i = 1:n
   in = readmatrix(sprintf('coast (%d).txt', i));
   for j = 1:36
        train( :, count, 1) = in(j, :);
        count = count+1;
   end
end
count = 1;
for i = 1:n
   in = readmatrix(sprintf('highway (%d).txt', i));
   for j = 1:36
        train(:, count, 2) = in(j, :);
        count = count+1;
   end
end
count = 1;
for i = 1:n
   in = readmatrix(sprintf('mountain (%d).txt', i));
   for j = 1:36
        train( :, count, 3) = in(j, :);
        count = count+1;
   end   
end
count = 1;
for i = 1:n
   in = readmatrix(sprintf('opencountry (%d).txt', i));
   for j = 1:36
        train( :, count, 4) = in(j, :);
        count = count+1;
   end
end
count = 1;
for i = 1:n
   in = readmatrix(sprintf('tallbuilding (%d).txt', i));
   for j = 1:36
        train(:, count, 5) = in(j, :);
        count = count+1;
   end
end

% read dev set 
count = 1;
for i = 1:nd
   in = readmatrix(sprintf('coast_dev (%d).txt', i));
   for j = 1:36
        dev( :, count, 1) = in(j, :);
        count = count+1;
   end
end
count = 1;
for i = 1:nd
   in = readmatrix(sprintf('highway_dev (%d).txt', i));
   for j = 1:36
        dev(:,count, 2) = in(j, :);
        count = count+1;
   end
end
count = 1;
for i = 1:nd
   in = readmatrix(sprintf('mountain_dev (%d).txt', i));
   for j = 1:36
        dev(:, count, 3) = in(j, :);
        count = count+1;
   end   
end
count = 1;
for i = 1:nd
   in = readmatrix(sprintf('opencountry_dev (%d).txt', i));
   for j = 1:36
        dev(:, count, 4) = in(j, :);
        count = count+1;
   end
end
count = 1;
for i = 1:nd
   in = readmatrix(sprintf('tallbuilding_dev (%d).txt', i));
   for j = 1:36
        dev(:, count, 5) = in(j, :);
        count = count+1;
   end
end
