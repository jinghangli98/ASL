clear;
close all;
clc;

EZSHIELD = load('../nonrotated/geometry/EZSHIELD.dat');
EZSHIELD(find(EZSHIELD(:,1) == 0 ),:) = [];
EZSHIELD_moving = EZSHIELD;

% EXSHIELD_moving(find(EXSHIELD_moving(:,2) >= 97),:) = [];
EZSHIELD_moving(find(EZSHIELD_moving(:,3) >= 172),:) = [];

moving = zeros(max(EZSHIELD_moving(:,1)), max(EZSHIELD_moving(:,2)), max(EZSHIELD_moving(:,3)));

for i=1:size(EZSHIELD_moving,1)
    moving(EZSHIELD_moving(i,1), EZSHIELD_moving(i,2), EZSHIELD_moving(i,3)) = 1;
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

rotated(find(rotated(:,2) <= 162 ),:) = [];

EZSHIELD = [EZSHIELD; rotated];
EZSHIELD(:,3) = EZSHIELD(:,3) +  (365-240);
% EZSHIELD(:,3) = EZSHIELD(:,3);

plot3d(EZSHIELD)

writematrix(EZSHIELD, '../geometry/EZSHIELD.dat', 'Delimiter', ' ')

