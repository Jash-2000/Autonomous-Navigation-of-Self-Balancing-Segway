% Main code to run GA  and obtain Q and R. Might show some error for few
% times as randomly as value of initial Q and R might not be solvable for
% riccati equation
clear all, close all, clc   
PopSize = 15;               %Population size
MaxGenerations = 10;        %Generation limit

options = optimoptions(@ga,'PopulationSize',PopSize,'MaxGenerations',MaxGenerations,'OutputFcn',@myfun);
format long %As R value is very small

[x,fval] = ga(@(K)Cost(K),5,[],[],[],[],[7 0 0 0 0],[10 0.5 0.5 0.05 1e-4],[],options)
