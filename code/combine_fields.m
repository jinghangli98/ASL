function [combined] = combine_fields(field_dn, amplitudes, phases)
    files = dir(fullfile(field_dn, '*.mat'));
    
    fprintf('Loading field: %s', files(1).name);
    field_file = load([field_dn filesep files(1).name]);
    fprintf(', Done\n');
    
    if isfield(field_file, 'b_field')
        field_type = 'b_field';
    elseif isfield(field_file, 'ex_field')
        field_type = 'ex_field';
    end
    
    channels = length(files);
    [size_x, size_y, size_z] = size(field_file.b_field);
    fields = zeros(channels, size_x, size_y, size_z);
    
    fields(1, :, :, :) = field_file.(field_type);
    
    for ch = 2:channels
        fprintf('Loading field: %s', files(ch).name);
        field_file = load([field_dn filesep files(ch).name]);
        fields(ch, :, :, :) = field_file.(field_type);
        fprintf(', Done\n');
    end
    
    shim = amplitudes .* exp(1j * deg2rad(phases));
    
    fields_array = reshape(fields, channels, [], 1);
    combined_array = shim * fields_array;
    combined = reshape(combined_array, size_x, size_y, size_z);
end