function trans_mat = get_translation_matrix(x, y, z)
  
    trans_mat = eye(4);
    trans_mat(:, end) = [x, y, z, 1];

end
