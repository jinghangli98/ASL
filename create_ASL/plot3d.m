function plot3d(varargin)

    if length(varargin) == 1
        matrix = varargin{1};
        x = matrix(:,1);
        y = matrix(:,2);
        z = matrix(:,3);
        plot3(x,y,z,'.')
    elseif length(varargin) == 2
        matrix = varargin{1};
        x = matrix(:,1);
        y = matrix(:,2);
        z = matrix(:,3);
        color = varargin{2};
        plot3(x,y,z, '.', 'MarkerFaceColor', color)
    end


end