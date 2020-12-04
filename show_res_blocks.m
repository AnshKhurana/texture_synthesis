function [] = show_res_blocks(B_res, t_name, c_name, num_passes, B_choices, B_decay_rate, savedir)
    figure;
    num_b = length(B_choices);
    for Bi = 1:num_b
        subplot(1, num_b, Bi);
        imshow(squeeze(B_res(Bi, :, :, :)));
        title(sprintf('B=%d', B_choices(Bi)));
    end
%     sgtitle(sprintf('Texture %s transferred to %s\n params: Iterations=%d B decay rate=%f', t_name, c_name, num_passes, B_decay_rate));
saveas(gcf, fullfile(savedir, sprintf('res_%s_%s_bdr_%f_iter_%d.png', t_name, c_name, B_decay_rate, num_passes)));
end

