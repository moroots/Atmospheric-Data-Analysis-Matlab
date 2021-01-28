% Import from Pandonia

% Url of Main Data
api = 'http://data.pandonia-global-network.org/';

% Extension of Data wanted
url = [api 'GreenbeltMD/Pandora32s1/L2/'];

% Convert Char of page to String
S = string(webread(url))  

% Get the File Names we want
S1 = regexp(url, 'Pandora*\w*(\.)?', 'match')
% uL1 = [S1{1} '*\w*(.txt)?']
uL1 = ['\w*txt\>']
S2 = regexp(S, uL1, 'match')

