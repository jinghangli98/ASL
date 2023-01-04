clear;
close all;
clc;

ASL_EZSTRUT = load('../geometry/ASL_EZSTRUT.dat');
model = load('../geometry/ASL_DUKE.dat');

% ASL_EZSTRUT = load('../nonrotated/geometry/EZSTRUT.dat');
% model = load('../nonrotated/geometry/model.dat');

plot3d(ASL_EZSTRUT)
hold on
plot3d(model)

%228 - 240