% Aman Kansal, Ansh Khurana, Kushagra Juneja
clc; clear; close all;
warning('off', 'all');

data_path = 'data/';
results_dir = 'results/syn_final/';
% texture_images = {'rice', 'jute_c', 'apples_c', 'wood_c', ...
%     'jute_c', 'fabric', 'radishes', 'D1', 'brick_bw', 'text', 'cans'};

texture_images = {'tile', 'brick', 'br_pattern', 'rope', 'stone'};

B = 60;
for ti = texture_images
    t_path = fullfile(data_path, ti{1});
    [res, vis] = synthesis(t_path, B);
    show_best_syn(t_path, ti{1}, B, res, results_dir);
%     imwrite(res, fullfile(results_dir, sprintf('out_%s_B_%d.png', ti{1}, B_choices(Bi))));
end
