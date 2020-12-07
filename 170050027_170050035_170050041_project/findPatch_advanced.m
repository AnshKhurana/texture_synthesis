function [patch, patch_color] = findPatch_advanced(im, im_color, mask, ref, tol, target_ref, overlap_loss_weight)
    ref = ref.*mask;
    im_square = im.*im;

    t1 = filter2(mask, im_square, 'valid');
    t2 = 2*filter2(ref, im, 'valid');
    t0 = ref.*ref;
    t0 = sum(t0(:));
    SSE1 = t0 + t1 - t2; % sum of squared errors

    t3 = target_ref.*target_ref;
    t3 = sum(t3(:));
    t4 = 2*filter2(target_ref,im,'valid');
    t5 = filter2(ones(size(mask)),im_square,'valid');
    SSE2 = t3 - t4 + t5;

    SSE = overlap_loss_weight*SSE1 + (1-overlap_loss_weight)*SSE2;

    EPS = 1e-6;
    min_error = min(SSE(:))+EPS;
    [row, col] = find(SSE<=(1+tol)*min_error);
    len = size(row,1);
    i = randi([1 len]);
    [r,c] = size(mask);
    patch = im(row(i):r+row(i)-1, col(i):c+col(i)-1);
    patch_color = im_color(row(i):r+row(i)-1, col(i):c+col(i)-1, :);
end