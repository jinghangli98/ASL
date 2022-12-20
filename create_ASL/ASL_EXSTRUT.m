clear;
close all;
clc;

EXSTRUT = load('./nonrotated/geometry/EXSTRUT.dat');
EXSTRUT_moving = EXSTRUT;

EXSTRUT_moving(find(EXSTRUT_moving(:,3) >= 172),:) = [];

moving = zeros(max(EXSTRUT_moving(:,1)), max(EXSTRUT_moving(:,2)), max(EXSTRUT_moving(:,3)));

for i=1:size(EXSTRUT_moving,1)
    moving(EXSTRUT_moving(i,1), EXSTRUT_moving(i,2), EXSTRUT_moving(i,3)) = 1;
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
rotated = [x + (218-182), y + (219-176), z-76-6];
rotated(find(rotated(:,2) <= 161 ),:) = [];


EXSTRUT = [EXSTRUT; rotated];
plot3d(EXSTRUT)

writematrix(EXSTRUT, './geometry/ASL_EXSTRUT.dat', 'Delimiter', ' ')

% 
% EXSTRUT_moving(find(EXSTRUT_moving(:,1) >=213),:) = [];
% EXSTRUT_moving(find(EXSTRUT_moving(:,1) <=44),:) = [];
% 
% EXSTRUT_moving(find(EXSTRUT_moving(:,2) <= 160), :) = [];
% EXSTRUT_moving(find(EXSTRUT_moving(:,3) <= 162), :) = [];
% 
% middle_piece = EXSTRUT_moving(find(EXSTRUT_moving(:,1) <= 160 & EXSTRUT_moving(:,1) >= 95), :);
% middle_piece(:,3) = middle_piece(:,3) - 7;
% 
% EXSTRUT_moving(find(EXSTRUT_moving(:,1) <= 160 & EXSTRUT_moving(:,1) >= 95), :) = [];
% 
% EXSTRUT_moving = [EXSTRUT_moving; middle_piece];
% plot3d(EXSTRUT_moving)
% 
% move_z = 72 + 72 + 6; 
% EXSTRUT_moving(:,3) = EXSTRUT_moving(:,3) - move_z;
% 
% EXSTRUT = [EXSTRUT; EXSTRUT_moving];
% 
% plot3d(EXSTRUT)

% writematrix(EXSTRUT, './geometry/ASL_EXSTRUT.dat', 'Delimiter', ' ')

