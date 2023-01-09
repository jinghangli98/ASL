clear;
close all;
clc;

EXSTRUT = load('/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/nonrotated/geometry/EXSTRUT.dat');
asl_EXSTRUT = load('/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/geometry/EXSTRUT.dat');
transsrc = load('/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/nonrotated/geometry/Transsrc.dat');
asl_transsrc = transsrc;
EXSTRUT_moving = EXSTRUT;
EXSTRUT_moving = [EXSTRUT_moving, zeros(size(EXSTRUT_moving))];
EXSTRUT_moving = [EXSTRUT_moving; transsrc];

asl_transsrc(find(asl_transsrc(:,2) <= 159),:) = [];
asl_transsrc(find(asl_transsrc(:,3) <= 161),:) = [];

asl_transsrc_mid = asl_transsrc;
asl_transsrc_mid(find(asl_transsrc_mid(:,1) < 97 | asl_transsrc_mid(:,1) > 158),:) = [];
asl_transsrc_mid(:,3) = asl_transsrc_mid(:,3) - (221-214);
asl_transsrc(find(asl_transsrc(:,1) >=97 & asl_transsrc(:,1) <= 158), :) = [];

asl_transsrc = [asl_transsrc_mid; asl_transsrc];
asl_transsrc(:,3) = asl_transsrc(:,3) - 76 - 72; %minus additional 6 cell in z if want to seperate

asl_transsrc = [asl_transsrc; transsrc];
asl_transsrc(:,3) = asl_transsrc(:,3) +  (365-240);
% asl_transsrc(:,3) = asl_transsrc(:,3);

plot3d(asl_EXSTRUT)
hold on
% plot3d_src(transsrc)
% hold on
plot3d_src(asl_transsrc)

writematrix(asl_transsrc, '/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/geometry/Transsrc.dat', 'Delimiter', ' ')
