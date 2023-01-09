clear;
close all;
clc;

EYSHIELD = load('../nonrotated/geometry/EYSHIELD.dat');

EYSHIELD(find(EYSHIELD(:,1) == 0 ),:) = [];

EYSHIELD_moving = EYSHIELD;

% EXSHIELD_moving(find(EXSHIELD_moving(:,2) >= 97),:) = [];
EYSHIELD_moving(find(EYSHIELD_moving(:,3) >= 172),:) = [];

moving = zeros(max(EYSHIELD_moving(:,1)), max(EYSHIELD_moving(:,2)), max(EYSHIELD_moving(:,3)));

for i=1:size(EYSHIELD_moving,1)
    moving(EYSHIELD_moving(i,1), EYSHIELD_moving(i,2), EYSHIELD_moving(i,3)) = 1;
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
rotated = [x+29, y+36, z-78 - 6];
rotated(find(rotated(:,2) <= 161 ),:) = [];

% plot3d(EYSHIELD)
% hold on
% plot3d(rotated)

EYSHIELD = [EYSHIELD; rotated];
EYSHIELD(:,3) = EYSHIELD(:,3) +  (365-240);
% EYSHIELD(:,3) = EYSHIELD(:,3);

plot3d(EYSHIELD)

writematrix(EYSHIELD, '../geometry/EYSHIELD.dat', 'Delimiter', ' ')

