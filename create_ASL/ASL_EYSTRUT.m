clear;
close all;
clc;

EYSTRUT = load('../nonrotated/geometry/EYSTRUT.dat');
EYSTRUT_moving = EYSTRUT;

% moving(find(moving(:,2) <= 160), :) = [];

EYSTRUT_moving(find(EYSTRUT_moving(:,3) >= 162), :) = [];
moving = zeros(max(EYSTRUT_moving(:,1)), max(EYSTRUT_moving(:,2)), max(EYSTRUT_moving(:,3)));

for i=1:size(EYSTRUT_moving,1)
    moving(EYSTRUT_moving(i,1), EYSTRUT_moving(i,2), EYSTRUT_moving(i,3)) = 1;
end


eulerAngles = [0 0 180];
trans = [0 0 0];
tform = rigidtform3d(eulerAngles, trans);

Rin = imref3d(size(moving));
Rin.XWorldLimits = Rin.XWorldLimits-mean(Rin.XWorldLimits);
Rin.YWorldLimits = Rin.YWorldLimits-mean(Rin.YWorldLimits);
Rin.ZWorldLimits = Rin.ZWorldLimits-mean(Rin.ZWorldLimits);
rotated = imwarp(moving, Rin, tform);

[x,y,z] = ind2sub(size(rotated), find(rotated ~=0));
rotated = [x + (37-1) , y + (218 - 176) , z- (76 + 6)];
rotated(find(rotated(:,2) <= 161 ),:) = [];


% 
% middle_piece = moving(find(moving(:,1) <= 160 & moving(:,1) >= 95), :);
% middle_piece(:,3) = middle_piece(:,3) - 7;
% 
% moving(find(moving(:,1) <= 160 & moving(:,1) >= 95), :) = [];
% 
% moving = [moving; middle_piece];
% plot3d(moving)
% 
% move_z = 72 + 72 + 6; 
% moving(:,3) = moving(:,3) - move_z;

EYSTRUT = [EYSTRUT; rotated];
EYSTRUT(:,3) = EYSTRUT(:,3) + (721-235);

plot3d(EYSTRUT)

writematrix(EYSTRUT, '../geometry/ASL_EYSTRUT.dat', 'Delimiter', ' ')

