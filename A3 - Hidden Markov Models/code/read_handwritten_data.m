clc
clear

%Reading data for class 1 ai
for i = 1:70
    fileID = fopen(sprintf('Handwritten_Data/ai/train/%d.txt', i-1), 'r');
    x = fscanf(fileID, '%f');
    n = x(1);
    y(n, 2) = 0;
    for j = 1:n
        y(j, 1) = x(2*j);
        y(j, 2) = x(2*j + 1);
    end
    fclose(fileID); y = y - y(1, :);
    Train1{i} = y;
    clear x;
    clear y;
    clear n;
    clear fileID;
end
for i = 1:20
    fileID = fopen(sprintf('Handwritten_Data/ai/dev/%d.txt', 69+i), 'r');
    x = fscanf(fileID, '%f');
    n = x(1);
    y(n, 2) = 0;
    for j = 1:n
        y(j, 1) = x(2*j);
        y(j, 2) = x(2*j + 1);
    end
    fclose(fileID); y = y - y(1, :);
    Dev1{i} = y;
    clear x;
    clear y;
    clear n;
    clear fileID;
end

%Reading data for class 2 bA
for i = 1:67
    fileID = fopen(sprintf('Handwritten_Data/bA/train/%d.txt', i-1), 'r');
    x = fscanf(fileID, '%f');
    n = x(1);
    y(n, 2) = 0;
    for j = 1:n
        y(j, 1) = x(2*j);
        y(j, 2) = x(2*j + 1);
    end
    fclose(fileID); y = y - y(1, :);
    Train2{i} = y;
    clear x;
    clear y;
    clear n;
    clear fileID;
end
for i = 1:20
    fileID = fopen(sprintf('Handwritten_Data/bA/dev/%d.txt', 66+i), 'r');
    x = fscanf(fileID, '%f');
    n = x(1);
    y(n, 2) = 0;
    for j = 1:n
        y(j, 1) = x(2*j);
        y(j, 2) = x(2*j + 1);
    end
    fclose(fileID); y = y - y(1, :);
    Dev2{i} = y;
    clear x;
    clear y;
    clear n;
    clear fileID;
end

%Reading data for class 3 chA
for i = 1:70
    fileID = fopen(sprintf('Handwritten_Data/chA/train/%d.txt', i-1), 'r');
    x = fscanf(fileID, '%f');
    n = x(1);
    y(n, 2) = 0;
    for j = 1:n
        y(j, 1) = x(2*j);
        y(j, 2) = x(2*j + 1);
    end
    fclose(fileID); y = y - y(1, :);
    Train3{i} = y;
    clear x;
    clear y;
    clear n;
    clear fileID;
end
for i = 1:20
    fileID = fopen(sprintf('Handwritten_Data/chA/dev/%d.txt', 69+i), 'r');
    x = fscanf(fileID, '%f');
    n = x(1);
    y(n, 2) = 0;
    for j = 1:n
        y(j, 1) = x(2*j);
        y(j, 2) = x(2*j + 1);
    end
    fclose(fileID); y = y - y(1, :);
    Dev3{i} = y;
    clear x;
    clear y;
    clear n;
    clear fileID;
end

%Reading data for class 4 dA
for i = 1:69
    fileID = fopen(sprintf('Handwritten_Data/dA/train/%d.txt', i-1), 'r');
    x = fscanf(fileID, '%f');
    n = x(1);
    y(n, 2) = 0;
    for j = 1:n
        y(j, 1) = x(2*j);
        y(j, 2) = x(2*j + 1);
    end
    fclose(fileID); y = y - y(1, :);
    Train4{i} = y;
    clear x;
    clear y;
    clear n;
    clear fileID;
end
for i = 1:20
    fileID = fopen(sprintf('Handwritten_Data/dA/dev/%d.txt', 68+i), 'r');
    x = fscanf(fileID, '%f');
    n = x(1);
    y(n, 2) = 0;
    for j = 1:n
        y(j, 1) = x(2*j);
        y(j, 2) = x(2*j + 1);
    end
    fclose(fileID); y = y - y(1, :);
    Dev4{i} = y;
    clear x;
    clear y;
    clear n;
    clear fileID;
end

%Reading data for class 5 tA
for i = 1:69
    fileID = fopen(sprintf('Handwritten_Data/tA/train/%d.txt', i-1), 'r');
    x = fscanf(fileID, '%f');
    n = x(1);
    y(n, 2) = 0;
    for j = 1:n
        y(j, 1) = x(2*j);
        y(j, 2) = x(2*j + 1);
    end
    fclose(fileID); y = y - y(1, :);
    Train5{i} = y;
    clear x;
    clear y;
    clear n;
    clear fileID;
end
for i = 1:20
    fileID = fopen(sprintf('Handwritten_Data/tA/dev/%d.txt', 68+i), 'r');
    x = fscanf(fileID, '%f');
    n = x(1);
    y(n, 2) = 0;
    for j = 1:n
        y(j, 1) = x(2*j);
        y(j, 2) = x(2*j + 1);
    end
    fclose(fileID); y = y - y(1, :);
    Dev5{i} = y;
    clear x;
    clear y;
    clear n;
    clear fileID;
end