%% Ablation Studies for Texture Transfer
% Aman Kansal, Ansh Khurana, Kushagra Juneja

clc; clear; close all;
warning('off', 'all');
tic;
data_path = 'data/';
results_dir = 'results/bsize/';
texture_images = {'text'};
content_images =  {'girl'};


% show optimal results over iterations
B_choices=[10,20,30,40];
B_decay_rate_choices = [0.9, 0.8];
num_passes=5;
for ti = texture_images
    for ci = content_images
        t_path = fullfile(data_path, ti{1});
        c_path = fullfile(data_path, ci{1});
        T = im2double(imread(c_path, 'png'));
        tsize = size(T);
        show_inputs(t_path, c_path, results_dir, ti{1}, ci{1});
        for B_dr = B_decay_rate_choices
            B_res = zeros(length(B_choices), tsize(1), tsize(2), 3);
            for Bi = 1:length(B_choices)
                iter_res = transfer(t_path, c_path, B_choices(Bi), B_dr, num_passes);
                res = squeeze(iter_res(num_passes, :, :, :));
                imwrite(res, fullfile(results_dir, sprintf('out_%s_%s_B_%d_bdr_%f.png', ti{1}, ci{1}, B_choices(Bi), B_dr)));
                B_res(Bi, :, :, :) = res;  
            end
            show_res_blocks(B_res, ti{1}, ci{1}, num_passes, B_choices, B_dr, results_dir);
        end
    end
end
toc;