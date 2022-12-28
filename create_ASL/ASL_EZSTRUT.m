clear;
close all;
clc;

EZSTRUT = load('../nonrotated/geometry/EZSTRUT.dat');
EZSTRUT_moving = EZSTRUT;
% moving(find(moving(:,2) <= 160), :) = [];
EZSTRUT_moving(find(EZSTRUT_moving(:,3) >= 162), :) = [];

moving = zeros(max(EZSTRUT_moving(:,1)), max(EZSTRUT_moving(:,2)), max(EZSTRUT_moving(:,3)));
for i=1:size(EZSTRUT_moving,1)
    moving(EZSTRUT_moving(i,1), EZSTRUT_moving(i,2), EZSTRUT_moving(i,3)) = 1;
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

rotated = [x + (219-183), y + (159 - 116), z - (72  + 6)];

rotated(find(rotated(:,2) <= 159), :) = [];
EZSTRUT = [EZSTRUT; rotated];
plot3d(EZSTRUT)

writematrix(EZSTRUT, '../geometry/ASL_EZSTRUT.dat', 'Delimiter', ' ')

