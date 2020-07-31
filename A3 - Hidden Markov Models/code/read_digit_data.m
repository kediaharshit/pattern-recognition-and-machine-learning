clc 
clear

for i = 1:39
    Train1{i} = readmatrix(sprintf('Digits/1/train1 (%d).txt', i));
end
for i = 1:12
    Dev1{i} = readmatrix(sprintf('Digits/1/dev1 (%d).txt', i));
end

for i = 1:39
    Train3{i} = readmatrix(sprintf('Digits/3/train3 (%d).txt', i));
end
for i = 1:12
    Dev3{i} = readmatrix(sprintf('Digits/3/dev3 (%d).txt', i));
end

for i = 1:39
    Train4{i} = readmatrix(sprintf('Digits/4/train4 (%d).txt', i));
end
for i = 1:12
    Dev4{i} = readmatrix(sprintf('Digits/4/dev4 (%d).txt', i));
end

for i = 1:39
    Train7{i} = readmatrix(sprintf('Digits/7/train7 (%d).txt', i));
end
for i = 1:12
    Dev7{i} = readmatrix(sprintf('Digits/7/dev7 (%d).txt', i));
end

for i = 1:39
    Train9{i} = readmatrix(sprintf('Digits/9/train9 (%d).txt', i));
end
for i = 1:12
    Dev9{i} = readmatrix(sprintf('Digits/9/dev9 (%d).txt', i));
end