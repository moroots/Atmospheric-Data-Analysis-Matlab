%% First Attempt at Plotting HUBV
% Author -> Maurice Roots - mroots1@umbc.edu
% House Keeping

clear all
close all

current = pwd;

cd('C:\Users\meroo\OneDrive - UMBC\Research\Code\Useful')
path.save = 'C:\Users\meroo\OneDrive - UMBC\Research\Data\Processed\';
path.fig = 'C:\Users\meroo\OneDrive - UMBC\Research\Figures\Preliminary\';
path.load = 'C:\Users\meroo\OneDrive - UMBC\Research\Data\Processed\OWLETS2';
path.h5 = 'C:\Users\meroo\OneDrive - UMBC\Research\Data\Ozone Lidar\Use\';

cd(path.load)
%% Loading Files
HUBV_Lidar = loadfiles('h5', path.h5);