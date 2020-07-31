clc;
clear;

fname = 'ICSI_20010322-1450';
ground = readmatrix(append(fname, '.rttm.txt'));
trainaux = readmatrix(append(fname, '.mfcc.txt'));

G = size(ground,1);
N = size(trainaux,1);
lno = 0;
for i= 1:G
    if (not(isnan(ground(i,4))))
        lno = i;
        break;
    end    
end
lno = lno - 1;
Ni = G - lno;
ivl(Ni, 2) = 0;
for i=1:Ni
    ivl(i, 1) = fix(ground(lno+i, 4)*100);
    ivl(i, 2) = fix(ground(lno+i, 5)*100) + ivl(i,1);
end

train = trainaux(:, 1:19);
count(1:N) = 0;
for i = 1:Ni
    count(ivl(i,1) : ivl(i,2)) = count(ivl(i,1) : ivl(i,2)) + 1;    
end

%sel
%selp
%wosel
%woselp
pos = 1;
wopos = 1;
for i=1:N
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

save(append(fname, '.mat'));
%idxsel = kmeans(sel, lno);
%idxwosel = kmeans(wosel, lno);