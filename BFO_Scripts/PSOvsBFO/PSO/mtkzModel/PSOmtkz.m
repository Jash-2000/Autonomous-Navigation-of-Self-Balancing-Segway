% Particle Swarm Optimization for the Materka-Kacprzak MESFET model
% Author: Rahul Kashyap

clc 
clear all



%Initialization of Parameters

iter = 1100;
inf = 9999999;
lower_limit = [0.01 -2.0 3.0 -0.01];
upper_limit = [0.5 1.0 6.0 -0.2];
c1 = 1.4;
c2 = 1.9;
w = 0.4;
wmax = 0.95;
wmin = 0.2;
num_particles = 60;
num_dimensions = 4;
min_fitness = 9999999;
x = zeros(num_particles, num_dimensions);
totalIter = 100;
data = zeros(num_dimensions + 2, totalIter);

% Hard coded data, typically this would be present in a file
vgs = [0 -0.25 -0.5 -0.75 -1]; %GATE BIAS VOLTAGE for SET 1 Data--OK good
vds = [0 0.25 0.5 0.75 1.0 1.25 1.5 1.75 2.0 2.25 2.5 2.75 3.0 3.25 3.5 3.75 4.0 4.25 4.5 4.75 5.0 5.25 5.5 5.75 6.0 6.25 6.5 6.75 7.0 7.25 7.5 7.75 8]; % DRAIN VOLTAGE(BIAS VOLTAGE)Taken while measuring
ids(1,:)=[0.0003    0.0393    0.0710    0.0913    0.0983    0.1005    0.1015    0.1021    0.1020    0.1026    0.1028    0.1031    0.1032    0.1033    0.1034 0.1035    0.1036    0.1036    0.1035    0.1036    0.1037    0.1037    0.1037    0.1037    0.1037    0.1037    0.1037    0.1036    0.1036    0.1036  0.1034    0.1034    0.1034];
ids(2,:)=[0.0003    0.0337    0.0593    0.0730    0.0773    0.0791    0.0800    0.0804    0.0812    0.0817    0.0822    0.0825    0.0828    0.0832    0.0834 0.0837    0.0839    0.0840    0.0843    0.0845    0.0848    0.0850    0.0852    0.0854    0.0856    0.0858    0.0860    0.0862    0.0864    0.0865  0.0868    0.0870    0.0873];
ids(3,:)=[0.0002    0.0278    0.0469    0.0551    0.0577    0.0594    0.0605    0.0613    0.0620    0.0626    0.0631    0.0637    0.0641    0.0646    0.0650 0.0651    0.0657    0.0661    0.0665    0.0669    0.0672    0.0676    0.0679    0.0683    0.0686    0.0690    0.0694    0.0697    0.0701    0.0705  0.0710    0.0715    0.0719];
ids(4,:)=[0.0002    0.0216    0.0340    0.0388    0.0403    0.0419    0.0429    0.0437    0.0445    0.0452    0.0458    0.0465    0.0471    0.0473    0.0480 0.0486    0.0491    0.0496    0.0501    0.0506    0.0510    0.0515    0.0519    0.0524    0.0529    0.0534    0.0539    0.0544    0.0550    0.0556  0.0562    0.0568    0.0575];
ids(5,:)=[0.0001    0.0148    0.0213    0.0240    0.0256    0.0267    0.0276    0.0284    0.0291    0.0298    0.0305    0.0312    0.0314    0.0323    0.0330 0.0336    0.0342    0.0348    0.0353    0.0359    0.0364    0.0370    0.0375    0.0380    0.0386    0.0392    0.0396    0.0404    0.0411    0.0418  0.0426    0.0433    0.0441];
 for number = 1:totalIter
 
 % Start clock
 tic
%Initialization of Particle Position and Velocity
% Initialize randomly between upper and lower limits of parameters in the
% model

x = repmat(lower_limit, num_particles, 1).*ones(num_particles, num_dimensions) + repmat((upper_limit - lower_limit), num_particles, 1).*(rand(num_particles, num_dimensions));
v = repmat(lower_limit, num_particles, 1).*ones(num_particles, num_dimensions) + repmat((upper_limit - lower_limit), num_particles, 1).*(rand(num_particles, num_dimensions));

%Initialize best values to worst possible

fitness_gbest = inf;
fitness_lbest = fitness_gbest*ones(num_particles, 1);

% Updating local bests and their fitnesses

for t = 1:iter
    for i = 1:num_particles
         fitness_X(i) = error_mtkz(x(i,:), vds, vgs, ids);   % Fitness of each particle evaluated
    end
    
    ind = find(fitness_X' < fitness_lbest);
    fitless_lbest(ind) = fitness_X(ind)';
    x_lbest(ind, :) = x(ind, :);
     
    % Updating global bests and their fitness
    
    [min_fitness, min_fitness_index] = min(fitness_X);    
    if min_fitness < fitness_gbest
        fitness_gbest = min_fitness;
        X_gbest = x(min_fitness_index, :);
    end
    
    % Update velocity and position
    
    w = wmax - t*(wmax - wmin)/iter;
    c1 = wmax - t*(wmax - wmin)/iter;
    c2 = wmax - t*(wmax - wmin)/iter;
    v1 = w.*v + c1.*rand(num_particles, num_dimensions).*(x_lbest - x) + c2.*rand(num_particles, num_dimensions).*(repmat(X_gbest, num_particles, 1) - x);
    x1 = x + v1;
    x = x1;
    v = v1;
    
    for i = 1:num_particles
        for d = 1:num_dimensions
            if x(i,d)>upper_limit(d)|| x(i,d) < lower_limit(d)
                x(i,d) = lower_limit(d) + (upper_limit(d) - lower_limit(d)).*rand(1, 1);
            end
        end
    end    
        W(t) = min_fitness;

end

% Results, typically these would be written to file.

time = toc
% 
% [test_ids_mtkz] = mtkz(X_gbest, vds, vgs);
% plot (vds, test_ids_mtkz)
% hold
% plot (vds, ids, '*')
% hold;
X_gbest
min_fitness
number

data(1, number) = X_gbest(1);
data(2, number) = X_gbest(2);
data(3, number) = X_gbest(3);
data(4, number) = X_gbest(4);
data(5, number) = fitness_gbest;
data(6, number) = time;

 end



    
            
            
    
    
    
    
    
                
             
    
    




