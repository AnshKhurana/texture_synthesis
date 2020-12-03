% Aman Kansal, Ansh Khurana, Kushagra Juneja
clc; clear all; close all;
warning('off', 'all');

X = im2double(imread('data/fabric.png', 'png'));
T = im2double(imread('data/girl.png', 'png'));

if length(size(T)) == 2
    [n_rows,n_cols] = size(T);
    T_new = zeros(n_rows,n_cols,3);
    T_new(:,:,1) = T;
    T_new(:,:,2) = T;
    T_new(:,:,3) = T;
end

in_color = X;
T_color = T;

in = rgb2gray(in_color); % grayscale image for algorithm

if length(size(T)) ~= 2
    T = rgb2gray(T_color); % grayscale target for algorithm
end

[R, C] = size(in);
[T_R, T_C] = size(T);

B = 10; % block size
B_decay_rate = 0.75; %decay rate of B
tol = 0.2; % tolerance
rng('default'); % setting seed
num_passes = 5; % number of iterations
boundary_gaussian_variance = 1;

L = floor(B/3); % overlap length
out = zeros(T_R, T_C); % output gray image
out_color = zeros(T_R, T_C, 3); % output color image

for pass = 1:num_passes
    overlap_loss_weight = 0.8*(pass-1)/(num_passes-1)+0.1;

    for i=[1:floor((T_R-L)/B),(T_R-L)/B]
        for j=[1:floor((T_C-L)/B),(T_C-L)/B]

            mask = zeros(B+L, B+L);
            ref = out((i-1)*B+1:i*B+L, (j-1)*B+1:j*B+L); % reference patch
            ref_color = out_color((i-1)*B+1:i*B+L, (j-1)*B+1:j*B+L, :);
            target_ref = T((i-1)*B+1:i*B+L, (j-1)*B+1:j*B+L);

            if i==1 && j==1
                [patch, patch_color] = findPatch_advanced(in, in_color, mask, ref, tol, target_ref, overlap_loss_weight);
                out((i-1)*B+1:i*B+L, (j-1)*B+1:j*B+L) = patch;
                out_color((i-1)*B+1:i*B+L, (j-1)*B+1:j*B+L,:) = patch_color;

            else
                if i==1
                    mask(:,1:L) = 1;
                    [patch, patch_color] = findPatch_advanced(in, in_color, mask, ref, tol, target_ref, overlap_loss_weight);
                    errors = mask.*((ref-patch).^2);
                    errors = errors(:,1:L);
                    [cost, dir, boundary] = dp(errors);
                    boundary = [boundary zeros(B+L, B)];
                
                elseif j==1
                    mask(1:L, :) = 1;
                    [patch, patch_color] = findPatch_advanced(in, in_color, mask, ref, tol, target_ref, overlap_loss_weight);
                    errors = mask.*((ref-patch).^2);
                    errors = errors(1:L, :);
                    [cost, dir, boundary] = dp(errors.');
                    boundary = [boundary zeros(B+L, B)];
                    boundary = boundary.';
                
                else
                    mask(:,1:L) = 1;
                    mask(1:L, :) = 1;
                    [patch, patch_color] = findPatch_advanced(in, in_color, mask, ref, tol, target_ref, overlap_loss_weight);
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
                
                
                boundary = imgaussfilt(boundary,boundary_gaussian_variance);
                out((i-1)*B+1:i*B+L, (j-1)*B+1:j*B+L) = boundary.*ref + (1-boundary).*patch;
                boundary_3d = repmat(boundary,[1,1,3]);
                out_color((i-1)*B+1:i*B+L, (j-1)*B+1:j*B+L,:) = boundary_3d.*ref_color + (1-boundary_3d).*patch_color;
                
                
                
            end
        end
    end

    B = round(B*B_decay_rate);
    L = floor(B/3);
    T = out;

    figure; imshow(out_color); truesize;

end

figure; imshow(in_color); truesize;