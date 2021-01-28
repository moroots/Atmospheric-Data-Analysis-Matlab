%Load From Folder
%   M.Roots - themauriceroots@gmail.com
%For test
% type = 'ict';
% clear all

function lode =  loadfiles(type, path, machine)
currentdir = pwd;

% acptd_types = ['ict', 'h5']
% if strcmp(type,acptd_types) == 0
%         msg = ['Not a Supported filetype.'];
%     errordlg(msg)
%     return;
% end

%% Data Paths
if strcmp(machine,'Magnolia')
    path_Recall = 'C:\Users\Magnolia\OneDrive - UMBC\Research\Code\Scratch Paper';  %Paths to functions
elseif strcmp(machine, 'iThink')
    path_Recall = 'C:\Users\meroo\OneDrive - UMBC\Research\Code\Scratch Paper';  %Paths to functions
end

%% NASA ict Import
if strcmp(type, 'ict')

    if ~exist('path', 'var')
        path ='C:\Users\meroo\OneDrive - UMBC\Research\Data\Surface\Use\';     %Path to Data Files
    end
    
    cd(path);
    disp(['Accessing in ' path newline]);
    fileName = dir(['*.' type]);
    for i = 1:length(fileName)
        lode(i).name = fileName(i).name;
    end
    
    if isempty(fileName)
        msg = ['There are no files with of such filetype in directory. Please'...
            'enter a valid filetype.'];
        errordlg(msg)
        return;
    end

    [m_D, n_D] = size(fileName);

    % ** Preallocate the Cell Arrays ** %
    All = cell(m_D, n_D);
    data = cell(m_D, n_D);
    headers = cell(1, n_D);


    name = strings([m_D, n_D]);

    uL_star = zeros(1, n_D);

    cd(path_Recall);
    for i=1:length(fileName)    %Grab the data and put each file in the same cell but keep it seperate by matrix
        uL_star(i) = str2double(import_ict3([path fileName(i).name], 1, [1,1]));
        All{i} = struct(importdata([path fileName(i).name], ',', uL_star(i)));
        data{i} = All{i}.data;
        headers{i} = All{i}.colheaders;
        data{i} = data{i}(data{i}(:,6) > 0,:);  %Take only the nonzero values
        disp(fileName(i).name) 
    end
    
    for i = 1:length(All)
        lode(i).head = All{i}.textdata;
    end
    
    for i = 1:length(headers)
        for j = 1:length(headers{i})
            headers_1{i} = erase(headers{i}, ' ');
            eval(['var_' headers_1{i}{j} '(i) = {data{i}(:, j)};']);
            eval(['lode(i).' headers_1{i}{j} '= var_' headers_1{i}{j} '{i};']);
         end
    end

%     clear uL_h i uL_j uL_k m_D n_D uL_t_numdays uL_t_epoch uL_str_filetype...
%     uL_lngth_data_cell uL_Data uL_zeros uL_Data_nonzero uL_Cols uL_Rows...
%     uL_star j;
% 
%     clc;
    disp([' All Files Loaded: type "ict"' newline])
end

%% HDF5 Import    
if strcmp(type, 'h5')
    path_Recall = 'C:\Users\meroo\OneDrive - UMBC\Research\Code\Scratch Paper';  %Paths to functions

    if ~exist('path', 'var')
        path = 'C:\Users\meroo\OneDrive - UMBC\Research\Data\Ozone Lidar\Use\';     %Path to Data Files
    end

    cd(path);
    disp(['Accessing in ' path newline]);
    fileName = dir(['*.' type]);

    for i = 1:length(fileName); lode(i).name = fileName(i).name; end
    
    if isempty(fileName)
        msg = ['There are no files with of such filetype in directory. Please'...
            'enter a valid filetype.'];
        errordlg(msg)
        return;
    end

    [m_D, ~] = size(fileName);

    % ** Preallocate the Cell Arrays ** %

    cd(path_Recall);
    for i=1:m_D    %Grab the data and put each file in the same cell but keep it seperate by matrix
        fileInfo = h5info([path fileName(i).name]);
        Readme{i} = string(h5read([path fileName(i).name], '/Readme'));
        lode(i).Readme = Readme{i};
        lode(i).Attributes = fileInfo.Datasets(1).Attributes;
        for j = 1:length(fileInfo.Groups.Datasets)
            name_1 = fileInfo.Groups.Datasets(j).Name;
            temp = ['/DATA/' name_1];
            eval(['var_' name_1 '{i} = h5read([path fileName(i).name], temp);']);
            eval(['lode(i).' name_1 '= var_' name_1 '{i};']);
        end
        disp(fileName(i).name) 
    end
    
