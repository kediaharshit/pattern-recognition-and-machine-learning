% ROC
count = 1;
for p = -50:0.1:0
    i = exp(p);
    TP = 0;
    FP = 0;
    TN = 0;
    FN = 0;
    for k = 1:500
        x = dev(:, k);
        llhood = 0;
        for j = 1:K
            llhood = llhood + (Pi1(j) * mvnpdf(x', Means1(:,j)', Sigma1(:,:,j)));
        end
        m1 = llhood;
        
        llhood = 0;
        for j = 1:K
            llhood = llhood + (Pi1(j) * mvnpdf(x', Means2(:,j)', Sigma2(:,:,j)));
        end
        m2 = llhood;
        if(m1 > i)
            TP = TP + 1;
        else
            FN = FN + 1;
        end
        if(m2 > i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
    end
    for k = 501:1000
        x = dev(:, k);
        llhood = 0;
        for j = 1:K
            llhood = llhood + (Pi1(j) * mvnpdf(x', Means1(:,j)', Sigma1(:,:,j)));
        end
        m1 = llhood;
        
        llhood = 0;
        for j = 1:K
            llhood = llhood + (Pi1(j) * mvnpdf(x', Means2(:,j)', Sigma2(:,:,j)));
        end
        m2 = llhood;
        if(m1 > i)
            TP = TP + 1;
        else
            FN = FN + 1;
        end
        if(m2 > i)
            FP = FP + 1;
        else
            TN = TN + 1;
        end
    end
    FPR = FP/(FP + TN);
    TPR = TP/(TP + FN);
    FNR = FN/(FN + TP);
    ROC(1, count, :) = [FPR TPR];
    count = count + 1;
end

figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'all');
plot(ROC(1,:,1), ROC(1,:,2), ROC(2,:,1), ROC(2,:,2), 'LineWidth', 2);
title(sprintf('ROC Curve'));
xlabel('False Positive Rate');
ylabel('True Positive Rate');
legend({'Non diagnol Covariance ', 'Diagnol Covariance'}, 'Location', 'southeast');
saveas(figure1, sprintf('GMM_SD_ROC.jpg'));