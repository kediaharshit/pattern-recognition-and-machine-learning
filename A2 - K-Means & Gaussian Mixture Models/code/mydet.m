xrange = [-14 2];
yrange = [-14 2];
inc = 1;
[x, y] = meshgrid(xrange(1):inc:xrange(2), yrange(1):inc:yrange(2));
image_size = size(x);
xy = [x(:) y(:)];
xy = [reshape(x, image_size(1)*image_size(2),1) reshape(y, image_size(1)*image_size(2),1)];
idx(1:length(xy)) = 0;

for i = 1:length(xy)
    llhood = 0;
    for j = 1:K
        llhood = llhood + (Pi1(j) * mvnpdf(xy(i, :), Means1(:,j)', Sigma1(:,:,j)));
    end
    m1 = llhood;
    
    llhood = 0;
    for j = 1:K
        llhood = llhood + (Pi1(j) * mvnpdf(xy(i, :), Means2(:,j)', Sigma2(:,:,j)));
    end
    m2 = llhood;
    
    if(m1 > m2)
        idx(i) = 1;
    else
        idx(i) = 2;
    end
end

% DET
count = 1;
for p = -50:0.5:0
    i = exp(p);
    TP = 0;
    FP = 0;
    TN = 0;
    FN = 0;
    for k = 1:length(xy)
        x = xy(k, :);
        llhood = 0;
        for j = 1:K
            llhood = llhood + (Pi1(j) * mvnpdf(x, Means1(:,j)', Sigma1(:,:,j)));
        end
        m1 = llhood;
        
        llhood = 0;
        for j = 1:K
            llhood = llhood + (Pi1(j) * mvnpdf(x, Means2(:,j)', Sigma2(:,:,j)));
        end
        m2 = llhood;
        
        if(idx(k) == 1)
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
        if(idx(k) == 2)
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
    end    
    FPR = FP/(FP + TN);
    TPR = TP/(TP + FN);
    FNR = FN/(FN + TP);
    DET(2, count, :) = [FNR TPR];
    count = count + 1;
end