clear;
close all;
clc;
lightBlue = [0 0.4470 0.7410];
XCapacitance = load('./nonrotated/geometry/XCapacitance.dat');
EXSHIELD = load('./nonrotated/geometry/EXSHIELD.dat');
EXSTRUT = load('./nonrotated/geometry/EXSTRUT.dat');


XCapacitance_moving = XCapacitance;
capacitance = unique(XCapacitance_moving(:,4));
plot3d_cap(XCapacitance_moving)
hold on
% plot3d(EXSHIELD, lightBlue)
plot3d(EXSTRUT, lightBlue)


% 
% 
% 
% XCapacitance_moving(find(XCapacitance_moving(:,3) >= 172),:) = [];
% 
% 
% moving = zeros(max(XCapacitance_moving(:,1)), max(XCapacitance_moving(:,2)), max(XCapacitance_moving(:,3)));
% 
% for i=1:size(XCapacitance_moving,1)
%     moving(XCapacitance_moving(i,1), XCapacitance_moving(i,2), XCapacitance_moving(i,3)) = 1;
% end
% 
% 
% eulerAngles = [0 180 0];
% trans = [0 0 0];
% tform = rigidtform3d(eulerAngles, trans);
% 
% Rin = imref3d(size(moving));
% Rin.XWorldLimits = Rin.XWorldLimits-mean(Rin.XWorldLimits);
% Rin.YWorldLimits = Rin.YWorldLimits-mean(Rin.YWorldLimits);
% Rin.ZWorldLimits = Rin.ZWorldLimits-mean(Rin.ZWorldLimits);
% rotated = imwarp(moving, Rin, tform);
% 
% [x,y,z] = ind2sub(size(rotated), find(rotated ~=0));
% rotated = [x, y+ 36, z+15-6];
% rotated(find(rotated(:,2) <= 161 ),:) = [];
% 
% 
% EXSHIELD = [EXSHIELD; rotated];
% EXSHIELD = double(EXSHIELD);
% plot3d(EXSHIELD)
% 
% writematrix(EXSHIELD, './geometry/ASL_EXSHIELD.dat', 'Delimiter', ' ')
% 
% 
% 
% writematrix(XCapacitance, './geometry/ASL_XCapacitance.dat', 'Delimiter', ' ')
% 
