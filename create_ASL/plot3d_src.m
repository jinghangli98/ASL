function plot3d_src(matrix)

x = matrix(:,1);
y = matrix(:,2);
z = matrix(:,3);

plot3(x, y, z, 'o', 'MarkerSize', 10, 'linewidth', 3)

end