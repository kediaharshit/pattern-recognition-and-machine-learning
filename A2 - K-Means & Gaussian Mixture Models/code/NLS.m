clc
clear 

Train = readmatrix('train.txt');
Dev = readmatrix('dev.txt');

train = Train(1:end, 1:2);
train = train';
train_class = Train(1:end, 3:3);

dev = Dev(1:end, 1:2);
dev = dev';
dev_class = Dev(1:end, 3:3);

tmean1(1:2) = 0;
tmean2(1:2) = 0;
tmean3(1:2) = 0;

for i = 1:350
    tmean1(1) = tmean1(1) + train(1, i);
    tmean1(2) = tmean1(2) + train(2, i);
end
for i = 351:700
    tmean2(1) = tmean2(1) + train(1, i);
    tmean2(2) = tmean2(2) + train(2, i);
end
for i = 701:1050
    tmean3(1) = tmean3(1) + train(1, i);
    tmean3(2) = tmean3(2) + train(2, i);
end
tmean1 = tmean1/350;
tmean1 = tmean1';
tmean2 = tmean2/350;
tmean2 = tmean2';
tmean3 = tmean3/350;
tmean3 = tmean3';

tC1(1:2, 1:2) = 0;
tC2(1:2, 1:2) = 0;
tC3(1:2, 1:2) = 0;
tVar = 0;

for i = 1:350
    tC1 = tC1 + (train(1:2, i:i) - tmean1)*(train(1:2, i:i) - tmean1)';
    tVar = tVar + (train(1:2, i:i) - tmean1)'*(train(1:2, i:i) - tmean1);
end
for i = 351:700
    tC2 = tC2 + (train(1:2, i:i) - tmean2)*(train(1:2, i:i) - tmean2)';
    tVar = tVar + (train(1:2, i:i) - tmean2)'*(train(1:2, i:i) - tmean2);
end
for i = 701:1050
    tC3 = tC3 + (train(1:2, i:i) - tmean3)*(train(1:2, i:i) - tmean3)';
    tVar = tVar + (train(1:2, i:i) - tmean3)'*(train(1:2, i:i) - tmean3);
end
tC = tC1 + tC2 + tC3;
tC = tC/1050;
tC1 = tC1/350;
tC2 = tC2/350;
tC3 = tC3/350;
tNC = tC;
tNC(1,2) = 0;
tNC(2,1) = 0;
tNC1 = tC1;
tNC1(1,2) = 0;
tNC1(2,1) = 0;
tNC2 = tC2;
tNC2(1,2) = 0;
tNC2(2,1) = 0;
tNC3 = tC3;
tNC3(1,2) = 0;
tNC3(2,1) = 0;
tVar = tVar/2100;

