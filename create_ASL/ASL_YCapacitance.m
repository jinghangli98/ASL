clear;
close all;
clc;
lightBlue = [0 0.4470 0.7410];
YCapacitance = load('/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/nonrotated/geometry/YCapacitance.dat');
EYSHIELD = load('/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/nonrotated/geometry/EYSHIELD.dat');
EYSTRUT = load('/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/nonrotated/geometry/EYSTRUT.dat');


YCapacitance_moving = YCapacitance(:,1:3);
% YCapacitance_moving = [EYSTRUT; YCapacitance_moving];
YCapacitance_moving = [YCapacitance_moving];
YCapacitance_moving(find(YCapacitance_moving(:,3) >= 172),:) = [];

moving = zeros(max(YCapacitance_moving(:,1)), max(YCapacitance_moving(:,2)), max(YCapacitance_moving(:,3)));

for i=1:size(YCapacitance_moving,1)
    moving(YCapacitance_moving(i,1), YCapacitance_moving(i,2), YCapacitance_moving(i,3)) = 1;
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


% rotated = [x + 36, y + (161-121) , z - (76 + 6)];
rotated = [x + (172-130), y + (214-174) , z-76-6];
rotated(find(rotated(:,2) <= 165 ),:) = [];

% plot3d(YCapacitance_moving)
% hold on
% plot3d(rotated)
% 

capacitance = unique(YCapacitance(:,end));
rotated = [rotated, repmat(capacitance(1), size(rotated,1), 1)];
% middle_ind = find(rotated(:,1) >= 97 & rotated(:,1) <= 158);
% shield_ind = find(rotated(:,1) == 94 | rotated(:,1) == 161);
% rotated(middle_ind, end) = capacitance(2);
% rotated(shield_ind, end) = capacitance(3);

YCapacitance = [YCapacitance; rotated];
YCapacitance(:,3) = YCapacitance(:,3) +  (365-240);
% YCapacitance(:,3) = YCapacitance(:,3);


EYSTRUT = load('/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/geometry/EYSTRUT.dat');
plot3d(EYSTRUT)
hold on
plot3d_cap(YCapacitance)

writematrix(YCapacitance, '/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/geometry/YCapacitance.dat', 'Delimiter', ' ')

