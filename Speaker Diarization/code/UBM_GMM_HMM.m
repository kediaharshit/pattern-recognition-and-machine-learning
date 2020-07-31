clc;
clear;

fname = 'NIST_20030925-1517';
load(append(fname, '.mat'));
K = 4;
ITR = 5;

cnt = 1;
w(1:cnt) = 1;
for i = 1:400:size(sel, 1)
    x = min(400, size(sel, 1) - i);
    pool(1:x, 1:19) = 0;
    for j = 1:x
       pool(j, :) = sel(i+j-1, :);
    end
    xsel{cnt} = pool;
    clear pool;
    w(cnt) = x;
    cnt = cnt + 1;
end

%msel = msel(1:10, :);
%link = linkage(msel);

inf = 1000000000;
cnt = cnt - 1;
%cnt = 10;
MIN = inf;
mini = 0;
minj = 0;
M(1:cnt, 1:cnt) = 0;
for i = 1:cnt-1
   for j = (i+1):cnt
      pool(1:(w(i) + w(j)), 1:19) = 0;
      pool(1:w(i), :) = xsel{i};
      pool((w(i)+1):(w(i) + w(j)), :) = xsel{j};
      gmm = fitgmdist(pool, K, 'CovarianceType', 'diagonal', 'SharedCovariance', true, 'Options', statset('MaxIter', ITR));
      dist = gmm.BIC;
      clear pool;
      M(i, j) = dist;
      if(MIN > dist)
         MIN = dist;
         mini = i;
         minj = j;
      end
   end
end

K = 4;

ct = cnt;
chut = 1;
for i = 1:ct-1
    ct = ct + 1;
    w(ct) = w(mini) + w(minj);
    
    pool(1:(w(mini) + w(minj)), 1:19) = 0;
    pool(1:w(mini), :) = xsel{mini};
    pool((w(mini)+1):(w(mini) + w(minj)), :) = xsel{minj};
    xsel{ct} = pool;
    xsel{mini} = [];
    xsel{minj} = [];
    clear pool;
    
    cluster(ct - cnt, 1) = mini;
    cluster(ct - cnt, 2) = minj;
    cluster(ct - cnt, 3) = MIN;
    remove(chut) = mini;
    remove(chut+1) = minj;
    chut = chut + 2;
    for j = 1:ct-1
       if(not(any(remove == j)))
          pool(1:(w(ct) + w(j)), 1:19) = 0;
          pool(1:w(ct), :) = xsel{ct};
          pool((w(ct)+1):(w(ct) + w(j)), :) = xsel{j};
          gmm = fitgmdist(pool, K, 'CovarianceType', 'diagonal', 'SharedCovariance', true, 'Options', statset('MaxIter', ITR));
          dist = gmm.BIC;
          clear pool;
          M(j, ct) = dist; 
       end
    end
    M(ct, ct) = 0;
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

save(append(fname, '_gmm.mat'));