%% Pandonia Data Pan32s1 -> 2020 Data
% Author Maurice Roots -> mroots1@umbc.edu

%% House Keeping
clear all
close all
current = pwd;

path.save = 'C:\Users\meroo\OneDrive - UMBC\Research\Data\Processed\';
path.fig = 'C:\Users\meroo\OneDrive - UMBC\Research\Figures\Preliminary\';
path.load = 'C:\Users\meroo\OneDrive - UMBC\Research\Data\Processed\OWLETS2';
path(2).load = 'C:\Users\meroo\OneDrive - UMBC\Research\Data\Processed\';

cd(path(2).load)
load('Pandonia_Pan32s1.mat')
load('Pandonia_Pan32s1_headers.mat')

%% Get Data
 for i = 1:length(Pandonia(1,:))
    for j = 1:length(Pandonia32s1_headers(1,:))
        data_pandonia(i).headers{j} = Pandonia32s1_headers{i, j};
        data_pandonia(i).data = Pandonia(:,i);
        data_pandonia(i).data = cell2mat(data_pandonia(i).data);
    end
 end

%For Pandora ict Data
uL_t_epoch = datenum('01-jan-2000');   %The typical .ict file has epoch of 01-jan-2000
%Number of days from matlab epoch to .ict epoch
uL_t_numdays = data_pandonia(2).data + uL_t_epoch; 
data_pandonia(2).data = datetime(uL_t_numdays, 'ConvertFrom', 'datenum');

%% Clean up the data
filt = [10 0];
for i = 3:length(data_pandonia)
uL_pandonia = data_pandonia(i).data;
    for j = 1:length(uL_pandonia)
        if data_pandonia(12).data(j) > filt(1)
            uL_pandonia(j) = NaN;
        end
    end
    data_pandonia(i).data = uL_pandonia;
end

% pan_avg = nanmean(data_pandonia(8).data);
pan_avg = 300;
minus_avg = data_pandonia(8).data - pan_avg;

%% For errorbars

uL_pandonia = data_pandonia(9).data;
for j = 1:length(data_pandonia(9).data)
    if data_pandonia(9).data(j) < 0
        data_pandonia(9).data(j) = NaN;
    end
end

error1 = data_pandonia(8).data + data_pandonia(9).data;
error2 = data_pandonia(8).data - data_pandonia(9).data;

%% New Plot
% close all
% range = [7:9];
% uL_data = avgbytime(data_pandonia(2).data, data_pandonia(8).data, hours(5));
% 
% for i = 1:length(range)
% Start(i) = find(uL_data.time > datetime(2020, 3, range(i)), 1);
% Stop(i) = find(uL_data.time > datetime(2020, 3, range(i)+1), 1);
% Day{i} = uL_data.data(Start(i):Stop(i));
% Day_time{i} = uL_data.time(Start(i):Stop(i));
% Day_time{i}.Format = 'HH:mm';
% end
% 
% fig = figure('NumberTitle','off','Position', get(0, 'Screensize')); 
% hold on
% for i= 1:length(Day)
%     plot(Day{i}, '--o', 'DisplayName', datestr(Day_time{i}(1), 'mm/dd'))
% end
% hold off
% legend
% ylabel('TCO (DU)')
% set(gca, 'Fontsize', 18)
% xlabel('Hours (UTC)')
% % 
% % 
% % % figure;
% % % plot(data_pandonia(2).data, data_pandonia(8).data)
% % % xlim(datetime(2020, 3, [6 11]))

%% Plotting
% cd(current)
% Pandonia1

%% Save the data
% save([path.save 'Pandonia32s1_2020.mat'], 'data_pandonia')
% saveas(fig, [path(1).fig + names(1).fig + '.png']);

%% Return
clear *uL uL*
cd(current);