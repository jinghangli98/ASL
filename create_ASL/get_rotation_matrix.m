function rot_mat = get_rotation_matrix(x, y, z)
    
    x = deg2rad(x);
    y = deg2rad(y);
    z = deg2rad(z); 
    rot_roll = [1, 0, 0, 0; 
                0, cos(x), -sin(x), 0;
                0, sin(x), cos(x), 0;
                0, 0, 0, 1];
    rot_pitch = [cos(y), 0, sin(y), 0;
                 0, 1, 0, 0;
                 -sin(y), 0, cos(y), 0;
                 0, 0, 0, 1];
    rot_yaw = [cos(z), -sin(z), 0, 0;
               sin(z), cos(z), 0, 0;
               0, 0, 1, 0;
               0, 0, 0, 1];
    rot_mat = rot_roll * rot_pitch * rot_yaw;
end