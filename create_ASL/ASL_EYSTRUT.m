clear;
close all;
clc;

EYSTRUT = load('./nonrotated/geometry/EYSTRUT.dat');
moving = EYSTRUT;

moving(find(moving(:,2) <= 160), :) = [];
moving(find(moving(:,3) <= 162), :) = [];



middle_piece = moving(find(moving(:,1) <= 160 & moving(:,1) >= 95), :);
middle_piece(:,3) = middle_piece(:,3) - 7;

moving(find(moving(:,1) <= 160 & moving(:,1) >= 95), :) = [];

moving = [moving; middle_piece];
plot3d(moving)

move_z = 72 + 72 + 6; 
moving(:,3) = moving(:,3) - move_z;

EYSTRUT = [EYSTRUT; moving];

plot3d(EYSTRUT)

writematrix(EYSTRUT, './geometry/ASL_EYSTRUT.dat', 'Delimiter', ' ')

