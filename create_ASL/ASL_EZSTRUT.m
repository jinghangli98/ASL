clear;
close all;
clc;

EZSTRUT = load('/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/nonrotated/geometry/EZSTRUT.dat');
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

rotated = [x + (219-183), y + (159 - 116), z - 72]; %minus additional 6 cell in z if want to seperate

rotated(find(rotated(:,2) <= 159), :) = [];
EZSTRUT = [EZSTRUT; rotated];
EZSTRUT(:,3) = EZSTRUT(:,3) +  (365-240);
% EZSTRUT(:,3) = EZSTRUT(:,3);

plot3d(EZSTRUT)

writematrix(EZSTRUT, '/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/geometry/EZSTRUT.dat', 'Delimiter', ' ')

