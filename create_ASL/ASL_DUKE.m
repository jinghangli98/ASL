clear;
close all;
clc;

duke = load('/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/Body_Duke_res1p5875_0deg.dat');
duke(find(duke(:,3) <= 400),:) = [];
duke(:,1) = duke(:,1) - 31;
duke(:,2) = duke(:,2) - 31;
duke(:,3) = duke(:,3) - 361;

plot3d(duke)
writematrix(duke, '../geometry/model.dat', 'Delimiter', ' ')