% Gaussian PLots for three classes
x1 = 0:0.1:55;
x2 = 0:0.1:55;
[X1, X2] = meshgrid(x1, x2);
X = [X1(:) X2(:)];
y = mvnpdf(X, tmean1', tC1);
y = reshape(y, length(x2), length(x1));
surf(x1, x2, y, 'EdgeColor', 'none', 'FaceColor', 'g');
hold on;
y = mvnpdf(X, tmean2', tC2);
y = reshape(y, length(x2), length(x1));
surf(x1, x2, y, 'EdgeColor', 'none', 'FaceColor', 'm');
hold on;
y = mvnpdf(X, tmean3', tC3);
y = reshape(y, length(x2), length(x1));
surf(x1, x2, y, 'EdgeColor', 'none', 'FaceColor', 'b');
caxis([min(y(:))-0.5*range(y(:)),max(y(:))])
axis([0 55 0 55 0 0.01])
title(sprintf('PDF of Gaussians'))
xlabel('x1')
ylabel('x2')
zlabel('Probability Density')
legend({'class 1', 'class 2', 'class 3'}, 'Location', 'northeast');
box on;
[az, el] = view;
az = 354;
el = 36;
view (az, el);
hold off;
saveas(gca,sprintf('NLS_gaussians.jpg'));

% Case 1: Bayes with Covariance same for all classes
xrange = [0 55];
yrange = [0 55];
inc = 0.1;
[x, y] = meshgrid(xrange(1):inc:xrange(2), yrange(1):inc:yrange(2));
image_size = size(x);
xy = [x(:) y(:)];
xy = [reshape(x, image_size(1)*image_size(2),1) reshape(y, image_size(1)*image_size(2),1)];
idx(1:length(xy)) = 0;
for i = 1:length(xy)
    X = xy(i, 1);
    Y = xy(i, 2);
    
    temp = (tC\(tmean1 - tmean2))';
    Z1 = (temp(1) * (X - (tmean1(1)+tmean2(1))/2)) + (temp(2) * (Y - (tmean1(2)+tmean2(2))/2));
    
    temp = (tC\(tmean3 - tmean1))';
    Z2 = (temp(1) * (X - (tmean3(1)+tmean1(1))/2)) + (temp(2) * (Y - (tmean3(2)+tmean1(2))/2));
    
    temp = (tC\(tmean2 - tmean3))';
    Z3 = (temp(1) * (X - (tmean2(1)+tmean3(1))/2)) + (temp(2) * (Y - (tmean2(2)+tmean3(2))/2));
    
    if(Z1 > 0 && Z2 < 0)
        idx(i) = 1;
    end
    if(Z1 < 0 && Z3 > 0)
        idx(i) = 2;
    end
    if(Z2 > 0 && Z3 < 0)
        idx(i) = 3;
    end
end

decisionmap = reshape(idx, image_size);
%figure;
figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'all');
imagesc(xrange,yrange,decisionmap);
hold on;
set(gca,'ydir','normal');
cmap = [1 0.4 0.4; 0 0.7 0; 1 1 0.5];

colormap(cmap);

h(1) = scatter(train(1:1, 1:350), train(2:2, 1:350), 5, 'filled', 'g');
h(2) = scatter(train(1:1, 351:700), train(2:2, 351:700), 5, 'filled', 'd');
h(3) = scatter(train(1:1, 701:1050), train(2:2, 701:1050), 5, 'filled', 'sr');
hold on;
G = gmdistribution(tmean1', tC1);
f = @(x, y) pdf(G, [x y]);
h(5) = fcontour(f, [0 55 0 55], 'y');
hold on;
G = gmdistribution(tmean2', tC2);
f = @(x, y) pdf(G, [x y]);
h(4) = fcontour(f, [0 55 0 55], 'r');
hold on;
G = gmdistribution(tmean3', tC3);
f = @(x, y) pdf(G, [x y]);
h(6) = fcontour(f, [0 55 0 55], 'k');
title(sprintf('Case 1: Decision Boundaries and Decision Surfaces'))
xlabel('x1');
ylabel('x2');
legend(h(1:3), {'class 1', 'class 2', 'class 3'}, 'Location', 'southeast');
hold off;
saveas(figure1,sprintf('NLS_case_1.jpg'));

% Case 2: Bayes with Covariance different for all classes
xrange = [0 55];
yrange = [0 55];
inc = 0.1;
[x, y] = meshgrid(xrange(1):inc:xrange(2), yrange(1):inc:yrange(2));
image_size = size(x);
xy = [x(:) y(:)];
xy = [reshape(x, image_size(1)*image_size(2),1) reshape(y, image_size(1)*image_size(2),1)];
idx(1:length(xy)) = 0;
for i = 1:length(xy)
    X = xy(i, 1);
    Y = xy(i, 2);
    
    W = -0.5 * (inv(tC1) - inv(tC2));
    temp = (tC1\tmean1 - tC2\tmean2)';
    Z = X*X*W(1,1) + X*Y*(W(1,2) + W(2,1)) + Y*Y*W(2,2);
    C = 0.5 * (tmean2'*(tC2\tmean2) - tmean1'*(tC1\tmean1) - log(abs(det(tC1))/abs(det(tC2))));
    Z1 = Z + (temp(1) * X) + (temp(2) * Y) + C;
    
    W = -0.5 * (inv(tC3) - inv(tC1));
    temp = (tC3\tmean3 - tC1\tmean1)';
    Z = X*X*W(1,1) + X*Y*(W(1,2) + W(2,1)) + Y*Y*W(2,2);
    C = 0.5 * (tmean1'*(tC1\tmean1) - tmean3'*(tC3\tmean3) - log(abs(det(tC3))/abs(det(tC1))));
    Z2 = Z + (temp(1) * X) + (temp(2) * Y) + C;
    
    W = -0.5 * (inv(tC2) - inv(tC3));
    temp = (tC2\tmean2 - tC3\tmean3)';
    Z = X*X*W(1,1) + X*Y*(W(1,2) + W(2,1)) + Y*Y*W(2,2);
    C = 0.5 * (tmean3'*(tC3\tmean3) - tmean2'*(tC2\tmean2) - log(abs(det(tC2))/abs(det(tC3))));
    Z3 = Z + (temp(1) * X) + (temp(2) * Y) + C;
    
    if(Z1 > 0 && Z2 < 0)
        idx(i) = 1;
    end
    if(Z1 < 0 && Z3 > 0)
        idx(i) = 2;
    end
    if(Z2 > 0 && Z3 < 0)
        idx(i) = 3;
    end
end

decisionmap = reshape(idx, image_size);
%figure;
figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'all');
imagesc(xrange,yrange,decisionmap);
hold on;
set(gca,'ydir','normal');
cmap = [1 0.4 0.4; 0 0.7 0; 1 1 0.5];

colormap(cmap);

h(1) = scatter(train(1:1, 1:350), train(2:2, 1:350), 5, 'filled', 'g');
h(2) = scatter(train(1:1, 351:700), train(2:2, 351:700), 5, 'filled', 'd');
h(3) = scatter(train(1:1, 701:1050), train(2:2, 701:1050), 5, 'filled', 'sr');
hold on;
G = gmdistribution(tmean1', tC1);
f = @(x, y) pdf(G, [x y]);
h(5) = fcontour(f, [0 55 0 55], 'y');
hold on;
G = gmdistribution(tmean2', tC2);
f = @(x, y) pdf(G, [x y]);
h(4) = fcontour(f, [0 55 0 55], 'r');
hold on;
G = gmdistribution(tmean3', tC3);
f = @(x, y) pdf(G, [x y]);
h(6) = fcontour(f, [0 55 0 55], 'k');
title(sprintf('Case 2: Decision Boundaries and Decision Surfaces'))
xlabel('x1');
ylabel('x2');
legend(h(1:3), {'class 1', 'class 2', 'class 3'}, 'Location', 'southeast');
hold off;
saveas(figure1,sprintf('NLS_case_2.jpg'));

% Case 3: Naive Bayes with Sigma Square I
xrange = [0 55];
yrange = [0 55];
inc = 0.1;
[x, y] = meshgrid(xrange(1):inc:xrange(2), yrange(1):inc:yrange(2));
image_size = size(x);
xy = [x(:) y(:)];
xy = [reshape(x, image_size(1)*image_size(2),1) reshape(y, image_size(1)*image_size(2),1)];
idx(1:length(xy)) = 0;
for i = 1:length(xy)
    X = xy(i, 1);
    Y = xy(i, 2);
    
    temp = ((tmean1 - tmean2)/tVar)';
    Z1 = (temp(1) * (X - (tmean1(1)+tmean2(1))/2)) + (temp(2) * (Y - (tmean1(2)+tmean2(2))/2));
    
    temp = ((tmean3 - tmean1)/tVar)';
    Z2 = (temp(1) * (X - (tmean3(1)+tmean1(1))/2)) + (temp(2) * (Y - (tmean3(2)+tmean1(2))/2));
    
    temp = ((tmean2 - tmean3)/tVar)';
    Z3 = (temp(1) * (X - (tmean2(1)+tmean3(1))/2)) + (temp(2) * (Y - (tmean2(2)+tmean3(2))/2));
    
    if(Z1 > 0 && Z2 < 0)
        idx(i) = 1;
    end
    if(Z1 < 0 && Z3 > 0)
        idx(i) = 2;
    end
    if(Z2 > 0 && Z3 < 0)
        idx(i) = 3;
    end
end

decisionmap = reshape(idx, image_size);
%figure;
figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'all');
imagesc(xrange,yrange,decisionmap);
hold on;
set(gca,'ydir','normal');
cmap = [1 0.4 0.4; 0 0.7 0; 1 1 0.5];

colormap(cmap);

h(1) = scatter(train(1:1, 1:350), train(2:2, 1:350), 5, 'filled', 'g');
h(2) = scatter(train(1:1, 351:700), train(2:2, 351:700), 5, 'filled', 'd');
h(3) = scatter(train(1:1, 701:1050), train(2:2, 701:1050), 5, 'filled', 'sr');
hold on;
G = gmdistribution(tmean1', tC1);
f = @(x, y) pdf(G, [x y]);
h(5) = fcontour(f, [0 55 0 55], 'y');
hold on;
G = gmdistribution(tmean2', tC2);
f = @(x, y) pdf(G, [x y]);
h(4) = fcontour(f, [0 55 0 55], 'r');
hold on;
G = gmdistribution(tmean3', tC3);
f = @(x, y) pdf(G, [x y]);
h(6) = fcontour(f, [0 55 0 55], 'k');
title(sprintf('Case 3: Decision Boundaries and Decision Surfaces'))
xlabel('x1');
ylabel('x2');
legend(h(1:3), {'class 1', 'class 2', 'class 3'}, 'Location', 'southeast');
hold off;
saveas(figure1,sprintf('NLS_case_3.jpg'));

% Case 4: Naive Bayes with C same for all classes
xrange = [0 55];
yrange = [0 55];
inc = 0.1;
[x, y] = meshgrid(xrange(1):inc:xrange(2), yrange(1):inc:yrange(2));
image_size = size(x);
xy = [x(:) y(:)];
xy = [reshape(x, image_size(1)*image_size(2),1) reshape(y, image_size(1)*image_size(2),1)];
idx(1:length(xy)) = 0;
for i = 1:length(xy)
    X = xy(i, 1);
    Y = xy(i, 2);
    
    temp = (tNC\(tmean1 - tmean2))';
    Z1 = (temp(1) * (X - (tmean1(1)+tmean2(1))/2)) + (temp(2) * (Y - (tmean1(2)+tmean2(2))/2));
    
    temp = (tNC\(tmean3 - tmean1))';
    Z2 = (temp(1) * (X - (tmean3(1)+tmean1(1))/2)) + (temp(2) * (Y - (tmean3(2)+tmean1(2))/2));
    
    temp = (tNC\(tmean2 - tmean3))';
    Z3 = (temp(1) * (X - (tmean2(1)+tmean3(1))/2)) + (temp(2) * (Y - (tmean2(2)+tmean3(2))/2));
    
    if(Z1 > 0 && Z2 < 0)
        idx(i) = 1;
    end
    if(Z1 < 0 && Z3 > 0)
        idx(i) = 2;
    end
    if(Z2 > 0 && Z3 < 0)
        idx(i) = 3;
    end
end

decisionmap = reshape(idx, image_size);
%figure;
figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'all');
imagesc(xrange,yrange,decisionmap);
hold on;
set(gca,'ydir','normal');
cmap = [1 0.4 0.4; 0 0.7 0; 1 1 0.5];

colormap(cmap);

h(1) = scatter(train(1:1, 1:350), train(2:2, 1:350), 5, 'filled', 'g');
h(2) = scatter(train(1:1, 351:700), train(2:2, 351:700), 5, 'filled', 'd');
h(3) = scatter(train(1:1, 701:1050), train(2:2, 701:1050), 5, 'filled', 'sr');
hold on;
G = gmdistribution(tmean1', tC1);
f = @(x, y) pdf(G, [x y]);
h(5) = fcontour(f, [0 55 0 55], 'y');
hold on;
G = gmdistribution(tmean2', tC2);
f = @(x, y) pdf(G, [x y]);
h(4) = fcontour(f, [0 55 0 55], 'r');
hold on;
G = gmdistribution(tmean3', tC3);
f = @(x, y) pdf(G, [x y]);
h(6) = fcontour(f, [0 55 0 55], 'k');
title(sprintf('Case 4: Decision Boundaries and Decision Surfaces'))
xlabel('x1');
ylabel('x2');
legend(h(1:3), {'class 1', 'class 2', 'class 3'}, 'Location', 'southeast');
hold off;
saveas(figure1,sprintf('NLS_case_4.jpg'));

% Case 5: Naive Bayes with C different for all classes
xrange = [0 55];
yrange = [0 55];
inc = 0.1;
[x, y] = meshgrid(xrange(1):inc:xrange(2), yrange(1):inc:yrange(2));
image_size = size(x);
xy = [x(:) y(:)];
xy = [reshape(x, image_size(1)*image_size(2),1) reshape(y, image_size(1)*image_size(2),1)];
idx(1:length(xy)) = 0;
for i = 1:length(xy)
    X = xy(i, 1);
    Y = xy(i, 2);
    
    W = -0.5 * (inv(tNC1) - inv(tNC2));
    temp = (tNC1\tmean1 - tNC2\tmean2)';
    Z = X*X*W(1,1) + X*Y*(W(1,2) + W(2,1)) + Y*Y*W(2,2);
    C = 0.5 * (tmean2'*(tNC2\tmean2) - tmean1'*(tNC1\tmean1) - log(abs(det(tNC1))/abs(det(tNC2))));
    Z1 = Z + (temp(1) * X) + (temp(2) * Y) + C;
    
    W = -0.5 * (inv(tNC3) - inv(tNC1));
    temp = (tNC3\tmean3 - tNC1\tmean1)';
    Z = X*X*W(1,1) + X*Y*(W(1,2) + W(2,1)) + Y*Y*W(2,2);
    C = 0.5 * (tmean1'*(tNC1\tmean1) - tmean3'*(tNC3\tmean3) - log(abs(det(tNC3))/abs(det(tNC1))));
    Z2 = Z + (temp(1) * X) + (temp(2) * Y) + C;
    
    W = -0.5 * (inv(tNC2) - inv(tNC3));
    temp = (tNC2\tmean2 - tNC3\tmean3)';
    Z = X*X*W(1,1) + X*Y*(W(1,2) + W(2,1)) + Y*Y*W(2,2);
    C = 0.5 * (tmean3'*(tNC3\tmean3) - tmean2'*(tNC2\tmean2) - log(abs(det(tNC2))/abs(det(tNC3))));
    Z3 = Z + (temp(1) * X) + (temp(2) * Y) + C;
    
    if(Z1 > 0 && Z2 < 0)
        idx(i) = 1;
    end
    if(Z1 < 0 && Z3 > 0)
        idx(i) = 2;
    end
    if(Z2 > 0 && Z3 < 0)
        idx(i) = 3;
    end
end

decisionmap = reshape(idx, image_size);
%figure;
figure1 = figure;
axes1 = axes('Parent',figure1);
hold(axes1,'all');
imagesc(xrange,yrange,decisionmap);
hold on;
set(gca,'ydir','normal');
cmap = [1 0.4 0.4; 0 0.7 0; 1 1 0.5];

colormap(cmap);

h(1) = scatter(train(1:1, 1:350), train(2:2, 1:350), 5, 'filled', 'g');
h(2) = scatter(train(1:1, 351:700), train(2:2, 351:700), 5, 'filled', 'd');
h(3) = scatter(train(1:1, 701:1050), train(2:2, 701:1050), 5, 'filled', 'sr');
hold on;
G = gmdistribution(tmean1', tC1);
f = @(x, y) pdf(G, [x y]);
h(5) = fcontour(f, [0 55 0 55], 'y');
hold on;
G = gmdistribution(tmean2', tC2);
f = @(x, y) pdf(G, [x y]);
h(4) = fcontour(f, [0 55 0 55], 'r');
hold on;
G = gmdistribution(tmean3', tC3);
f = @(x, y) pdf(G, [x y]);
h(6) = fcontour(f, [0 55 0 55], 'k');
title(sprintf('Case 5: Decision Boundaries and Decision Surfaces'))
xlabel('x1');
ylabel('x2');
legend(h(1:3), {'class 1', 'class 2', 'class 3'}, 'Location', 'southeast');
hold off;
saveas(figure1,sprintf('NLS_case_5.jpg'));