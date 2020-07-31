clc
clear
load('handwritten_roc_counts.mat')

roc_dtw(1:67, 1:2) = 0;
det_dtw(1:67, 1:2) = 0;
roc_hmm(1:251, 1:2) = 0;
det_hmm(1:251, 1:2) = 0;

for th = 1:67
    TP = 0;
    TN = 0;
    FP = 0;
    FN = 0;
    cnt = 1;
    %Test for character ai
    for i = 1:20
        %Test against character ai
        if dtw_counts(cnt, 1) > th - 1
            TP = TP + 1;
        else
            FN = FN + 1;
        end
        %Test against character bA
        if dtw_counts(cnt, 2) > th - 1
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character chA
        if dtw_counts(cnt, 3) > th - 1
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character dA
        if dtw_counts(cnt, 4) > th - 1
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character tA
        if dtw_counts(cnt, 5) > th - 1
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        cnt = cnt + 1;
    end
    %Test for character bA
    for i = 1:20
        %Test against character ai
        if dtw_counts(cnt, 1) > th - 1
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character bA
        if dtw_counts(cnt, 2) > th - 1
            TP = TP + 1;
        else
            FN = FN + 1;
        end
        %Test against character chA
        if dtw_counts(cnt, 3) > th - 1
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character dA
        if dtw_counts(cnt, 4) > th - 1
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character tA
        if dtw_counts(cnt, 5) > th - 1
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        cnt = cnt + 1;
    end
    %Test for character chA
    for i = 1:20
        %Test against character ai
        if dtw_counts(cnt, 1) > th - 1
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character bA
        if dtw_counts(cnt, 2) > th - 1
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character chA
        if dtw_counts(cnt, 3) > th - 1
            TP = TP + 1;
        else
            FN = FN + 1;
        end
        %Test against character dA
        if dtw_counts(cnt, 4) > th - 1
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character tA
        if dtw_counts(cnt, 5) > th - 1
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        cnt = cnt + 1;
    end
    %Test for character dA
    for i = 1:20
        %Test against character ai
        if dtw_counts(cnt, 1) > th - 1
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character bA
        if dtw_counts(cnt, 2) > th - 1
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character chA
        if dtw_counts(cnt, 3) > th - 1
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character dA
        if dtw_counts(cnt, 4) > th - 1
            TP = TP + 1;
        else
            FN = FN + 1;
        end
        %Test against character tA
        if dtw_counts(cnt, 5) > th - 1
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        cnt = cnt + 1;
    end
    %Test for character tA
    for i = 1:20
        %Test against character ai
        if dtw_counts(cnt, 1) > th - 1
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character bA
        if dtw_counts(cnt, 2) > th - 1
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character chA
        if dtw_counts(cnt, 3) > th - 1
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character dA
        if dtw_counts(cnt, 4) > th - 1
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character tA
        if dtw_counts(cnt, 5) > th - 1
            TP = TP + 1;
        else
            FN = FN + 1;
        end
        cnt = cnt + 1;
    end
    FPR = FP/(FP + TN);
    TPR = TP/(TP + FN);
    FNR = 1 - TPR;
    roc_dtw(th, :) = [FPR, TPR];
    det_dtw(th, :) = [norminv(FPR), norminv(FNR)];
end

count = 1;
for th = -300:-50
    TP = 0;
    TN = 0;
    FP = 0;
    FN = 0;
    cnt = 1;
    %Test for character ai
    for i = 1:20
        %Test against character ai
        if hmm_counts(cnt, 1) > th
            TP = TP + 1;
        else
            FN = FN + 1;
        end
        %Test against character bA
        if hmm_counts(cnt, 2) > th
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character chA
        if hmm_counts(cnt, 3) > th
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character dA
        if hmm_counts(cnt, 4) > th
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character tA
        if hmm_counts(cnt, 5) > th
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        cnt = cnt + 1;
    end
    %Test for character bA
    for i = 1:20
        %Test against character ai
        if hmm_counts(cnt, 1) > th
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character bA
        if hmm_counts(cnt, 2) > th
            TP = TP + 1;
        else
            FN = FN + 1;
        end
        %Test against character chA
        if hmm_counts(cnt, 3) > th
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character dA
        if hmm_counts(cnt, 4) > th
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character tA
        if hmm_counts(cnt, 5) > th
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        cnt = cnt + 1;
    end
    %Test for character chA
    for i = 1:20
        %Test against character ai
        if hmm_counts(cnt, 1) > th
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character bA
        if hmm_counts(cnt, 2) > th
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character chA
        if hmm_counts(cnt, 3) > th
            TP = TP + 1;
        else
            FN = FN + 1;
        end
        %Test against character dA
        if hmm_counts(cnt, 4) > th
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character tA
        if hmm_counts(cnt, 5) > th
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        cnt = cnt + 1;
    end
    %Test for character dA
    for i = 1:20
        %Test against character ai
        if hmm_counts(cnt, 1) > th
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character bA
        if hmm_counts(cnt, 2) > th
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character chA
        if hmm_counts(cnt, 3) > th
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character dA
        if hmm_counts(cnt, 4) > th
            TP = TP + 1;
        else
            FN = FN + 1;
        end
        %Test against character tA
        if hmm_counts(cnt, 5) > th
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        cnt = cnt + 1;
    end
    %Test for character tA
    for i = 1:20
        %Test against character ai
        if hmm_counts(cnt, 1) > th
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character bA
        if hmm_counts(cnt, 2) > th
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character chA
        if hmm_counts(cnt, 3) > th
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character dA
        if hmm_counts(cnt, 4) > th
            FP = FP + 1;
        else
            TN = TN + 1;
        end
        %Test against character tA
        if hmm_counts(cnt, 5) > th
            TP = TP + 1;
        else
            FN = FN + 1;
        end
        cnt = cnt + 1;
    end
    FPR = FP/(FP + TN);
    TPR = TP/(TP + FN);
    FNR = 1 - TPR;
    roc_hmm(count, :) = [FPR, TPR];
    det_hmm(count, :) = [norminv(FPR), norminv(FNR)];
    count = count + 1;
end

% ROC DET Plots 
figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'all');
plot(roc_dtw(:, 1), roc_dtw(:, 2), roc_hmm(:, 1), roc_hmm(:, 2), 'LineWidth', 2);
title(sprintf('ROC Curve for Handwritten Data'));
xlabel('False Positive Rate');
ylabel('True Positive Rate');
legend({'DTW', 'HMM'}, 'Location', 'southeast');
saveas(figure1, sprintf('handwritten_ROC.jpg'));

figure2 = figure;
axes1 = axes('Parent',figure2);
hold(axes1,'all');
plot(det_dtw(:, 1), det_dtw(:, 2), det_hmm(:, 1), det_hmm(:, 2), 'LineWidth', 2);
title(sprintf('DET Curve for Handwritten Data'));
xlabel('False Alarm Rate');
ylabel('Missed Detection Rate');
legend({'DTW', 'HMM'}, 'Location', 'northeast');
saveas(figure2, sprintf('handwritten_DET.jpg'));