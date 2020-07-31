clc 
clear
load('digit_roc_counts.mat')

confusion_matrix(5, 5) = 0;

cnt = 1;
for i = 1:12
    [mx, ind] = max(hmm_counts(cnt, :));
    confusion_matrix(ind, 1) = confusion_matrix(ind, 1) + 1;
    cnt = cnt + 1;
end
for i = 1:12
    [mx, ind] = max(hmm_counts(cnt, :));
    confusion_matrix(ind, 2) = confusion_matrix(ind, 2) + 1;
    cnt = cnt + 1;
end
for i = 1:12
    [mx, ind] = max(hmm_counts(cnt, :));
    confusion_matrix(ind, 3) = confusion_matrix(ind, 3) + 1;
    cnt = cnt + 1;
end
for i = 1:12
    [mx, ind] = max(hmm_counts(cnt, :));
    confusion_matrix(ind, 4) = confusion_matrix(ind, 4) + 1;
    cnt = cnt + 1;
end
for i = 1:12
    [mx, ind] = max(hmm_counts(cnt, :));
    confusion_matrix(ind, 5) = confusion_matrix(ind, 5) + 1;
    cnt = cnt + 1;
end