function ret = DTW(X, Y)
    m = size(X, 1);
    n = size(Y, 1);
    dtw(1:m+1, 1:n+1) = 0;
    for i = 2:m+1
        dtw(i, 1) = Inf;
    end
    for j = 2:n+1
        dtw(1, j) = Inf;
    end
    for i = 2:m+1
        for j = 2:n+1
            cost = norm(X(i-1, :) - Y(j-1, :));
            dtw(i, j) = min([dtw(i-1, j-1) dtw(i-1, j) dtw(i, j-1)]) + cost;
        end
    end
    ret = dtw(m+1, n+1);
end