clear all, close all, clc   
PopSize = 15;               %Population size
MaxGenerations = 10;        %Generation limit

options = optimoptions(@ga,'PopulationSize',PopSize,'MaxGenerations',MaxGenerations,'OutputFcn',@myfun);
format long
%This cost function is for LQR (J1)available as function in file pidtestJ1

% [x,fval] = ga(@(K)GA(K),5,[],[],[],[],[8 0.3 0.1 0.008 2e-5],[9 0.4 0.15 0.009 2.5e-5],[],options)
[x,fval] = ga(@(K)GA(K),5,[],[],[],[],[7 0 0 0 0],[10 0.5 0.5 0.05 1e-4],[],options)
%    9.7395    0.4422    0.4030    0.0401    0.000
%  2.0802
