% Aman Kansal, Ansh Khurana, Kushagra Juneja
clc; clear all; close all;
warning('off', 'all');

[X, map] = imread("apples.png", 'png');
in_color = ind2rgb(X, map);

in = rgb2gray(in_color); % grayscale image for algorithm
[R, C] = size(in);
B = 40; % block size
tol = 0.2; % tolerance
rng('default'); % setting seed

L = floor(B/3); % overlap length
r = 2*floor(R/B); % no. of blocks in x
c = 2*floor(C/B); % no. of blocks in y 
out = zeros(r*B+L, c*B+L); % output gray image
out_color = zeros(r*B+L, c*B+L, 3); % output color image

for i=1:r
    for j=1:c
        
        if i==1 && j==1
            out((i-1)*B+1:i*B+L, (j-1)*B+1:j*B+L) = in(1:B+L, 1:B+L);
            out_color((i-1)*B+1:i*B+L, (j-1)*B+1:j*B+L,:) = in_color(1:B+L, 1:B+L,:);
        else
            mask = zeros(B+L, B+L);
            ref = out((i-1)*B+1:i*B+L, (j-1)*B+1:j*B+L); % reference patch
            ref_color = out_color((i-1)*B+1:i*B+L, (j-1)*B+1:j*B+L, :);
            
            if i==1
                mask(:,1:L) = 1;
                [patch, patch_color] = findPatch(in, in_color, mask, ref, tol);
                errors = mask.*((ref-patch).^2);
                errors = errors(:,1:L);
                [cost, dir, boundary] = dp(errors);
                boundary = [boundary zeros(B+L, B)];
            
            elseif j==1
                mask(1:L, :) = 1;
                [patch, patch_color] = findPatch(in, in_color, mask, ref, tol);
                errors = mask.*((ref-patch).^2);
                errors = errors(1:L, :);
                [cost, dir, boundary] = dp(errors.');
                boundary = [boundary zeros(B+L, B)];
                boundary = boundary.';
            
            else
                mask(:,1:L) = 1;
                mask(1:L, :) = 1;
                [patch, patch_color] = findPatch(in, in_color, mask, ref, tol);
                errors = mask.*((ref-patch).^2);
                
                errors_h = errors(:,1:L);
                [cost, dir, boundary_h] = dp(errors_h);
                boundary_h = [boundary_h zeros(B+L, B)];
                
                errors_v = errors(1:L, :);
                [cost, dir, boundary_v] = dp(errors_v.');
                boundary_v = [boundary_v zeros(B+L, B)];
                boundary_v = boundary_v.';
                
                boundary = min(boundary_h + boundary_v, 1);
            end
            
            
            
            out((i-1)*B+1:i*B+L, (j-1)*B+1:j*B+L) = boundary.*ref + (1-boundary).*patch;
            out_color((i-1)*B+1:i*B+L, (j-1)*B+1:j*B+L,:) = boundary.*ref_color + (1-boundary).*patch_color;
            
            
            
        end
    end
end

figure; imshow(in_color); truesize;
figure; imshow(out_color); truesize;