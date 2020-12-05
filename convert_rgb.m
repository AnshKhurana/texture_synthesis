function [] = convert_rgb(img_path, out_path)
[X, map] = imread(img_path);
ti = ind2rgb(X, map);
% ti = im2double(imread(img_path));
if (length(size(ti)) < 3)
    ti = repmat(ti, 1,1, 3);
end

imwrite(ti, out_path);
end