%% Ablation Studies for Texture Transfer
% Aman Kansal, Ansh Khurana, Kushagra Juneja

clc; clear; close all;
warning('off', 'all');

data_path = 'data/';
results_dir = 'results/iters/';
texture_images = {'rice'};
content_images =  {'girl'};


% show optimal results over iterations
B=20;
B_decay_rate = 0.8;
num_passes=5;
for ti = texture_images
    for ci = content_images
        t_path = fullfile(data_path, ti{1});
        c_path = fullfile(data_path, ci{1});
        show_inputs(t_path, c_path, results_dir, ti{1}, ci{1});
        iter_res = transfer(t_path, c_path, B, B_decay_rate, num_passes);
        show_res_iter(iter_res, ti{1}, ci{1}, num_passes, B, B_decay_rate, results_dir);
    end
end
