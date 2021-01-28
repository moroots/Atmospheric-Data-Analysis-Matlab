%% Averaging by hours
%Author Maurice Roots

function averaged = avgbytime(time, data, tstep)
% time  -> Datetime 
% data  -> Data to be avaeraged
% tstep -> Specify the timestep; Example: tstep = minutes(15) => ever 
%          15-minutes of the day will be averaged
%
% Output is a structure with a datetime array labeled "time" and a double
% labeled "data"

%% Errors
if ~isdatetime(time); error('First input must be datetime'); end

%% Starting
uL_Table = timetable(time, data);
uL_Table = retime(uL_Table, 'regular', 'mean', 'TimeStep', tstep);
averaged.time = uL_Table.time;
averaged.data = uL_Table.data;

%% End
clear uL_Table
end