function [] = show_res_iter(iter_res, t_name, c_name, num_passes, B, B_decay_rate, savedir)
    figure;
    for i = 1:num_passes
        subplot(1, num_passes, i);
        imshow(squeeze(iter_res(i, :, :, :)));
        title(sprintf('iter=%d', i));
    end
%     sgtitle(sprintf('Texture %s transferred to %s\n params: B=%d, B decay rate=%f', t_name, c_name, B, B_decay_rate));
saveas(gcf, fullfile(savedir, sprintf('res_%s_%s_b_%d_bdr_%f.png', t_name, c_name, B, B_decay_rate)));
end

