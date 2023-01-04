clear;
close all;
clc;

EXSTRUT = load('../nonrotated/geometry/EXSTRUT.dat');
asl_EXSTRUT = load('../geometry/ASL_EXSTRUT.dat');
transsrc = load('../nonrotated/geometry/Transsrc.dat');
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
asl_transsrc(:,3) = asl_transsrc(:,3) - (76 + 76 + 2);

asl_transsrc = [asl_transsrc; transsrc];
asl_transsrc(:,3) = asl_transsrc(:,3) + (721-235);

plot3d(asl_EXSTRUT)
hold on
% plot3d_src(transsrc)
% hold on
plot3d_src(asl_transsrc)

writematrix(asl_transsrc, '../geometry/ASL_transsrc.dat', 'Delimiter', ' ')
