function read_ict = import_ict3(filename, x, dataLines)
%IMPORTFILE1 Import data from a text file 
%  read_ict = import_ict3(FILENAME)
%  reads data from text file FILENAME for the default selection.
%  Returns the data as a string array.
%
%  read_ict = import_ict3(filename, dataLines) reads data for the 
%  specified row interval(s) of text file FILENAME. Specify DATALINES
%  as a positive scalar integer or a N-by-2 array of positive scalar
%  integers for dis-contiguous row intervals.
%
%  Example:
%  read_ict = import_ict3("D:\Grad School\Research\Data\Pandora\OWLETS II\owlets2-UMBC-O3_Pandora_20180515_R0_thru20180819.ict", [1, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 22-Dec-2019 14:16:42

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 3
    dataLines = [1, Inf];
end

%% Setup the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", x);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ",";

% Specify column names and types
% opts.VariableTypes = ["string", "string", "string", "string", "string", "string", "string", "string", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

% Import the data
read_ict = readmatrix(filename, opts);

end