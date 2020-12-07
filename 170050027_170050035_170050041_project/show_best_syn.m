function [] = show_best_syn(t_path, t_name,  B, res, savedir)
figure;
ti = im2double(imread(t_path, 'png'));
% [X, map] = imread(t_path, 'png');
% ti = ind2rgb(X, map);

subplot(1, 2, 1, 'position', [0.25, 0.5, 0.1, 0.1]);
imshow(ti);
title('Texture Image');
subplot(1, 2, 2, 'position', [0.37, 0.5, 0.2, 0.2]);
imshow(res);
title('Synthesized Image');
% sgtitle('Input Images');
saveas(gcf, fullfile(savedir, sprintf('result_%s_B_%d.png', t_name, B)));   
end