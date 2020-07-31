clc;
clear;

fname = 'CMU_20020319-1400';
load(append(fname, '_gmm.mat'));

cnt = 1;
w(1:cnt) = 1;
for i = 1:100:size(sel, 1)
    x = min(100, size(sel, 1) - i);
    mean(19) = 0;
    var(19, 19) = 0;
    for j = 1:x
       mean = mean + sel(i + j - 1, :);
    end
    mean = mean/x;
    for j = 1:x
       var = var + (sel(i+j-1, :)' - mean')*(sel(i+j-1, :)' - mean')'; 
    end
    var = var/x;
    msel(cnt, :) = mean;
    varsel(cnt, :, :) = var;
    w(cnt) = x;
    cnt = cnt + 1;
end

%msel = msel(1:10, :);
link = linkage(msel);

inf = 1000000000;
cnt = cnt - 1;
%cnt = 10;
MIN = inf;
mini = 0;
minj = 0;
M(1:cnt, 1:cnt) = 0;
for i = 1:cnt-1
   for j = (i+1):cnt
      sig1(:,:) = varsel(i,:,:);
      sig2(:,:) = varsel(j,:,:);
      m1 = msel(i, :)';
      m2 = msel(j, :)';
      KL1 = log(det(sig1)/det(sig2)) - 19 + trace(sig1\sig2);
      KL1 = KL1 + (m1 - m2)'*(sig1\(m1 - m2));
      KL2 = log(det(sig2)/det(sig1)) - 19 + trace(sig2\sig1);
      KL2 = KL2 + (m2 - m1)'*(sig2\(m2 - m1));
      dist = (KL1 + KL2)/2;
      M(i, j) = dist;
      if(MIN > dist)
         MIN = dist;
         mini = i;
         minj = j;
      end
   end
end

ct = cnt;
chut = 1;
for i = 1:ct-1
    ct = ct + 1;
    w(ct) = w(mini) + w(minj);
    mean = (w(mini)/w(ct))*msel(mini, :) + (w(minj)/w(ct))*msel(minj, :);
    msel(ct, :) = mean;
    var = (w(mini)/w(ct))*varsel(mini, :, :) + (w(minj)/w(ct))*varsel(minj, :, :);
    varsel(ct, :, :) = var;
    cluster(ct - cnt, 1) = mini;
    cluster(ct - cnt, 2) = minj;
    cluster(ct - cnt, 3) = MIN;
    for j = 1:ct-1
       sig1(:,:) = varsel(ct,:,:);
       sig2(:,:) = varsel(j,:,:);
       m1 = msel(ct, :)';
       m2 = msel(j, :)';
       KL1 = log(det(sig1)/det(sig2)) - 19 + trace(sig1\sig2);
       KL1 = KL1 + (m1 - m2)'*(sig1\(m1 - m2));
       KL2 = log(det(sig2)/det(sig1)) - 19 + trace(sig2\sig1);
       KL2 = KL2 + (m2 - m1)'*(sig2\(m2 - m1));
       dist = (KL1 + KL2)/2;
       M(j, ct) = dist;
    end
    M(ct, ct) = 0;
    remove(chut) = mini;
    remove(chut+1) = minj;
    chut = chut + 2;
    for j = 1:(mini-1)
       M(j, mini) = inf;
    end
    for j = (mini+1):ct
       M(mini, j) = inf; 
    end
    for j = 1:(minj-1)
       M(j, minj) = inf;
    end
    for j = (minj+1):ct
       M(minj, j) = inf; 
    end
    for j = 1:chut-1
       M(remove(j), ct) = inf;
    end
    MIN = inf;
    mini = 0;
    minj = 0;
    for j = 1:ct-1
        for k = (j+1):ct
            if(MIN > M(j, k))
                MIN = M(j, k);
                mini = j;
                minj = k;
            end
        end
    end
end

