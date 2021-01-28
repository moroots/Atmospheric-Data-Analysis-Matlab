%% Multi-Year

tic     % record Runtime

%% House Keeping
clear AirNow path
current = pwd;
machine = 'iThink';

if strcmp(machine, 'Magnolia')
    path.dir = 'C:\Users\Magnolia\OneDrive - UMBC\Research';
elseif strcmp(machine, 'iThink')
    path.dir = 'C:\Users\meroo\OneDrive - UMBC\Research';
end

path.AirNow = [path.dir '\Data\AirNow\USE\'];
path.load = [path.dir '\Data\Processed\'];

AirData = loadfiles('csv', path.AirNow, machine);
load([path.load 'Pandonia32s1_2020.mat']);

%% Maryland
MD = 'Maryland';
% for i=1:length(AirData(2).data.StateName)
%     MD_airdata = AirData(2).data(find(AirData(2).data == 'Maryland'), :)
% end
AirData2019 = AirData(2).data.StateName;
AirData2019_MD = find(AirData2019==string(MD));
MD_airdata = AirData(2).data(AirData2019_MD, :);

figure;
plot(MD_airdata.DateLocal, MD_airdata.ArithmeticMean, 'o')
