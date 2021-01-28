%Plotting With winds

close all
current = pwd;

path.fig = 'C:\Users\meroo\OneDrive - UMBC\Research\Figures\Preliminary\';
names.fig = 'HMI_PandoraO3(withWinds)_2_20180628_20180702';

fig = figure('Name', names.fig,'NumberTitle','off','Position', get(0, 'Screensize')); 

plot(data_pan(2).time,data_pan(2).ozone,'-ob', 'DisplayName', string(data_pan(2).FigureName))
ax1 = gca; % current axes
ax1.XColor = 'b';
ax1.YColor = 'b';
ax1.XLim = datetime(2018, [6 7], [28 2]);
ax1.XGrid = 'on'; 
xlabel('Time in UTC')
ylabel('Total Column Ozone (TCO_3) in DU')
legend()


ax1_pos = ax1.Position; % position of first axes
ax2 = axes('Position', ax1_pos, 'XAxisLocation','top',...
    'YAxisLocation','right',...
    'Color','none');

line(data_met(1).time, data_met(1).ws_mps,'Parent',ax2,'Color','k')
xlim(datetime(2018, [6 7], [28 2]))
xlabelformat = 'MMM-dd HH';
ylim('auto')
xlim(datetime(2018, [6 7], [28 2]));
ylabel('Wind Speed (m/s)')
% ax3 = gca; % current axes
% ax3.XColor = 'b';
% ax3.YColor = 'b';
legend()
set(gca,'FontSize', 12, 'FontName', 'TimesNewRoman'); 

% legend('Location', 'northoutside','Orientation', 'horizontal');


saveas(fig, [path.fig names.fig '.png']);
cd(current);