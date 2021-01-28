%% AirNow Data
tic     % record Runtime

%% House Keeping
clear data_AirNow path
current = pwd;
machine = 'Magnolia';

if strcmp(machine, 'Magnolia')
    path.use = 'C:\Users\Magnolia\OneDrive - UMBC\Research\Data\AirNow\USE\';
    path.load = 'C:\Users\Magnolia\OneDrive - UMBC\Research\Data\Processed\';
elseif strcmp(machine, 'iThink')
    path.use = 'C:\Users\meroo\OneDrive - UMBC\Research\Data\AirNow\USE\';
    path.load = 'C:\Users\meroo\OneDrive - UMBC\Research\Data\Processed\';
end

data_AirNow = loadfiles('csv', path.use, machine);
load([path.load 'Pandonia32s1_2020.mat']);


% uL2 = data_pandonia(8).data;
% uL3 = zeros(31, 1);
% for i = 1:30
%     lims = [datetime(2020, 3, i) datetime(2020, 3, i+1)];
%     uL3(i) = mean(uL2(data_pandonia(2).data < lims(2)));
% end


%% Plotting
% plotnum = 2; plotairnow;
% plotnum = 1; lookday = datetime(2020, 3, 8); plotairnow;

%% Cleaning Up
cd(current)
clear uL*
toc     %Display Runtime