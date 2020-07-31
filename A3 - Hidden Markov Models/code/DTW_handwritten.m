clc
clear
load('handwritten.mat')

roc_counts(100, 5) = 0;
cnt = 1;

%Testing character ai against all training data
for i = 1:20
    predictions(330, 2) = 0;
    count = 1;
    for j = 1:66
        predictions(count, 1) = DTW(Dev1{i}, Train1{j});
        predictions(count, 2) = 1;
        count = count + 1;
    end
    for j = 1:66
        predictions(count, 1) = DTW(Dev1{i}, Train2{j});
        predictions(count, 2) = 2;
        count = count + 1;
    end
    for j = 1:66
        predictions(count, 1) = DTW(Dev1{i}, Train3{j});
        predictions(count, 2) = 3;
        count = count + 1;
    end
    for j = 1:66
        predictions(count, 1) = DTW(Dev1{i}, Train4{j});
        predictions(count, 2) = 4;
        count = count + 1;
    end
    for j = 1:66
        predictions(count, 1) = DTW(Dev1{i}, Train5{j});
        predictions(count, 2) = 5;
        count = count + 1;
    end
    predictions = sortrows(predictions);
    for j = 1:66
        roc_counts(cnt, predictions(j, 2)) = roc_counts(cnt, predictions(j, 2)) + 1;
    end
    cnt = cnt + 1;
end

%Testing character bA against all training data
for i = 1:20
    predictions(330, 2) = 0;
    count = 1;
    for j = 1:66
        predictions(count, 1) = DTW(Dev2{i}, Train1{j});
        predictions(count, 2) = 1;
        count = count + 1;
    end
    for j = 1:66
        predictions(count, 1) = DTW(Dev2{i}, Train2{j});
        predictions(count, 2) = 2;
        count = count + 1;
    end
    for j = 1:66
        predictions(count, 1) = DTW(Dev2{i}, Train3{j});
        predictions(count, 2) = 3;
        count = count + 1;
    end
    for j = 1:66
        predictions(count, 1) = DTW(Dev2{i}, Train4{j});
        predictions(count, 2) = 4;
        count = count + 1;
    end
    for j = 1:66
        predictions(count, 1) = DTW(Dev2{i}, Train5{j});
        predictions(count, 2) = 5;
        count = count + 1;
    end
    predictions = sortrows(predictions);
    for j = 1:66
        roc_counts(cnt, predictions(j, 2)) = roc_counts(cnt, predictions(j, 2)) + 1;
    end
    cnt = cnt + 1;
end

%Testing character chA against all training data
for i = 1:20
    predictions(330, 2) = 0;
    count = 1;
    for j = 1:66
        predictions(count, 1) = DTW(Dev3{i}, Train1{j});
        predictions(count, 2) = 1;
        count = count + 1;
    end
    for j = 1:66
        predictions(count, 1) = DTW(Dev3{i}, Train2{j});
        predictions(count, 2) = 2;
        count = count + 1;
    end
    for j = 1:66
        predictions(count, 1) = DTW(Dev3{i}, Train3{j});
        predictions(count, 2) = 3;
        count = count + 1;
    end
    for j = 1:66
        predictions(count, 1) = DTW(Dev3{i}, Train4{j});
        predictions(count, 2) = 4;
        count = count + 1;
    end
    for j = 1:66
        predictions(count, 1) = DTW(Dev3{i}, Train5{j});
        predictions(count, 2) = 5;
        count = count + 1;
    end
    predictions = sortrows(predictions);
    for j = 1:66
        roc_counts(cnt, predictions(j, 2)) = roc_counts(cnt, predictions(j, 2)) + 1;
    end
    cnt = cnt + 1;
end

%Testing character dA against all training data
for i = 1:20
    predictions(330, 2) = 0;
    count = 1;
    for j = 1:66
        predictions(count, 1) = DTW(Dev4{i}, Train1{j});
        predictions(count, 2) = 1;
        count = count + 1;
    end
    for j = 1:66
        predictions(count, 1) = DTW(Dev4{i}, Train2{j});
        predictions(count, 2) = 2;
        count = count + 1;
    end
    for j = 1:66
        predictions(count, 1) = DTW(Dev4{i}, Train3{j});
        predictions(count, 2) = 3;
        count = count + 1;
    end
    for j = 1:66
        predictions(count, 1) = DTW(Dev4{i}, Train4{j});
        predictions(count, 2) = 4;
        count = count + 1;
    end
    for j = 1:66
        predictions(count, 1) = DTW(Dev4{i}, Train5{j});
        predictions(count, 2) = 5;
        count = count + 1;
    end
    predictions = sortrows(predictions);
    for j = 1:66
        roc_counts(cnt, predictions(j, 2)) = roc_counts(cnt, predictions(j, 2)) + 1;
    end
    cnt = cnt + 1;
end

%Testing character tA against all training data
for i = 1:20
    predictions(330, 2) = 0;
    count = 1;
    for j = 1:66
        predictions(count, 1) = DTW(Dev5{i}, Train1{j});
        predictions(count, 2) = 1;
        count = count + 1;
    end
    for j = 1:66
        predictions(count, 1) = DTW(Dev5{i}, Train2{j});
        predictions(count, 2) = 2;
        count = count + 1;
    end
    for j = 1:66
        predictions(count, 1) = DTW(Dev5{i}, Train3{j});
        predictions(count, 2) = 3;
        count = count + 1;
    end
    for j = 1:66
        predictions(count, 1) = DTW(Dev5{i}, Train4{j});
        predictions(count, 2) = 4;
        count = count + 1;
    end
    for j = 1:66
        predictions(count, 1) = DTW(Dev5{i}, Train5{j});
        predictions(count, 2) = 5;
        count = count + 1;
    end
    predictions = sortrows(predictions);
    for j = 1:66
        roc_counts(cnt, predictions(j, 2)) = roc_counts(cnt, predictions(j, 2)) + 1;
    end
    cnt = cnt + 1;
end