%% Function to plot Lidar Curtains
% - Author: Maurice Roots -> themauriceroots@gmail.com
function lc = lidarcurtain1(t, alt, data, figname, figsave, spacing)
current = pwd
% fig = figure('Name', figname,'NumberTitle','off','Position', get(0, 'Screensize')); 
imagesc(t,alt,data)
xticks([t(1:spacing:end)])
% xticklabels([t_datetime(1:spacing:end)])
% ylim([0 max_alt])
title(string(figname))
ylabel('Altitude (km) above sea-level')
xlabel('Time (UTC)')
set(gca,'YDir','normal')    % Needed for y-axis flip
cmap = colormap('jet');
cbar = colorbar;
ylabel(cbar, 'Ozone Number Density (O3ND)')
set(gca,'Fontsize', 14)
% saveas([path.save 'data_O3Lidar_test.mat'], 'data_O3Lidar')

cd(current)
end