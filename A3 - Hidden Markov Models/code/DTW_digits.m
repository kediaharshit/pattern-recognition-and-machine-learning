clc
clear
load('digit.mat')

roc_counts(60, 5) = 0;
cnt = 1;

%Testing digit 1 against all training data
for i = 1:12
    predictions(195, 2) = 0;
    count = 1;
    for j = 1:39
        predictions(count, 1) = DTW(Dev1{i}, Train1{j});
        predictions(count, 2) = 1;
        count = count + 1;
    end
    for j = 1:39
        predictions(count, 1) = DTW(Dev1{i}, Train3{j});
        predictions(count, 2) = 2;
        count = count + 1;
    end
    for j = 1:39
        predictions(count, 1) = DTW(Dev1{i}, Train4{j});
        predictions(count, 2) = 3;
        count = count + 1;
    end
    for j = 1:39
        predictions(count, 1) = DTW(Dev1{i}, Train7{j});
        predictions(count, 2) = 4;
        count = count + 1;
    end
    for j = 1:39
        predictions(count, 1) = DTW(Dev1{i}, Train9{j});
        predictions(count, 2) = 5;
        count = count + 1;
    end
    predictions = sortrows(predictions);
    for j = 1:39
        roc_counts(cnt, predictions(j, 2)) = roc_counts(cnt, predictions(j, 2)) + 1;
    end
    cnt = cnt + 1;
end

%Testing digit 3 against all training data
for i = 1:12
    predictions(195, 2) = 0;
    count = 1;
    for j = 1:39
        predictions(count, 1) = DTW(Dev3{i}, Train1{j});
        predictions(count, 2) = 1;
        count = count + 1;
    end
    for j = 1:39
        predictions(count, 1) = DTW(Dev3{i}, Train3{j});
        predictions(count, 2) = 2;
        count = count + 1;
    end
    for j = 1:39
        predictions(count, 1) = DTW(Dev3{i}, Train4{j});
        predictions(count, 2) = 3;
        count = count + 1;
    end
    for j = 1:39
        predictions(count, 1) = DTW(Dev3{i}, Train7{j});
        predictions(count, 2) = 4;
        count = count + 1;
    end
    for j = 1:39
        predictions(count, 1) = DTW(Dev3{i}, Train9{j});
        predictions(count, 2) = 5;
        count = count + 1;
    end
    predictions = sortrows(predictions);
    for j = 1:39
        roc_counts(cnt, predictions(j, 2)) = roc_counts(cnt, predictions(j, 2)) + 1;
    end
    cnt = cnt + 1;
end

%Testing digit 4 against all training data
for i = 1:12
    predictions(195, 2) = 0;
    count = 1;
    for j = 1:39
        predictions(count, 1) = DTW(Dev4{i}, Train1{j});
        predictions(count, 2) = 1;
        count = count + 1;
    end
    for j = 1:39
        predictions(count, 1) = DTW(Dev4{i}, Train3{j});
        predictions(count, 2) = 2;
        count = count + 1;
    end
    for j = 1:39
        predictions(count, 1) = DTW(Dev4{i}, Train4{j});
        predictions(count, 2) = 3;
        count = count + 1;
    end
    for j = 1:39
        predictions(count, 1) = DTW(Dev4{i}, Train7{j});
        predictions(count, 2) = 4;
        count = count + 1;
    end
    for j = 1:39
        predictions(count, 1) = DTW(Dev4{i}, Train9{j});
        predictions(count, 2) = 5;
        count = count + 1;
    end
    predictions = sortrows(predictions);
    for j = 1:39
        roc_counts(cnt, predictions(j, 2)) = roc_counts(cnt, predictions(j, 2)) + 1;
    end
    cnt = cnt + 1;
end

%Testing digit 7 against all training data
for i = 1:12
    predictions(195, 2) = 0;
    count = 1;
    for j = 1:39
        predictions(count, 1) = DTW(Dev7{i}, Train1{j});
        predictions(count, 2) = 1;
        count = count + 1;
    end
    for j = 1:39
        predictions(count, 1) = DTW(Dev7{i}, Train3{j});
        predictions(count, 2) = 2;
        count = count + 1;
    end
    for j = 1:39
        predictions(count, 1) = DTW(Dev7{i}, Train4{j});
        predictions(count, 2) = 3;
        count = count + 1;
    end
    for j = 1:39
        predictions(count, 1) = DTW(Dev7{i}, Train7{j});
        predictions(count, 2) = 4;
        count = count + 1;
    end
    for j = 1:39
        predictions(count, 1) = DTW(Dev7{i}, Train9{j});
        predictions(count, 2) = 5;
        count = count + 1;
    end
    predictions = sortrows(predictions);
    for j = 1:39
        roc_counts(cnt, predictions(j, 2)) = roc_counts(cnt, predictions(j, 2)) + 1;
    end
    cnt = cnt + 1;
end

%Testing digit 9 against all training data
for i = 1:12
    predictions(195, 2) = 0;
    count = 1;
    for j = 1:39
        predictions(count, 1) = DTW(Dev9{i}, Train1{j});
        predictions(count, 2) = 1;
        count = count + 1;
    end
    for j = 1:39
        predictions(count, 1) = DTW(Dev9{i}, Train3{j});
        predictions(count, 2) = 2;
        count = count + 1;
    end
    for j = 1:39
        predictions(count, 1) = DTW(Dev9{i}, Train4{j});
        predictions(count, 2) = 3;
        count = count + 1;
    end
    for j = 1:39
        predictions(count, 1) = DTW(Dev9{i}, Train7{j});
        predictions(count, 2) = 4;
        count = count + 1;
    end
    for j = 1:39
        predictions(count, 1) = DTW(Dev9{i}, Train9{j});
        predictions(count, 2) = 5;
        count = count + 1;
    end
    predictions = sortrows(predictions);
    for j = 1:39
        roc_counts(cnt, predictions(j, 2)) = roc_counts(cnt, predictions(j, 2)) + 1;
    end
    cnt = cnt + 1;
end