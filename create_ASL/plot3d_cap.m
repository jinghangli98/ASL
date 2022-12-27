
function plot3d_cap(matrix)

x = matrix(:,1);
y = matrix(:,2);
z = matrix(:,3);

capacitance = unique(matrix(:,end));

    for i = 1:length(capacitance)
        cap_x = x(matrix(:,end) == capacitance(i));
        cap_y = y(matrix(:,end) == capacitance(i));
        cap_z = z(matrix(:,end) == capacitance(i));
        plot3(cap_x, cap_y, cap_z, 'o', 'MarkerSize', 10, 'linewidth', 3)
        hold on
    end
    hold off

end