%     clear uL_h i uL_j uL_k m_D n_D uL_t_numdays uL_t_epoch uL_str_filetype...
%        uL_lngth_data_cell uL_Data uL_zeros uL_Data_nonzero uL_Cols uL_Rows...
%        uL_star;
% 
%     clc;
    disp([' All Files Loaded: "type h5" ' newline])
end

%% NetCDF Import
if strcmp(type, 'nc')
    path_Recall = 'C:\Users\meroo\OneDrive - UMBC\Research\Code\Scratch Paper';  %Paths to functions

    if ~exist('path', 'var')
        path = 'C:\Users\meroo\OneDrive - UMBC\Research\Data\HUBV\Use\';     %Path to Data Files
    end    

    cd(path);
    disp(['Accessing in ' path newline]);
    fileName = dir(['*.' type]);
    
    for i = 1:length(fileName)
        lode(i).name = fileName(i).name;
    end

    if isempty(fileName)
        msg = ['There are no files with of such filetype in directory. Please'...
            'enter a valid filetype.'];
        errordlg(msg)
        return;
    end

    [m_D, ~] = size(fileName);

        % ** Preallocate the Cell Arrays ** %

    %     cd(path_Recall);
        for i=1:m_D    %Grab the data and put each file in the same cell but keep it seperate by matrix
            fileInfo = ncinfo([path fileName(i).name]);
    %         Readme{i} = string(ncread([path fileName(i).name], '/Attributes'));
    %         lode(i).Readme = Readme{i};
            lode(i).Attributes = fileInfo.Attributes;
            for j = 1:length(fileInfo.Variables)
                name_1 = fileInfo.Variables(j).Name;
                temp = name_1;
                eval(['var_' name_1 '{i} = ncread([path fileName(i).name], temp);']);
                eval(['lode(i).' name_1 '= var_' name_1 '{i};']);
            end
            disp(fileName(i).name) 
        end
        disp([' All Files Loaded: "type .nc" ' newline]) 
end

%% CSV Import
if strcmp(type, 'csv')
    
    if ~exist('path', 'var')
        path = 'C:\Users\meroo\OneDrive - UMBC\Research\Data\Surface\Use\';     %Path to Data Files
    end
    
    clc;
    cd(path);
    disp(['Accessing in ' path newline]);
    fileName = dir(['*.' type]);
    for i = 1:length(fileName)
        lode(i).name = fileName(i).name;
    end

    if isempty(fileName)
        msg = ['There are no files with of such filetype in directory. Please'...
            'enter a valid filetype.'];
        errordlg(msg)
        return;
    end
    
    warning ('off','MATLAB:table:ModifiedAndSavedVarnames');
    for i = 1:length(lode)
        lode(i).data = readtable([path lode(i).name]);
        uL = lode(i).data.Properties.VariableNames;
        for j=1:length(uL)
            eval(['uL1 = str2double(lode(i).data.' uL{j} '(1));']);
            if isnan(uL1)
                continue;
            end
            eval(['lode(i).data.' uL{j} '= str2double(lode(i).data.' uL{j} ');']);
        end
        disp([lode(i).name ' -> loaded'])
    end
    disp([newline 'All Files Loaded: type "csv"' newline])
end
cd(currentdir)
end