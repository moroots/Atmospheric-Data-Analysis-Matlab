%% Plotting Pandonia Data
%% Debug
plotnum = 1;

%% Plot #1
if plotnum == 1 
    sp = [4 5];
    limits = [datetime(2020, 3, 7, 10, 0, 0) datetime(2020, 3, 10)];
    limits1 = limits; limits1.Format = 'yyyyMMdd';
    % limits1 = 'America/New_York';
    % limits.TimeZone = 'America/New_York';
    % data_pandonia(2).data.TimeZone = 'America/New_York';
    names.fig = ['pandonia32s1_GreenbeltMD_' + string(limits1(1)) + string(limits1(2))];
    fig = figure('Name', names(1).fig,'NumberTitle','off','Position', get(0, 'Screensize')); 
    subplot(2, 2, [1 2])
    
    hold on
    plot(data_pandonia(2).data, data_pandonia(8).data, 'DisplayName', 'Filtered TCO_3: L2 Data')
    plot(data_pandonia(2).data, error1, 'DisplayName', '+ Uncertanty')
    plot(data_pandonia(2).data, error2, 'DisplayName', '- Uncertainty')
    hold off
    xlim(limits);
    xticks([limits(1):hours(sp(1)):limits(2)])
    xline(datetime(2020,3,8,12,09,0), '--r', 'DisplayName', 'Sunrise (07:07 EDT)',...
        'LineWidth', 1.2);
    xline(datetime(2020,3,8,23,07,0), '--g', 'DisplayName', 'Sunset (19:07 EDT)',...
        'LineWidth', 1.2);
    xline(datetime(2020,3,8,21,0,0), '--k', 'DisplayName', 'Plume @ HUBV (21:00 UTC)',...
        'LineWidth', 1.2);
    xtickformat('HH:mm');
    ylabel('Total Column Ozone (DU)');
    ax = gca;
    ax.XGrid = 'on';
    ax.YGrid = 'off';
    legend;
    title('L2-Total Column Ozone: Pandora-32 (s1) Greenbelt,MD')
    xlabel('Datetime UTC')
    set(gca,'XMinorTick','on','YMinorTick','on');
    set(gca,'FontSize', 14, 'FontName', 'TimesNewRoman'); 

    % % Right Vertical Axis
    % yyaxis right;
    % plot(data_pandonia(2).data, minus_avg, 'DisplayName', ['Subtracted by Mean: ' + string(pan_avg)]);
    % xlabel('Datetime UTC')
    % legend;
    % set(gca,'XMinorTick','on','YMinorTick','on')
    % set(gca,'FontSize', 14, 'FontName', 'TimesNewRoman'); 

    subplot(2, 2, 3)
    plot(data_pandonia(2).data, data_pandonia(4).data,...
        'DisplayName', 'Solar Zenith Angle', 'LineWidth', 2);
    xlim(limits);
    xticks([limits(1):hours(sp(2)):limits(2)]);
    xtickformat('HH:mm');
    ylim([0 90]);
    yticks([0:30:90]);
    xline(datetime(2020,3,8,21,0,0), '--k', 'DisplayName', 'Plume @ HUBV (21:00 UTC)',...
        'LineWidth', 1.5);
    yline(80, '-k', 'DisplayName', 'SZA = 80 degrees',...
        'LineWidth', 1);
    ylabel('Solar Zenith Angle');
    title('Viewing Angle');
    set(gca, 'YDir','reverse');
    set(gca,'XMinorTick','on','YMinorTick','on');
    ax1 = gca; ax1.XAxis.MinorTick = 'on';
    ax1.XAxis;
    set(gca,'FontSize', 14, 'FontName', 'TimesNewRoman'); 

    yyaxis right
    plot(data_pandonia(2).data, data_pandonia(5).data,...
        'DisplayName', 'Solar Azimuth Angle', 'LineWidth', 2);
    ax = gca; ax.XGrid = 'on'; ax.YGrid = 'off';
    ylim([0, 360]);
    ylabel(ax, 'Solar Azimuth Angle');
    legend;
    yticks([0:60:360]);
    set(gca,'XMinorTick','on','YMinorTick','on');

    subplot(2, 2, 4)
    hold on
    plot(data_pandonia(2).data, data_pandonia(8).data,...
        'DisplayName', 'Filtered TCO_3: L2 Data');
    plot(data_pandonia(2).data, error1)
    plot(data_pandonia(2).data, error2)
    x2 = [data_pandonia(2).data, fliplr(data_pandonia(2).data)];
    hold off
    inBetween = [error2, fliplr(error1)];
    fill(x2, inBetween, 'g');
    xlim([datetime(2020, 3, 8, [18 23], 0 ,0)]);
    xtickformat('HH:mm');
    xline(datetime(2020,3,8,21,0,0), '--k', 'DisplayName', 'Plume @ HUBV (21:00 UTC)',...
        'LineWidth', 1.5);
    ylabel('Total Column Ozone (DU)');
    ax = gca;
    ax.XGrid = 'on';
    ax.YGrid = 'off';
    set(gca,'XMinorTick','on','YMinorTick','on');
    set(gca,'FontSize', 14, 'FontName', 'TimesNewRoman'); 

