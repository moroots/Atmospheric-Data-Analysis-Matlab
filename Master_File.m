%% Master File
% M. Roots - themauriceroots@gmail.com

clear all
close all
clc;

path.save = 'C:\Users\meroo\OneDrive - UMBC\Research\Data\Processed\OWLETS2\';
path.met = 'C:\Users\meroo\OneDrive - UMBC\Research\Data\Surface\Use\';
path.h5 = 'C:\Users\meroo\OneDrive - UMBC\Research\Data\Ozone Lidar\Use\';
path.pan = 'C:\Users\meroo\OneDrive - UMBC\Research\Data\Pandora\OWLETS II\O3\';

%% Loading Files
data_met = loadfiles('ict', path.met);
% data_met2 = loadfiles('.txt', path.met);
data_pan = loadfiles('ict', path.pan);
data_h5 = loadfiles('h5', path.h5);
 
%% Sorting the Time
%For Pandora ict Data
uL_t_epoch = datenum('01-jan-2000');   %The typical .ict file has epoch of 01-jan-2000
%Number of days from matlab epoch to .ict epoch
for i=1:length(data_pan)
uL_t_numdays{i} = data_pan(i).Datetime + uL_t_epoch; 
data_pan(i).time = datetime(uL_t_numdays{i}, 'ConvertFrom', 'datenum');
end

%Creating the met file timestamps in UTC
uL_time_1 = datetime([2018 2019], [6 2], [6 18], 0, 0, 0, 'InputFormat', 'dd-MMM yyyy HH:mm:ss');

for j = 1:length(data_met)
    for i = 1:length(data_met(j).stop_300s_met)
        uL_time_2{j}(i) = datetime(uL_time_1(1) + seconds(data_met(j).start_300s_met(i)));
        uL_time_2{j}.Format = 'dd-MMM yyyy HH:mm:ss';
    end
    data_met(j).time = uL_time_2{j}';
end

%For Ozone Lidar ict Data
for i=1:length(data_h5)
uL_t_numdays{i} = data_h5(i).TIME_START_UT_DATEVEC; 
data_h5(i).time = datetime(uL_t_numdays{i}, 'ConvertFrom', 'datenum');
end

%% Calling Needed functions
% cd('C:\Users\meroo\OneDrive - UMBC\Research\Code\Useful')
filter_pan

%% Save the Data as '.mat'
save([path.save 'OWLETS2_OzoneLidar.mat'], 'data_h5')
save([path.save 'OWLETS2_HMI_MetStation.mat'], 'data_met')
save([path.save 'OWLETS2_Pandora.mat'], 'data_pan')



clear uL* i j