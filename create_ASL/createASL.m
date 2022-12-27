clear;
close all;
clc;

EYSHILD = load('/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/nonrotated/geometry/EYSHIELD.dat'); 
gap=8; %8/16 inches gap between asl coil and the mail coil
EYSHILD = preprocessDat(EYSHILD);
ASL_EYSHILD = EYSHILD;
ASL_EYSHILD(find(ASL_EYSHILD(:,3) >=251),:) = [];
ASL_EYSHILD(find(ASL_EYSHILD(:,2) <=158),:) = []; %158
ASL_EYSHILD(find(ASL_EYSHILD(:,3) <=162),:) = []; %158

plot3d(ASL_EYSHILD)

ASL_mid_EYSHILD = ASL_EYSHILD;
ASL_side_EYSHILD = ASL_EYSHILD;
ASL_mid_EYSHILD([find(ASL_EYSHILD(:,1) >159); find(ASL_EYSHILD(:,1) <97)],:) = [];
ASL_mid_EYSHILD([find(ASL_mid_EYSHILD(:,2) <= 210)],:) = [];

ASL_side_EYSHILD(find(ASL_EYSHILD(:,3) >= 241),:) = [];
ASL_side_EYSHILD(find(ASL_side_EYSHILD(:,1) <= 159 &  ASL_side_EYSHILD(:,1) >= 97),:) = [];


%move the side panels down
ASL_side_EYSHILD(:,3) = ASL_side_EYSHILD(:,3) - 147 - gap;

%move middle down in z
ASL_mid_EYSHILD(:,3) = ASL_mid_EYSHILD(:,3) - 147 - 7 - gap;
plot3(ASL_mid_EYSHILD(:,1),ASL_mid_EYSHILD(:,2),ASL_mid_EYSHILD(:,3),'r.')
hold on
plot3(EYSHILD(:,1),EYSHILD(:,2),EYSHILD(:,3), 'b.')

%selecting midshield 
midshield_EYSHILD = EYSHILD;
midshield_EYSHILD(find(midshield_EYSHILD(:,2) ~= 45), :) = [];
midshield_EYSHILD(find(midshield_EYSHILD(:,1) <97 | midshield_EYSHILD(:,1)>159), :) = [];
midshield_EYSHILD([find(midshield_EYSHILD(:,3) < 234)],:) = [];

%move midshield down and forward
midshield_EYSHILD(:,3) = midshield_EYSHILD(:,3) - 147 - gap;
midshield_EYSHILD(:,2) = midshield_EYSHILD(:,2) + (210-44);

plot3(midshield_EYSHILD(:,1), midshield_EYSHILD(:,2), midshield_EYSHILD(:,3),'.');
plot3(ASL_side_EYSHILD(:,1), ASL_side_EYSHILD(:,2), ASL_side_EYSHILD(:,3),'.');
hold off
%% EZSHILD
EZSHILD = load('/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/nonrotated/geometry/EZSHIELD.dat'); 
EZSHILD = preprocessDat(EZSHILD);
figure; plot3(EZSHILD(:,1), EZSHILD(:,2), EZSHILD(:,3),'.')
ASL_side_EZSHILD = EZSHILD;
ASL_midFront_EZSHILD = EZSHILD;
ASL_side_EZSHILD(find(ASL_side_EZSHILD(:,2) <162),:) = []; 
ASL_side_EZSHILD(find(ASL_side_EZSHILD(:,3) >=172),:) = []; 

%move the side panels down
ASL_side_EYSHILD(:,3) = ASL_side_EYSHILD(:,3) - 147 - gap;

%select midfront
ASL_midFront_EZSHILD(find(ASL_midFront_EZSHILD(:,1)>160),:) = [];
ASL_midFront_EZSHILD(find(ASL_midFront_EZSHILD(:,1)<95),:) = [];
ASL_midFront_EZSHILD(find(ASL_midFront_EZSHILD(:,2)<208),:) = [];

figure; plot3(ASL_midFront_EZSHILD(:,1),ASL_midFront_EZSHILD(:,2),ASL_midFront_EZSHILD(:,3),'.')


figure; plot3(ASL_EZSHILD(:,1), ASL_EZSHILD(:,2), ASL_EZSHILD(:,3),'.')
