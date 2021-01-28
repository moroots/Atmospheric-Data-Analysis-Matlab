%% Plotting for AirNow
plotnum = 1; lookday = datetime(2020, 3, 8);
%% Plot 1
if plotnum == 1
    uL1 = find(data_AirNow.data.Date == lookday);
    uL_name = data_AirNow.data.SiteName(uL1);
    uL_data = data_AirNow.data.DailyMax8_hourOzoneConcentration(uL1);
    uL_colors = {'r', 'b', 'k', 'b', 'g', 'c', 'y'} ;
    figure;
    hold on
    for i=1:length(uL_data)
        yline(uL_data(i), uL_colors{i}, 'DisplayName', upper(data_AirNow.data.SiteName{uL1(i)}));
    end
    hold off
    legend
    title(['AirNow Ozone: ' datestr(lookday)])
    ylim([(min(uL_data) - min(uL_data)*0.1), (max(uL_data) + max(uL_data)*0.1)])
    ylabel('Daily Max 8-hour Ozone')
end 

%% Plot 2
if plotnum == 2
    close all
    limits = [datetime(2020, 3, 8) datetime(2020, 3, 9)];
    uL1 = unique(data_AirNow.data.SiteName);
    fig = figure('NumberTitle','off','Position', get(0, 'Screensize')); 
    hold on
    for i=1:length(uL1)
    plot(data_AirNow.data.Date(strcmp(data_AirNow.data.SiteName,uL1{i})),...
        data_AirNow.data.DailyMax8_hourOzoneConcentration(strcmp(data_AirNow.data.SiteName, uL1{i})), '--o',...
        'DisplayName', uL1{i}, 'Linewidth', 1.5)
    end
    hold off
    xlim(limits)
    legend('location', 'best');
    title('EPA AQS Ozone Baltimore-Columbia-Townsen, MD');
    ylabel(['Ozone (' data_AirNow.data.UNITS{1} ')'])

    yyaxis right
    hold on
    % plot(data_pandonia(2).data, data_pandonia(8).data, 'DisplayName', 'Filtered TCO_3: L2 Data')
    plot(data_pandonia(2).data, data_pandonia(8).data, '--o', 'DisplayName', 'Filtered TC: L2 Data', 'LineWidth', 1.5)
    hold off
    xlim(limits)
    set(gca,'FontSize', 14, 'FontName', 'TimesNewRoman'); 
end

