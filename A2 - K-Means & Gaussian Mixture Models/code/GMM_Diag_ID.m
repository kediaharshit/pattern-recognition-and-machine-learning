%K-Means
K =10;
d = 23;
Nk(1:K, 1:5) = 0;
Means(1:d, 1:K, 1:5) = 0;
r(1:N, 1:K, 1:5) = 0;
dist(K) = 0;

for cls = 1:5
    for i = 1:K
        Means(:, i, cls) = train(: ,randi(N), cls);
    end

    for itr = 1:10
        for i = 1:N
            for j = 1:K
                r(i, j, cls) = 0;
            end
        end
        for i = 1:N
            for j = 1:K
                dist(j) = (train( :, i, cls) - Means(:, j, cls))' * (train(:, i, cls) - Means(:, j, cls)); 
            end
            [m, id] = min(dist);
            r(i, id, cls) = 1;
        end
        for i = 1:K
            Means(:, i, cls) = 0;
            count = 0;
            for j = 1:N
                Means(:, i, cls) = Means(:, i, cls) + (r( j, i, cls) * train(:, j, cls));
                count = count + r(j, i, cls);
            end
            Nk(i, cls) = count;
            Means(:, i, cls) = Means( :, i, cls)/count;
        end
    end   
end

% GMM
Sigma(1:23, 1:23, 1:K, 1:5) = 0;
Pi(1:K, 1:5) = 0;
for cls = 1:5
    for i = 1:K
        count = 0;
        temp(1:23, 1:23) = 0;
        for j = 1:N
            temp = temp + r(j, i, cls) * ((train(:, j, cls) - Means(:, i, cls)) * (train( :, j, cls) - Means(:, i, cls))');
            count = count + r( j, i, cls);
        end
        temp = temp/count;
        d = diag(temp);
        temp = diag(d);
        Sigma( :, :, i, cls) = temp(:, :);
        Pi(i, cls) = count/N;
    end

    for itr = 1:10

        for i = 1:N
            llhood = 0;
            for j = 1:K
                x = train(:, i, cls);
                mu = Means(:, j, cls);
                var = Sigma( :, :, j, cls);
                llhood = llhood + (Pi(j, cls)* mvnpdf(x, mu, var));
            end
            for j = 1:K
                x = train(:, i, cls);
                mu = Means(:, j, cls);
                var = Sigma( :, :, j, cls);
                r(i, j, cls) = (Pi(j, cls) * mvnpdf(x, mu, var))/llhood;
            end
        end
        for i = 1:K
            Means(:, i, cls) = 0;
            count = 0;
            for j = 1:N
                Means(:, i, cls) = Means(:, i, cls) + (r(j, i, cls) * train( :, j, cls));
                count = count + r(j, i, cls);
            end
            Nk(i) = count;
            Means(:, i, cls) = Means( :, i, cls)/count;
        end
        for i = 1:K
            Sigma( :, :, i, cls) = 0;
            count = 0;
            temp(1:23, 1:23) = 0;
            for j = 1:N
                temp = temp + r(j, i, cls) * (train(:, j, cls) - Means(:, i, cls)) * (train( :, j, cls) - Means( :, i, cls))';
                count = count + r(j, i, cls);
            end
            temp = temp/count;
            d = diag(temp);
            temp = diag(d);
            Sigma(:, :, i, cls) = temp(:, :);
            Pi(i, cls) = count/N;
        end
    end
end
