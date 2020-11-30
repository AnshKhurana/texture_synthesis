function [cost, dir, boundary] = dp(errors)
    cost = zeros(size(errors));
    dir = zeros(size(errors));
    [r, c] = size(errors);
    cost(r, :) = errors(r, :);
    for i=r-1:-1:1
        options = cat(1, [inf cost(i+1,1:c-1)], cost(i+1, :), [cost(i+1, 2:c) inf]);
        [cost(i, :), I] = min(options, [], 1);
        cost(i, :) = cost(i, :) + errors(i,:);
        dir(i, :) = I-2;
    end
    boundary = zeros(size(errors));
    [~, id] = min(cost(1,:));
    for i=1:r
       boundary(i, 1:id) = 1;
       id = id + dir(i, id);
    end
end