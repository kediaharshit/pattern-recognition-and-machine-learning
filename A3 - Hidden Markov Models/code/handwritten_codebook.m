clear
clc
load ('handwritten.mat')

fileID = fopen('HW_seq_Train1.txt', 'w');
for n = 1:size(Train1, 2)
    l = size(Train1{n}, 1);
    for i = 1:l-1
        x = Train1{n}(i+1, :) - Train1{n}(i, :);
        y = x(2)/x(1);
        if(x(2) >= 0)
            if(y <= 1 && y >= 0) 
                fprintf(fileID, '%d ', 0);
            elseif(y >= -1 && y <= 0)
                fprintf(fileID, '%d ', 3);
            elseif(y > 1)
                fprintf(fileID, '%d ', 1);
            else
                fprintf(fileID, '%d ', 2);
            end
        else
            if(y <= 1 && y >= 0) 
                fprintf(fileID, '%d ', 4);
            elseif(y >= -1 && y <= 0)
                fprintf(fileID, '%d ', 7);
            elseif(y > 1)
                fprintf(fileID, '%d ', 5);
            else
                fprintf(fileID, '%d ', 6);
            end
        end
    end
        x = Train1{n}(l, :) - Train1{n}(l-1, :);
        y = x(2)/x(1);
        if(x(2) >= 0)
            if(y <= 1 && y >= 0) 
                fprintf(fileID, '%d ', 0);
            elseif(y >= -1 && y <= 0)
                fprintf(fileID, '%d ', 3);
            elseif(y > 1)
                fprintf(fileID, '%d ', 1);
            else
                fprintf(fileID, '%d ', 2);
            end
        else
            if(y <= 1 && y >= 0) 
                fprintf(fileID, '%d ', 4);
            elseif(y >= -1 && y <= 0)
                fprintf(fileID, '%d ', 7);
            elseif(y > 1)
                fprintf(fileID, '%d ', 5);
            else
                fprintf(fileID, '%d ', 6);
            end
        end
    fprintf(fileID, '\n');
end
fclose(fileID);

fileID = fopen('HW_seq_Dev1.txt', 'w');
for n = 1:size(Dev1, 2)
    l = size(Dev1{n}, 1);
    for i = 1:l-1
        x = Dev1{n}(i+1, :) - Dev1{n}(i, :);
        y = x(2)/x(1);
        if(x(2) >= 0)
            if(y <= 1 && y >= 0) 
                fprintf(fileID, '%d ', 0);
            elseif(y >= -1 && y <= 0)
                fprintf(fileID, '%d ', 3);
            elseif(y > 1)
                fprintf(fileID, '%d ', 1);
            else
                fprintf(fileID, '%d ', 2);
            end
        else
            if(y <= 1 && y >= 0) 
                fprintf(fileID, '%d ', 4);
            elseif(y >= -1 && y <= 0)
                fprintf(fileID, '%d ', 7);
            elseif(y > 1)
                fprintf(fileID, '%d ', 5);
            else
                fprintf(fileID, '%d ', 6);
            end
        end
    end
        x = Dev1{n}(l, :) - Dev1{n}(l-1, :);
        y = x(2)/x(1);
        if(x(2) >= 0)
            if(y <= 1 && y >= 0) 
                fprintf(fileID, '%d ', 0);
            elseif(y >= -1 && y <= 0)
                fprintf(fileID, '%d ', 3);
            elseif(y > 1)
                fprintf(fileID, '%d ', 1);
            else
                fprintf(fileID, '%d ', 2);
            end
        else
            if(y <= 1 && y >= 0) 
                fprintf(fileID, '%d ', 4);
            elseif(y >= -1 && y <= 0)
                fprintf(fileID, '%d ', 7);
            elseif(y > 1)
                fprintf(fileID, '%d ', 5);
            else
                fprintf(fileID, '%d ', 6);
            end
        end
    fprintf(fileID, '\n');
end
fclose(fileID);