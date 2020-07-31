belong(1:Nd, 1:5) = 0;
for c = 1:5
    for i = 1:Nd
        pt = dev(:, i, c); 
        p(1:5) = 0;

        for cls = 1:5
            for j=1:K
                p(cls) = p(cls) + Pi(j, cls)*mvnpdf(pt, Means(:,j,cls), Sigma(:, :, j, cls));
            end
        end
        [M, Idx] = max(p);
        belong(i, c) = Idx;
    end
end

class_count(1:5) = 0;
final (1:nd, 1:5) = 0;
for cls = 1:5
   count = 1;
   for i = 1:nd
      class_count(1:5) = 0;
      for j = 1:36
          class_count(belong(count, cls)) = class_count(belong(count, cls)) + 1; 
          count = count + 1;
      end
      
      [M, Idx] = max(class_count);
      final(i, cls) = Idx;
   end
end

CMatrix(1:5, 1:5) = 0;
for cls = 1:5
    for i = 1:nd
        CMatrix(final(i, cls), cls) = CMatrix(final(i,cls), cls) + 1;
    end
end