%idxsel
%idxwosel
%fname = 'LDC_20011116-1500';
fd = fopen(append(fname,'_out_gmm_10.txt'), "w");

for i = 1:Nl+1
    %count(1:lno) = 0;
    len = 400;
    %for j = 1:len
    %    count(idxsel(i + j - 1)) = count(idxsel(i + j - 1)) + 1;
    %end
    %[m, chut] = max(count);
    for j = 1:10:w(i)
        start = num2str(selp(len*(i-1) + j)/100, 6);
        off = num2str(0.1, 6);
        id = num2str(alloc(i));
        fprintf(fd, append('SPEAKER ', fname, ' 1 ', start, ' ', off, ' <NA> <NA> p', id, ' <NA>\n' ));
    end
end

fclose(fd);