end

%% Plot #2
if plotnum == 2
    avg = days(1);
    limits = datetime(2020, [1 3], [1 31]);
    uL_data = avgbytime(data_pandonia(2).data, data_pandonia(8).data, avg);
    uL1 = unique(data_AirNow.data.SiteName);

    fig = figure('NumberTitle','off','Position', get(0, 'Screensize'));    
    title('EPA AirData and GSFC Pandora #32')
    hold on
    for i=1:length(uL1)
    plot(data_AirNow.data.Date(strcmp(data_AirNow.data.SiteName,uL1{i})),...
        data_AirNow.data.DailyMax8_hourOzoneConcentration(strcmp(data_AirNow.data.SiteName, uL1{i})), '--o',...
        'DisplayName', uL1{i}, 'Linewidth', 1.5)
    end
    hold off
    ylabel('AirData Surface Ozone (ppm)')
    
    yyaxis right;
    yyaxis.Color = 'k';
    plot(uL_data.time, uL_data.data, '--ok', 'Linewidth', 2, 'DisplayName', ['GSFC Pandora ' + string(avg) + ' Avg'])
    xlim(limits)
    ylabel('Pandora TCO (DU)')
    legend('location', 'best', 'orientation', 'horizontal')
    
    set(gca, 'Fontsize', 16)
    
    %% Corellation Plot
    for i=1:length(uL1)
    test1{i} = [datenum(data_AirNow.data.Date(strcmp(data_AirNow.data.SiteName,uL1{i}))), data_AirNow.data.DailyMax8_hourOzoneConcentration(strcmp(data_AirNow.data.SiteName, uL1{i}))];
    end
    fig = figure('NumberTitle','off','Position', get(0, 'Screensize'));
    title('EPA AirData and GSFC Pandora #32')
    hold on
    for i=1:length(uL1)
    plot(data_AirNow.data.Date(strcmp(data_AirNow.data.SiteName,uL1{i})),...
        '--o','DisplayName', uL1{i}, 'Linewidth', 1.5)
    end
    hold off
    xlim(limits)
    ylabel('Pandora TCO (DU)')
    legend('location', 'best', 'orientation', 'horizontal')
    set(gca, 'Fontsize', 16)
end

