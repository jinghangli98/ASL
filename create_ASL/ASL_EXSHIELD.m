clear;
close all;
clc;

EXSHIELD = load('../nonrotated/geometry/EXSHIELD.dat');
EXSHIELD(find(EXSHIELD(:,1) == 0 ),:) = [];

EXSHIELD_moving = EXSHIELD;

% EXSHIELD_moving(find(EXSHIELD_moving(:,2) >= 97),:) = [];
EXSHIELD_moving(find(EXSHIELD_moving(:,3) >= 172),:) = [];

plot3d(EXSHIELD_moving)


moving = zeros(max(EXSHIELD_moving(:,1)), max(EXSHIELD_moving(:,2)), max(EXSHIELD_moving(:,3)));

for i=1:size(EXSHIELD_moving,1)
    moving(EXSHIELD_moving(i,1), EXSHIELD_moving(i,2), EXSHIELD_moving(i,3)) = 1;
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

rotated = [x + (30-1), y + (226-190) , z-78-6];
rotated(find(rotated(:,2) <= 161 ),:) = [];


EXSHIELD = [EXSHIELD; rotated];
EXSHIELD = double(EXSHIELD);
EXSHIELD(:,3) = EXSHIELD(:,3) + (721-235);
plot3d(EXSHIELD)

writematrix(EXSHIELD, '../geometry/ASL_EXSHIELD.dat', 'Delimiter', ' ')

