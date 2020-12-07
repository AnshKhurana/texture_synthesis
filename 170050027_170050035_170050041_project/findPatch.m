function [patch, patch_color] = findPatch(im, im_color, mask, ref, tol)
    ref = ref.*mask;
    t1 = filter2(mask, im.*im, 'valid');
    t2 = 2*filter2(ref, im, 'valid');
    t0 = ref.*ref;
    t0 = sum(t0(:));
    SSE = t0 + t1 - t2; % sum of squared errors
    EPS = 1e-6;
    min_error = min(SSE(:))+EPS;
    [row, col] = find(SSE<=(1+tol)*min_error);
    len = size(row,1);
    i = randi([1 len]);
    [r,c] = size(mask);
    patch = im(row(i):r+row(i)-1, col(i):c+col(i)-1);
    patch_color = im_color(row(i):r+row(i)-1, col(i):c+col(i)-1, :);
end