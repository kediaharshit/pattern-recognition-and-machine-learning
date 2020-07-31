clc
clear 

for i = 1:5
    X = readmatrix(sprintf('DG_%d.txt', i));
    X = X(:, 1:(size(X, 2) - 1));
    for j = 1:5
        Y = readmatrix(sprintf('DG_%d.txt', j));
        Y = Y(:, 1:(size(Y, 2) - 1));
        
        fileID = fopen(sprintf('DG_%d_%d.txt', i, j), 'w');
        
        states = size(X, 1)/2 + size(Y, 1)/2;
        fprintf(fileID, sprintf("states: %d\n", states));
        symbols = size(X, 2) - 1;
        fprintf(fileID, sprintf("symbols: %d\n", symbols));
        
        for n = 1:size(X, 1)-2
            for m = 1:size(X, 2)
                fprintf(fileID, '%f\t', X(n, m));
            end
            fprintf(fileID, '\n');
            if(mod(n, 2) == 0)
                fprintf(fileID, '\n');
            end
        end
        
        fprintf(fileID, '%f\t', 0.7);
        for m = 2:size(X, 2)
            fprintf(fileID, '%f\t', X(size(X, 1)-1, m));
        end
        fprintf(fileID, '\n');
        fprintf(fileID, '%f\t', 0.3);
        for m = 2:size(X, 2)
            fprintf(fileID, '%f\t', X(size(X, 1), m));
        end
        fprintf(fileID, '\n\n');
        
        for n = 1:size(Y, 1)
            for m = 1:size(Y, 2)
                fprintf(fileID, '%f\t', Y(n, m));
            end
            fprintf(fileID, '\n');
            if(mod(n, 2) == 0)
                fprintf(fileID, '\n');
            end
        end
        
        fclose(fileID);
    end
end

for i = 1:5
    X = readmatrix(sprintf('DG_%d.txt', i));
    X = X(:, 1:(size(X, 2) - 1));
    for j = 1:5
        Y = readmatrix(sprintf('DG_%d.txt', j));
        Y = Y(:, 1:(size(Y, 2) - 1));
        for k = 1:5
            Z = readmatrix(sprintf('DG_%d.txt', k));
            Z = Z(:, 1:(size(Z, 2) - 1));
            
            fileID = fopen(sprintf('DG_%d_%d_%d.txt', i, j, k), 'w');
        
            states = size(X, 1)/2 + size(Y, 1)/2 + size(Z, 1)/2;
            fprintf(fileID, sprintf("states: %d\n", states));
            symbols = size(X, 2) - 1;
            fprintf(fileID, sprintf("symbols: %d\n", symbols));

            for n = 1:size(X, 1)-2
                for m = 1:size(X, 2)
                    fprintf(fileID, '%f\t', X(n, m));
                end
                fprintf(fileID, '\n');
                if(mod(n, 2) == 0)
                    fprintf(fileID, '\n');
                end
            end

            fprintf(fileID, '%f\t', 0.7);
            for m = 2:size(X, 2)
                fprintf(fileID, '%f\t', X(size(X, 1)-1, m));
            end
            fprintf(fileID, '\n');
            fprintf(fileID, '%f\t', 0.3);
            for m = 2:size(X, 2)
                fprintf(fileID, '%f\t', X(size(X, 1), m));
            end
            fprintf(fileID, '\n\n');

            for n = 1:size(Y, 1)-2
                for m = 1:size(Y, 2)
                    fprintf(fileID, '%f\t', Y(n, m));
                end
                fprintf(fileID, '\n');
                if(mod(n, 2) == 0)
                    fprintf(fileID, '\n');
                end
            end
            
            fprintf(fileID, '%f\t', 0.7);
            for m = 2:size(Y, 2)
                fprintf(fileID, '%f\t', Y(size(Y, 1)-1, m));
            end
            fprintf(fileID, '\n');
            fprintf(fileID, '%f\t', 0.3);
            for m = 2:size(Y, 2)
                fprintf(fileID, '%f\t', Y(size(Y, 1), m));
            end
            fprintf(fileID, '\n\n');
            
            for n = 1:size(Z, 1)
                for m = 1:size(Z, 2)
                    fprintf(fileID, '%f\t', Z(n, m));
                end
                fprintf(fileID, '\n');
                if(mod(n, 2) == 0)
                    fprintf(fileID, '\n');
                end
            end

            fclose(fileID);
        end
    end
end