%% Plot #3
if plotnum == 3
    uL_data = avgbytime(data_pandonia(2).data, data_pandonia(8).data, days(1));
    sp = [4 5];
    limits = [datetime(2020, 3, 7, 10, 0, 0) datetime(2020, 3, 10)];
    limits1 = limits; limits1.Format = 'yyyyMMdd';

    fig = figure('NumberTitle','off','Position', get(0, 'Screensize')); 
    
    subplot(2, 2, [1 2])
    hold on
    plot(data_pandonia(2).data, data_pandonia(8).data, 'DisplayName', 'Filtered TCO_3: L2 Data')
    plot(data_pandonia(2).data, error1, 'DisplayName', '+ Uncertanty')
    plot(data_pandonia(2).data, error2, 'DisplayName', '- Uncertainty')
    hold off
    xlim(limits);
    xticks([limits(1):hours(sp(1)):limits(2)])
    xline(datetime(2020,3,8,12,09,0), '--r', 'DisplayName', 'Sunrise (07:07 EDT)',...
        'LineWidth', 1.2);
    xline(datetime(2020,3,8,23,07,0), '--g', 'DisplayName', 'Sunset (19:07 EDT)',...
        'LineWidth', 1.2);
    xline(datetime(2020,3,8,21,0,0), '--k', 'DisplayName', 'Plume @ HUBV (21:00 UTC)',...
        'LineWidth', 1.2);
    xtickformat('HH:mm');
    ylabel('Total Column Ozone (DU)');
    ax = gca;
    ax.XGrid = 'on';
    ax.YGrid = 'off';
    legend;
    title('L2-Total Column Ozone: Pandora-32 (s1) Greenbelt,MD')
    xlabel('Datetime UTC')
    set(gca,'XMinorTick','on','YMinorTick','on');
    set(gca,'FontSize', 14, 'FontName', 'TimesNewRoman'); 

    % % Right Vertical Axis
    % yyaxis right;
    % plot(data_pandonia(2).data, minus_avg, 'DisplayName', ['Subtracted by Mean: ' + string(pan_avg)]);
    % xlabel('Datetime UTC')
    % legend;
    % set(gca,'XMinorTick','on','YMinorTick','on')
    % set(gca,'FontSize', 14, 'FontName', 'TimesNewRoman'); 

%     subplot(2, 2, 3)
%     plot(data_pandonia(2).data, data_pandonia(4).data,...
%         'DisplayName', 'Solar Zenith Angle', 'LineWidth', 2);
%     xlim(limits);
%     xticks([limits(1):hours(sp(2)):limits(2)]);
%     xtickformat('HH:mm');
%     ylim([0 90]);
%     yticks([0:30:90]);
%     xline(datetime(2020,3,8,21,0,0), '--k', 'DisplayName', 'Plume @ HUBV (21:00 UTC)',...
%         'LineWidth', 1.5);
%     yline(80, '-k', 'DisplayName', 'SZA = 80 degrees',...
%         'LineWidth', 1);
%     ylabel('Solar Zenith Angle');
%     title('Viewing Angle');
%     set(gca, 'YDir','reverse');
%     set(gca,'XMinorTick','on','YMinorTick','on');
%     ax1 = gca; ax1.XAxis.MinorTick = 'on';
%     ax1.XAxis;
%     set(gca,'FontSize', 14, 'FontName', 'TimesNewRoman'); 
% 
%     yyaxis right
%     plot(data_pandonia(2).data, data_pandonia(5).data,...
%         'DisplayName', 'Solar Azimuth Angle', 'LineWidth', 2);
%     ax = gca; ax.XGrid = 'on'; ax.YGrid = 'off';
%     ylim([0, 360]);
%     ylabel(ax, 'Solar Azimuth Angle');
%     legend;
%     yticks([0:60:360]);
%     set(gca,'XMinorTick','on','YMinorTick','on');

%     subplot(2, 2, 4)
%     hold on
%     plot(data_pandonia(2).data, data_pandonia(8).data,...
%         'DisplayName', 'Filtered TCO_3: L2 Data');
%     plot(data_pandonia(2).data, error1)
%     plot(data_pandonia(2).data, error2)
%     hold off
%     xlim([datetime(2020, 3, 8, [18 23], 0 ,0)]);
%     xtickformat('HH:mm');
%     xline(datetime(2020,3,8,21,0,0), '--k', 'DisplayName', 'Plume @ HUBV (21:00 UTC)',...
%         'LineWidth', 1.5);
%     ylabel('Total Column Ozone (DU)');
%     ax = gca;
%     ax.XGrid = 'on';
%     ax.YGrid = 'off';
%     set(gca,'XMinorTick','on','YMinorTick','on');
%     set(gca,'FontSize', 14, 'FontName', 'TimesNewRoman'); 
end