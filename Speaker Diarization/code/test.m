clc; clear;
x = readmatrix('CMU_20020319-1400.rttm.txt');
trainp = readmatrix('rt04dev/CMU_20020319-1400.txt');


%yp = y(1:10, :);
%z = linkage(yp);
%alp = cluster(z,6);
N = size(x,1);
Ntrain = size(trainp,1);
lno=0;
for i=1:N
    if (not(isnan(x(i,4))))
        lno = i;
        break;
    end    
end
lno = lno-1;
Ni = N-lno;
ivl(Ni, 2) = 0;
for i=1:Ni
    ivl(i, 1) = fix(x(lno+i, 4)*100);
    ivl(i, 2) = fix(x(lno+i, 5)*100) + ivl(i,1);
end

train = trainp(:, 1:19);
count(1:Ntrain) = 0;
for i=1:Ni
    count(ivl(i,1) : ivl(i,2)) = count(ivl(i,1) : ivl(i,2)) + 1;    
end

%sel
%selp
%wosel
%woselp
pos = 1;
wopos = 1;
for i=1:Ntrain
    if(count(i)==1)
       wosel(wopos, :) = train(i, :);
       woselp(wopos) = i;
       wopos = wopos+1;
    end
    
    if(count(i)>0)
       sel(pos, :) = train(i, :);
       selp(pos) = i;
       pos = pos+1;
    end
end

idxsel = kmeans(sel, lno);
idxwosel = kmeans(wosel, lno);
