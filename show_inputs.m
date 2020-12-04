function [] = show_inputs(t_path, c_path, savedir, t_name, c_name)
figure;
ti = im2double(imread(t_path, 'png'));
ci = im2double(imread(c_path, 'png'));
subplot(1, 2, 1);
imshow(ti);
title('Texture Image');
subplot(1, 2, 2);
imshow(ci);
title('Content Image');
% sgtitle('Input Images');
saveas(gcf, fullfile(savedir, sprintf('inp_%s_%s.png', t_name, c_name)));   
end