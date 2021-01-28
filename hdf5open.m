
function datah5 = hdf5open(type, path)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INPUTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

path_Recall = 'C:\Users\meroo\OneDrive - UMBC\Research\Code\Scratch Paper';  %Paths to functions

% if ~exist('path', 'var')
%     path ='C:\Users\meroo\OneDrive - UMBC\Research\Data\Ozone Lidar\Use';     %Path to Data Files
% end


% ************* 1-D Data (.DAT) ************* %
cd(path);
disp(['Accessing in ' path]);
fileName = dir(['*.' type]);

if isempty(fileName)
    msg = ['There are no files with of such filetype in directory. Please'...
        'enter a valid filetype.'];
    win_1 = errordlg(msg)
end

[m_D, n_D] = size(fileName);
        
% ** Preallocate the Cell Arrays ** %
All = cell(m_D, n_D);
data_h5 = cell(m_D, n_D);
headers = cell(1, n_D);


name = strings([m_D, n_D]);

uL_star = zeros(1, n_D);

cd(path_Recall);
for i=1:m_D    %Grab the data and put each file in the same cell but keep it seperate by matrix
    fileInfo = h5info([path fileName(i).name]);
    for j = 1:length(fileInfo.Groups.Datasets)
        name_1 = fileInfo.Groups.Datasets(j).Name;
        temp = ['/DATA/' name_1];
        eval(['var_' name_1 '{i} = h5read([path fileName(i).name], temp);']);
%         data_h5 = struct(name_1, eval(['var_' name_1]));
        eval(['datah5.' name_1 '= var_' name_1 ';']);
    end
    Readme{i} = h5read([path fileName(i).name], '/Readme');
%     Attributes{i} = h5read([path fileName(i).name], '/Instrument_Attributes');
end
datah5.readme = Readme
clear uL_h i uL_j uL_k m_D n_D uL_t_numdays uL_t_epoch uL_str_filetype...
   uL_lngth_data_cell uL_Data uL_zeros uL_Data_nonzero uL_Cols uL_Rows...
   uL_star;

clc;
disp(' All Files Loaded ')
end