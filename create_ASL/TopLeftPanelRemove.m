%Removes data from .dats for top left panel
clear;
close all;
clc

EZSHILD = load('/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/nonrotated/geometry/EZSHIELD.dat'); 
EXSHILD = load('/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/nonrotated/geometry/EXSHIELD.dat'); 
EYSHILD = load('/Users/jinghangli/Library/CloudStorage/OneDrive-UniversityofPittsburgh/09-ASL-Sim/nonrotated/geometry/EYSHIELD.dat'); 

%load any .dat file using the name but it must be in same path as script

EZSHILD = preprocessDat(EZSHILD);
EXSHILD = preprocessDat(EXSHILD);
EYSHILD = preprocessDat(EYSHILD);

plot3(EZSHILD(:,1),EZSHILD(:,2),EZSHILD(:,3),'.')
hold on
plot3(EXSHILD(:,1),EXSHILD(:,2),EXSHILD(:,3),'.')

plot3(EYSHILD(:,1),EYSHILD(:,2),EYSHILD(:,3),'.')
hold on

ASL_EZSHILD = EZSHILD;
ASL_EXSHILD = EXSHILD;
ASL_EYSHILD = EYSHILD;
hold off

% ASL_EZSHILD(find(ASL_EZSHILD(:,3) >=245),:) = [];
% ASL_EXSHILD(find(ASL_EXSHILD(:,3) >=245),:) = [];
ASL_EYSHILD(find(ASL_EYSHILD(:,3) >=251),:) = [];

ASL_EZSHILD(find(ASL_EZSHILD(:,2) <=158),:) = []; %158
ASL_EXSHILD(find(ASL_EXSHILD(:,2) <=158),:) = []; %158
ASL_EYSHILD(find(ASL_EYSHILD(:,2) <=158),:) = []; %158

plot3(ASL_EZSHILD(:,1),ASL_EZSHILD(:,2),ASL_EZSHILD(:,3),'.')
plot3(ASL_EXSHILD(:,1),ASL_EXSHILD(:,2),ASL_EXSHILD(:,3),'.')

hold on
plot3(ASL_EYSHILD(:,1),ASL_EYSHILD(:,2),ASL_EYSHILD(:,3),'.')

%middle plate bottom row
plot3(97,225,179, 'r*')
plot3(97,211,179, 'r*')
plot3(159,225,179, 'r*')
plot3(159,211,179, 'r*')

plot3(163,210,162, 'ro')
plot3(163,210,172, 'ro')

plot3(97,211,179, 'r*')
plot3(159,225,179, 'r*')
plot3(159,211,179, 'r*')

hold off

%removing rows if x value is larger than 167 in itk snap but actually
%(257-167 = 90)in .dat and therefor have to also flip the sign AND
%removing rows if x value is less than 215 in itk snap but actually
%(257-215 = 42)in .dat AND
%removing rows if y value is larger than 167 AND less than 213
% %removing rows if z value is greater than 170 AND less than 234
% %% Top left
% matrix(matrix(:, 1)<=96 & matrix(:, 1)>=0 & matrix(:, 2)>=166 & matrix(:, 2)<=219 ... % used to be 89 and 41
%     & matrix(:, 3)>=0 & matrix(:, 3)<=250, :) = []; % used to be 172
% %sort by x again for no real reason other than to be able to manually look
% %through easier
% 
% %% getting rid of bottom panels, left
% matrix(matrix(:, 1)<=90 & matrix(:, 1)>=37 & matrix(:, 2)>=37 & matrix(:, 2)<=90 ... % used to be 89 and 41
%     & matrix(:, 3)>=0 & matrix(:, 3)<=250, :) = []; % used to be 172
% 
% 
%% getting rid of some cells on tuning rods in Z
matrix(matrix,:,1)>=59 & matrix(:,1)<=62 & matrix(:,2)>=69 & matrix(:,2)<=71 & matrix(:,3)==191) = [];

% %% getting rid of bottom panels, right
% matrix(matrix(:, 1)<=220 & matrix(:, 1)>=160 & matrix(:, 2)>=37 & matrix(:, 2)<=90 ... % used to be 89 and 41
%     & matrix(:, 3)>=0 & matrix(:, 3)<=250, :) = []; % used to be 172
% 
% 
% %% getting rid of top right
% matrix(matrix(:, 1)<=219 & matrix(:, 1)>=160 & matrix(:, 2)>=167 & matrix(:, 2)<=219 ... % used to be 89 and 41
%     & matrix(:, 3)>=0 & matrix(:, 3)<=250, :) = []; % used to be 172
% 
% 
% % %% getting rid of straight panels
% %sides
% matrix(matrix(:, 1)<=226 & matrix(:, 1)>=0 & matrix(:, 2)>=90 & matrix(:, 2)<=166 ... % used to be 89 and 41
%     & matrix(:, 3)>=0 & matrix(:, 3)<=250, :) = []; % used to be 172
% %left side
% matrix(matrix(:, 1)<=42 & matrix(:, 1)>=0 & matrix(:, 2)>=90 & matrix(:, 2)<=160 ... % used to be 89 and 41
%     & matrix(:, 3)>=0 & matrix(:, 3)<=250, :) = []; % used to be 172
% %back
% matrix(matrix(:, 1)<=160 & matrix(:, 1)>=90 & matrix(:, 2)>=0 & matrix(:, 2)<=61 ... % used to be 89 and 41
%     & matrix(:, 3)>=0 & matrix(:, 3)<=250, :) = []; % used to be 172
% 
% 
% %% Getting rid of top hat (shield)
% matrix(matrix(:, 3)>=241, :) = []; % used to be 172
% 
% %% Extra connecting part
% matrix(matrix(:,2)<=210 & matrix(:,2)>=199, :) =[];




%% sorting
matrix = sortrows(matrix);
matrix2=[];
%matrix2 = load(''); %load new panel
finalMatrix = [matrix;matrix2];
finalMatrix = sortrows(finalMatrix, 3); %sorting in ascending z (not neccesary)


%% to add individual cells

% x = [];
% y = [];
% z = [:]; 
% for i = 1:length(x)
%     for i2 = 1:length(z)
%         AppendIndex = length(matrix) + 1;
%         matrix(AppendIndex, :) = [x(i) y(i) z(i2)];
%     end
% end

%% save('c:\Users\Jake b\Desktop\TranssrcTemp.dat','matrix','-ascii');

% Creating file to be written to
Temp = fopen('EZSHIELD2.dat','w');
% Writing data to file
fprintf(Temp, '%d %d %d\n', finalMatrix.'); %change based on file format. If the .dat has only x,y,z values it should look like: 
% '%d %d %d\n' but, if there is a capacitor or epsilon value in the case of
% editing the acrylics file an additional '%d' must be added
%Closing
fclose(Temp);

plot3(finalMatrix(:,1),finalMatrix(:,2),finalMatrix(:,3),'.','MarkerSize',10)