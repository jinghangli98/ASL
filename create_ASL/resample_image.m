function image_corr = resample_image(moving, trans_mat, rot_mat)

    center = eye(4);
    center(1:end-1, end) = floor(size(moving) / 2) - 0.5;
    A = center * trans_mat * rot_mat * inv(center);
    
   
    image_corr = imwarp(moving, inv(A));
    
end