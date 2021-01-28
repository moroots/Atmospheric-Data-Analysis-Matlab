    % Data filter

%Author: Maurice Roots: mroots1@umbc.edu

%Start%
fltr = [10 15];

%Pre-allocate
uL_loc_name = cell(1,length(data_pan));
uL_Pan_ozone = cell(1,length(data_pan));
uL_str_fnam = cell(1,length(data_pan));
uL_str_fignam = cell(1,length(data_pan));


for i=1:length(data_pan)
    uL_loc_name{i} = string(data_pan(i).name);
    uL_loc_name{i} = upper(regexp(uL_loc_name{i},'.*(?=_Pandora)','Match'));
%     uL_scan = data_pan(i).Dataqualityflag(1);
    
    if isempty(data_pan(i).Dataqualityflag)
        data_pan(i).ozone = data_pan(i).O3verticalcolumn(data_pan(i).UncertaintyO3verticalcolumn <= fltr(2));
        data_pan(i).time = data_pan(i).time(data_pan(i).UncertaintyO3verticalcolumn <= fltr(2));
    else 
        data_pan(i).ozone = data_pan(i).O3verticalcolumn(data_pan(i).UncertaintyO3verticalcolumn <= fltr(2) & data_pan(i).Dataqualityflag <= fltr(1));
        data_pan(i).time = data_pan(i).time(data_pan(i).UncertaintyO3verticalcolumn <= fltr(2) & data_pan(i).Dataqualityflag <= fltr(1));
    end
    
    uL_str_fnam{i} = ['filtered_' uL_loc_name{i}{1}];
    uL_str_fignam{i} = [uL_loc_name{i}{1} ': Filtered'];
    
    if i>1
        if strcmp(uL_str_fnam{i}, uL_str_fnam{i-1}) == 1
            uL_str_fnam{i} = [uL_str_fnam{i} sprintf('_%d', i-1)];
            uL_str_fignam{i} = [uL_loc_name{i}{1} sprintf(' #%d', i-1) ': Filtered'];
        end
    end
   data_pan(i).FileName = uL_str_fnam(i); 
   data_pan(i).FigureName = uL_str_fignam(i);
end

