clear;
close all;
clc;

trans_src = dir('../nonrotated/geometry/Transsrc*');
EXSTRUT = load('../nonrotated/geometry/EXSTRUT.dat');
EYSTRUT = load('../nonrotated/geometry/EYSTRUT.dat');
EZSTRUT = load('../nonrotated/geometry/EZSTRUT.dat');

src_11 = load([trans_src(11).folder filesep trans_src(11).name]);
src_10 = load([trans_src(10).folder filesep trans_src(10).name]);

plot3d(EXSTRUT)
hold on
plot3d(EYSTRUT)
hold on
plot3d(EZSTRUT)
hold on
plot3d_src(src(:,1:3))

