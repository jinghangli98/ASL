clear;
close all;
clc;
lightBlue = [0 0.4470 0.7410];
ZCapacitance = load('/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/nonrotated/geometry/ZCapacitance.dat');
EZSHIELD = load('/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/nonrotated/geometry/EZSHIELD.dat');
EZSTRUT = load('/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/nonrotated/geometry/EZSTRUT.dat');
ASL_EZSTRUT = load('/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/geometry/EZSTRUT.dat');


ZCapacitance_moving = ZCapacitance(:,1:3);
% XCapacitance_moving = [EXSTRUT; XCapacitance_moving];
ZCapacitance_moving = [ZCapacitance_moving];
ZCapacitance_moving(find(ZCapacitance_moving(:,3) >= 172),:) = [];

moving = zeros(max(ZCapacitance_moving(:,1)), max(ZCapacitance_moving(:,2)), max(ZCapacitance_moving(:,3)));

for i=1:size(ZCapacitance_moving,1)
    moving(ZCapacitance_moving(i,1), ZCapacitance_moving(i,2), ZCapacitance_moving(i,3)) = 1;
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
rotated = [x + (213 - 171), y + (213 - 155), z-72]; %minus additional 6 cell in z if want to seperate
rotated(find(rotated(:,2) <= 161 ),:) = [];


capacitance = unique(ZCapacitance(:,end));
rotated = [rotated, repmat(capacitance(1), size(rotated,1), 1)];
rotated = [rotated; ZCapacitance];
middle_ind = find(rotated(:,1) >= 97 & rotated(:,1) <= 158);
rotated(middle_ind, end) = capacitance(2);


ZCapacitance = rotated;
ZCapacitance(:,3) = ZCapacitance(:,3) +  (365-240);
% ZCapacitance(:,3) = ZCapacitance(:,3);


plot3d(ASL_EZSTRUT)
hold on
plot3d_cap(ZCapacitance)

writematrix(ZCapacitance, '/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/geometry/ZCapacitance.dat', 'Delimiter', ' ')

