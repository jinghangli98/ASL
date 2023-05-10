clear vars;
close all;
clc;

directory = '/Volumes/storinator/tia12/simulation/head_spherical/ttt_2ch_4p25in_curved/2021-11-07/fields/b_field_downsampled_2x2x2';

amplitudes = [0.5 0.5];
phases = [0 270];

combined = combine_fields(directory, amplitudes, phases);
niftiwrite(abs(combined), '/Users/jinghangli/Desktop/combined.nii');