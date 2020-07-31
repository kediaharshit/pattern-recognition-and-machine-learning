% cluster arry has encoded tree
clc;
clear;
fname = 'NIST_20030623-1409';
load(append(fname, '_gmm.mat'));

Nl = size(cluster,1);
clust(1:lno) = 0;
elem = Nl;
i = 1;
j = 1;
unassigned = [];
while(i < lno)
    clust(:) = circshift(clust(:), -1);
    clust(lno)= 0;
    if(cluster(elem,1) > Nl + 1)
       clust(i) = cluster(elem,1);
       i = i + 1;
    else
       unassigned(j) = cluster(elem,1);
       j = j + 1;
    end
    if(cluster(elem,2) > Nl + 1)
       clust(i) = cluster(elem,2);
       i = i + 1;
    else
       unassigned(j) = cluster(elem,2);
       j = j + 1;
    end
    i = i - 1;
    clust = sort(clust, 'descend');
    elem = clust(1) - Nl-1;
end

alloc(1:int32((pos-1)/400)) = 0;
import java.util.LinkedList;
q = LinkedList();
for i = 1:lno
    q.clear();
    q.add(clust(i));
    while(not(q.isEmpty()))
        a = q.remove();
        %disp(a);
        if(a <= Nl+1)
            alloc(a) = i;
        else
            q.add(cluster(a-Nl-1,1));
            q.add(cluster(a-Nl-1,2));
        end
    end
end

for i = 1:size(unassigned,2)
    assign(lno) = 0;
    for j = 1:lno
        assign(j) = norm(msel(clust(j), :) - msel(i, :));
    end
    [m, id] = min(assign);
    alloc(unassigned(i)) = id;
end
%cutoff = median([cluster(end-1,3) cluster(end-0,3)]);
%dendrogram(cluster,'ColorThreshold',cutoff)