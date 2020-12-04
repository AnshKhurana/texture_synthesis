function [] = show_syn_singular(t_path, t_name,  B, res, vis, savedir)
figure;
ti = im2double(imread(t_path, 'png'));
% [X, map] = imread(t_path, 'png');
% ti = ind2rgb(X, map);

subplot(1, 3, 1, 'position', [0.2, 0.5, 0.1, 0.1]);
imshow(ti);
title('Texture Image');
subplot(1, 3, 2);
imshow(res);
title('Synthesized Image');
subplot(1, 3, 3);
imshow(vis);
title('Min. Error Boundary');
% sgtitle('Input Images');
saveas(gcf, fullfile(savedir, sprintf('result_%s_B_%d.png', t_name, B)));   
end