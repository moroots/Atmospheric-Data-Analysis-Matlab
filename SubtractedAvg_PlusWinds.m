%Plotting With winds
clear all
close all
current = pwd;

path.save = 'C:\Users\meroo\OneDrive - UMBC\Research\Data\Processed\';
path.fig = 'C:\Users\meroo\OneDrive - UMBC\Research\Figures\Preliminary\';
path.load = 'C:\Users\meroo\OneDrive - UMBC\Research\Data\Processed\OWLETS2';

cd(path.load)
load('OWLETS2_HMI_MetStation.mat')
load('OWLETS2_OzoneLidar.mat')
load('OWLETS2_Pandora.mat')

% spread = [data_met(1).time(1) data_met(1).time(end)];
spread = datetime(2018, [6 7], [28 2]);
name_spread = spread;
name_spread.Format = 'yyyyMMdd';

 
names.fig = ['HMI_PandoraO3(withWinds)_2_' + string(name_spread(1)) + '_' + string(name_spread(2))];

start = find(data_pan(2).time >= data_met(1).time(1), 1);
avg_pan = mean(data_pan(2).ozone(start:end));
[u,v] = pol2cart(data_met(1).wd_deg,data_met(1).ws_mps);
t = datenum(data_met(1).time);
t1 = datenum(spread(1));
t2 = datenum(spread(2));

fig = figure('Name', names.fig,'NumberTitle','off','Position', get(0, 'Screensize')); 

plot(datenum(data_pan(2).time),data_pan(2).ozone-avg_pan,'-o', 'DisplayName', string(data_pan(2).FigureName))
xlabel('Time in UTC')
xlim([t1, t2])
ylabel(['Total Column Ozone (TCO_3) in DU - ' num2str(avg_pan)])

yyaxis right
hold on
quiver(t, data_met(1).ws_mps, u, v, 'DisplayName', 'Wind Direction');
plot(t, data_met(1).ws_mps, 'DisplayName', 'Wind Speed (mps)')
hold off
xlim([t1, t2])
% xlabelformat = 'MMM-dd HH';
ylim('auto')
ylabel('Wind Speed (m/s)')
legend;
title(['HMI Pandora and MetStation, Subtracted Average (' num2str(avg_pan) ')'])
set(gca,'FontSize', 12, 'FontName', 'TimesNewRoman'); 
datetick('keepticks');

saveas(fig, [path.fig + names.fig + '.png']);
cd(current);