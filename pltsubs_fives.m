
% Some Plots from OWLETS2 Data - Maurice Roots mroots1@umbc.edu

% House Keeping
close all
current = pwd;

path.save = 'C:\Users\meroo\OneDrive - UMBC\Research\Data\Processed\';
path.fig = 'C:\Users\meroo\OneDrive - UMBC\Research\Figures\Preliminary\';
path.load = 'C:\Users\meroo\OneDrive - UMBC\Research\Data\Processed\OWLETS2';

names.fig = 'OWLETS2_Pandora_20180628_20180702';

cd(path.load)
load('OWLETS2_HMI_MetStation.mat')
load('OWLETS2_OzoneLidar.mat')
load('OWLETS2_Pandora.mat')

mrkr = {'-+','-o','-*','-x','-s','-d','-^','-v','->','-<','-p','-h'};

timespan = datetime(2018, [6 7], [28 03], 13, 0, 0);
num_days = days(timespan(2) - timespan(1));
x = 'data_pan.time';
y = 'data_pan.ozone';
num_plt = 5;
w = 0;
oph = 3;

fig = figure('Name', names.fig,'NumberTitle','off','Position', get(0, 'Screensize')); 
% for i = 1:num_plt
%     date2 = timespan(1) + (i-1)*(hours(24));
%     date1 = timespan(1) + (i)*(hours(24));
%     eval(['h '=  subplot(num_plt, 1,i);']);
%     hold on
%     for j = 1:num_plt
%         plot(data_pan(j).time, data_pan(j).ozone, mrkr{j}, 'DisplayName', string(data_pan(j).FigureName));
%     end
%     hold off
%     xlim([date2 date1]);
%     
%     if i == length(num_plt)
%         xticklabels(string([13:23, 0]));
%     else 
%         xticks([])
%     end
%     
%     legend('Location', 'northoutside','Orientation', 'horizontal');
%     ylim([285 330])
%     yticks([290, 300, 310, 325])
%     
%     if w == 1
%         yyaxis right
%         plot(data_met.time(date), data_met.ws_mps, '-k', 'Linewidth', 2, 'DisplayName', 'WindSpeed')   
%         ylim('auto')
%     end
%     
%     xlim(datetime(2018, 6, [28 29], [13 0], 0, 0));
%     set(gca,'FontSize', 12, 'FontName', 'TimesNewRoman'); 
% end

h1 = subplot(5, 1, 1);
hold all
for j = 1:num_plt
    if j == oph
        continue
    end
  plot(data_pan(j).time, data_pan(j).ozone, mrkr{j}, 'DisplayName', string(data_pan(j).FigureName));
end
hold off
xlim(datetime(2018, 6, [28 29], [13 0], 0, 0));
xticks([])
ylim([285 330])
yticks([290, 300, 310, 325])
legend('Location', 'northoutside','Orientation', 'horizontal');

% yyaxis right
% plot(test_2, var_ws_mps{1}, '-k', 'Linewidth', 2, 'DisplayName', 'WindSpeed')
% ylim('auto')
xlim(datetime(2018, 6, [28 29], [13 0], 0, 0));
set(gca,'FontSize', 12, 'FontName', 'TimesNewRoman'); 

h2 = subplot(5, 1, 2);
hold all
for j = 1:num_plt
    if j == oph
        continue
    end
   plot(data_pan(j).time, data_pan(j).ozone, mrkr{j}, 'DisplayName', string(data_pan(j).FigureName));
end
hold off
xlim(datetime(2018, 6, [29 30], [13 0], 0, 0));
xticks([])
ylim([285 330])
yticks([290, 300, 310, 325])
set(gca,'FontSize', 12, 'FontName', 'TimesNewRoman'); 

h3 = subplot(5, 1, 3);
hold all
for j = 1:num_plt
    if j == oph
       continue
    end
    plot(data_pan(j).time, data_pan(j).ozone, mrkr{j}, 'DisplayName', string(data_pan(j).FigureName));
end
hold off
% title('Jul 1, 2018');
xlim(datetime(2018, [6 7], [30 1], [13 0], 0, 0));
xticks([])
ylim([285 315])
yticks([290, 295, 300, 305, 310])
ylabel('Total Column Ozone (TCO_3) in DU')
set(gca,'FontSize', 12, 'FontName', 'TimesNewRoman'); 

h4 = subplot(5, 1, 4);
hold all
for j = 1:num_plt
    if j == oph
        continue
    end
    plot(data_pan(j).time, data_pan(j).ozone, mrkr{j}, 'DisplayName', string(data_pan(j).FigureName));
end
hold off
xlim(datetime(2018, 7, [1 2], [13 0], 0, 0));
xticks([])
ylim([285 315])
yticks([290, 295, 300, 305, 310])
set(gca,'FontSize', 12, 'FontName', 'TimesNewRoman'); 

h5 = subplot(5,1,5);
hold all
for j = 1:num_plt
    if j == oph
        continue
    end
    plot(data_pan(j).time, data_pan(j).ozone, mrkr{j}, 'DisplayName', string(data_pan(j).FigureName));
end
hold off
xlim(datetime(2018, 7, [2 3], [13 0], 0, 0));
xticklabels({'13','14','15', '16', '17', '18', '19', '20', '21', '22', '23', '00'})
xlabel('Time in UTC')
ylim([285 315])
yticks([290, 295, 300, 305, 310])
set(gca,'FontSize', 12, 'FontName', 'TimesNewRoman');
 
p1 = get(h1, 'Position');
p2 = get(h2, 'Position');
p3 = get(h3, 'Position');
p4 = get(h4, 'Position');
p5 = get(h5, 'Position');

p5(4) = p5(4)*1.3;
p4(4) = p4(4)*1.3; 
p3(4) = p3(4)*1.3; 
p2(4) = p2(4)*1.3; 
p1(4) = p1(4)*1.3; 

p4(2) = p5(2) + p5(4)+0.01; %change bottom starting point of h1
p3(2) = p4(2) + p4(4)+0.01;
p2(2) = p3(2) + p3(4)+0.01;
p1(2) = p2(2) + p2(4)+0.01;

set(h1, 'pos', p1); %set h1 position
set(h2, 'pos', p2); 
set(h3, 'pos', p3); 
set(h4, 'pos', p4); 
set(h5, 'pos', p5);

txt_h1 = annotation('textbox', [p1(1)+0.7, p1(2), p1(3), p1(4)-0.02],...
    'String', 'Jun 28, 2018', 'FitBoxToText', true);
txt_h2 = annotation('textbox', [p2(1)+0.7, p2(2), p2(3), p2(4)-0.02],...
    'String', 'Jun 29, 2018', 'FitBoxToText', true);
txt_h3 = annotation('textbox', [p3(1)+0.7, p3(2), p3(3), p3(4)-0.02],...
    'String', 'Jun 30, 2018', 'FitBoxToText', true);
txt_h4 = annotation('textbox', [p4(1)+0.7, p4(2), p4(3), p4(4)-0.02],...
    'String', 'Jul 01, 2018', 'FitBoxToText', true);
txt_h5 = annotation('textbox', [p5(1)+0.7, p5(2), p5(3), p5(4)-0.02],...
    'String', 'Jul 02, 2018', 'FitBoxToText', true);

saveas(fig, [path.fig names.fig '.png']);
% saveas(fig, [path.fig names.fig '.mat']);

cd(current)