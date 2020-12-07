function [] = show_syn_comparison(t_name, B_choices, B_res, savedir)
    figure;
    num_b = length(B_choices);
    for Bi = 1:num_b
        subplot(1, num_b, Bi);
        imshow(squeeze(B_res(Bi, :, :, :))); truesize;
        title(sprintf('B=%d', B_choices(Bi)));
    end
%     sgtitle(sprintf('Texture %s transferred to %s\n params: Iterations=%d B decay rate=%f', t_name, c_name, num_passes, B_decay_rate));
    saveas(gcf, fullfile(savedir, sprintf('comparion_%s.png', t_name)));
end

