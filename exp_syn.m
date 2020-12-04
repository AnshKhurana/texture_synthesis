% Aman Kansal, Ansh Khurana, Kushagra Juneja
clc; clear; close all;
warning('off', 'all');

data_path = 'data/';
results_dir = 'results/syn/';
texture_images = {'rice', 'fabric'};
% texture_images = {'jute', 'apples'};

B_choices=[20, 30, 40, 50];
for ti = texture_images
    t_path = fullfile(data_path, ti{1});
    for Bi = 1:length(B_choices)
        [res, vis] = synthesis(t_path, B_choices(Bi));
        show_syn_singular(t_path, ti{1}, B_choices(Bi), res, vis, results_dir);
        imwrite(res, fullfile(results_dir, sprintf('out_%s_B_%d.png', ti{1}, B_choices(Bi))));
    end
end