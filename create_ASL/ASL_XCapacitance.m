clear;
close all;
clc;
lightBlue = [0 0.4470 0.7410];
XCapacitance = load('/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/nonrotated/geometry/XCapacitance.dat');
EXSHIELD = load('/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/nonrotated/geometry/EXSHIELD.dat');
EXSTRUT = load('/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/nonrotated/geometry/EXSTRUT.dat');
ASL_EXSHIELD = load('/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/geometry/EXSHIELD.dat');
ASL_EZSHIELD = load('/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/geometry/EZSHIELD.dat');

XCapacitance_moving = XCapacitance(:,1:3);
% XCapacitance_moving = [EXSTRUT; XCapacitance_moving];
XCapacitance_moving = [XCapacitance_moving];
XCapacitance_moving(find(XCapacitance_moving(:,3) >= 172),:) = [];

moving = zeros(max(XCapacitance_moving(:,1)), max(XCapacitance_moving(:,2)), max(XCapacitance_moving(:,3)));

for i=1:size(XCapacitance_moving,1)
    moving(XCapacitance_moving(i,1), XCapacitance_moving(i,2), XCapacitance_moving(i,3)) = 1;
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


% rotated = [x + 36, y + (219-176), z-76-6];
rotated = [x + 36 + (99-95), y + (219-176) + (213-173), z-76]; %minus additional 6 cell in z if want to seperate
rotated(find(rotated(:,2) <= 161 ),:) = [];

capacitance = unique(XCapacitance(:,end));
rotated = [rotated, repmat(capacitance(1), size(rotated,1), 1)];
middle_ind = find(rotated(:,1) >= 97 & rotated(:,1) <= 158);
shield_ind = find(rotated(:,1) == 94 | rotated(:,1) == 161);

rotated(middle_ind, end) = capacitance(2);
rotated(shield_ind, end) = capacitance(3);

XCapacitance = [XCapacitance; rotated];
XCapacitance(:,3) = XCapacitance(:,3) + (365-240);
% XCapacitance(:,3) = XCapacitance(:,3);


plot3d(ASL_EXSHIELD)
hold on
plot3d_cap(XCapacitance)
hold on 
plot3d(ASL_EZSHIELD)

writematrix(XCapacitance, '/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/geometry/XCapacitance.dat', 'Delimiter', ' ')

