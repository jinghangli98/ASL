clear;
close all;
clc;

ACRYLICS = load('/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/nonrotated/geometry/ACRYLICS.dat');

moving = ACRYLICS;


moving(find(moving(:,1) >=213),:) = [];
moving(find(moving(:,1) <=44),:) = [];

moving(find(moving(:,2) <= 160), :) = [];
moving(find(moving(:,3) <= 162), :) = [];

middle_piece = moving(find(moving(:,1) <= 160 & moving(:,1) >= 95), :);
middle_piece(:,3) = middle_piece(:,3) - 7;

moving(find(moving(:,1) <= 160 & moving(:,1) >= 95), :) = [];

moving = [moving; middle_piece];

move_z = 71 + 71 + 6; 
moving(:,3) = moving(:,3) - move_z;


ACRYLICS = [ACRYLICS; moving];
ACRYLICS(:,3) = ACRYLICS(:,3) + (365-240);
% ACRYLICS(:,3) = ACRYLICS(:,3);

plot3d(ACRYLICS)

writematrix(ACRYLICS, '/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/geometry/ACRYLICS.dat', 'Delimiter', ' ')

