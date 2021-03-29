% Bacteria Foraging Optimization for the Materka Kacprzak Model
% Author: Rahul Kashyap

% Initialize parameters
p = 4;  %Dimension of the search space
s = 40; %Number of Bacteria
Nc = 5; %Number of Chemotactic Steps
Ns = 4; %Number of swim steps
Nre = 4; %Number of reproductive steps
Sr = s/2; %number of bacteria splits each generation
Ned = 5; %number of elimination dispersal steps
ped = 1.0; %Probability of elimination and dispersal

% Training data for the fitting
vgs = [0 -0.25 -0.5 -0.75 -1]; %GATE BIAS VOLTAGE for SET 1 Data--OK good

ids(1,:)=[0.0003    0.0393    0.0710    0.0913    0.0983    0.1005    0.1015    0.1021    0.1020    0.1026    0.1028    0.1031    0.1032    0.1033    0.1034 0.1035    0.1036    0.1036    0.1035    0.1036    0.1037    0.1037    0.1037    0.1037    0.1037    0.1037    0.1037    0.1036    0.1036    0.1036  0.1034    0.1034    0.1034];
ids(2,:)=[0.0003    0.0337    0.0593    0.0730    0.0773    0.0791    0.0800    0.0804    0.0812    0.0817    0.0822    0.0825    0.0828    0.0832    0.0834 0.0837    0.0839    0.0840    0.0843    0.0845    0.0848    0.0850    0.0852    0.0854    0.0856    0.0858    0.0860    0.0862    0.0864    0.0865  0.0868    0.0870    0.0873];
ids(3,:)=[0.0002    0.0278    0.0469    0.0551    0.0577    0.0594    0.0605    0.0613    0.0620    0.0626    0.0631    0.0637    0.0641    0.0646    0.0650 0.0651    0.0657    0.0661    0.0665    0.0669    0.0672    0.0676    0.0679    0.0683    0.0686    0.0690    0.0694    0.0697    0.0701    0.0705  0.0710    0.0715    0.0719];
ids(4,:)=[0.0002    0.0216    0.0340    0.0388    0.0403    0.0419    0.0429    0.0437    0.0445    0.0452    0.0458    0.0465    0.0471    0.0473    0.0480 0.0486    0.0491    0.0496    0.0501    0.0506    0.0510    0.0515    0.0519    0.0524    0.0529    0.0534    0.0539    0.0544    0.0550    0.0556  0.0562    0.0568    0.0575];
ids(5,:)=[0.0001    0.0148    0.0213    0.0240    0.0256    0.0267    0.0276    0.0284    0.0291    0.0298    0.0305    0.0312    0.0314    0.0323    0.0330 0.0336    0.0342    0.0348    0.0353    0.0359    0.0364    0.0370    0.0375    0.0380    0.0386    0.0392    0.0396    0.0404    0.0411    0.0418  0.0426    0.0433    0.0441];

vds = [0 0.25 0.5 0.75 1.0 1.25 1.5 1.75 2.0 2.25 2.5 2.75 3.0 3.25 3.5 3.75 4.0 4.25 4.5 4.75 5.0 5.25 5.5 5.75 6.0 6.25 6.5 6.75 7.0 7.25 7.5 7.75 8]; % DRAIN VOLTAGE(BIAS VOLTAGE)Taken while measuring


lower_limit = [0.0302 -2.154 3.041 -1.6816];
upper_limit = [0.425 0.81 6.24 -0.0193];
inf = 9999999;
scale(1, :) = 0.5*(upper_limit + lower_limit);
scale(2, :) = upper_limit - lower_limit;

totalIter = 100;
data = zeros(p + 2, totalIter);

for number = 1:totalIter

% Start clock    
tic

% Set the initial fitness to worst possible
Jbest = inf;

%Initialization of position(random placement on domain
P = repmat(lower_limit, s, 1) + repmat(upper_limit - lower_limit, s, 1).*rand(s, p);

%Parameter Initialization

% Adjust the step size of tumble and swim
C=0*ones(s, p);
for t = 1:s
    C(t, :) = 0.01*(upper_limit - lower_limit);
end
J = 0*ones(s, Nc);

l = 0;
k = 0;
j = 0;
i = 0;
w = 0;

% Start the optimization

% Elimination and Dispersal loop
while l < Ned
    l = l + 1;
    k = 0;
     j = 0;
     i = 0;
     % Reproduction loop
    while k < Nre
        k = k + 1;
        j = 0;
        i = 0;
        % Chemotaxis loop
        while j < Nc
            j = j + 1;
            i = 0;
            while i < s
                i = i + 1;
                % Evaluate fitness of the bacterium
                J(i, j) = error_mtkz(P(i, :), vds, vgs, ids);
                
                %Check if fitness beats the previous best of the colony
                %If it is, replace the values of the best position with the
                %current one.
                 if J(i,j) < Jbest
                    Jbest = J(i, j);
                    Pbest = P(i, :);
                 end
                 
                % Add the cell-to-cell function to the cost function.               
                J(i, j) = J(i, j) + bact_cellcell_attract_func(P(i, :), P(:, :), s, scale);                
                Jlast = J(i, j);
                
                % Pick a random direction and then make bacterium tumble.
                Delta(i, :)=(2*round(rand(1, p))-1).*rand(1, p); 
                P(i, :) = P(i, :) + C(i, :).*Delta(i, :)/sqrt(Delta(i, :)*(Delta(i, :)'));
               
                % Check if the bacterium has gone out of bounds of limits.
                % If it has, reset it to some random value within bounds.
                for d = 1:p
                        if P(i, d) < lower_limit(d) || P(i, d) > upper_limit(d)
                            P(i, d) = lower_limit(d) + (upper_limit(d) - lower_limit(d))*rand(1,1);
                        end
                end
                
                % After tumble step, check fitness again using the cell-to-cell function.                
                J(i, j) = error_mtkz(P(i,:), vds, vgs, ids);               
                J(i, j) = J(i, j) + bact_cellcell_attract_func(P(i,:), P(:,:), s, scale);
                
                m = 0;
                
                % The bacterium will now swim a distance set by Ns                
                while m<Ns 
                    
                    m = m+1;  
                    % If bacterium swims up nutrient gradient, allow it
                    % swim. Otherwise, stop it from swimming.
                    if J(i, j)< Jlast
                        
                        Jlast = J(i,j);
                        
                        P(i, :) = P(i, :) + C(i, :).*Delta(i, :)/sqrt(Delta(i, :)*(Delta(i, :)'));

                        J(i, j) = error_mtkz(P(i, :), vds, vgs, ids);                        
                         if J(i,j)<Jbest
                         Jbest = J(i,j);
                         Pbest = P(i, :);                       
                         end
                            
                            J(i, j) = J(i, j) + bact_cellcell_attract_func(P(i, :), P(:, :), s, scale);
                            
                     else
                                m = Ns;
                    
                     end

                    % Check the the bacterium is within bounds again and
                    % reset it to random value within bounds if it is not.
                     for d = 1:p
                        if P(i, d) < lower_limit(d) || P(i, d) > upper_limit(d)
                            P(i, d) = lower_limit(d) + (upper_limit(d) - lower_limit(d))*rand(1,1);
                        end
                        % Keep running score of best values of nutrient
                        % function seen so far.
                         w = w + 1;                         
                         W(w, 1) = Jbest;
                     end
                 end
            end
                    

        end
                  
        
       w = w + 1;
       W(w, 1) = Jbest;
     
        
        %Reproduction - sort according to health and kill the weakest half
        %of the population. Duplicate the healthiest parts and evolve
        %further.        
        Jhealth = sum(J(:,:), 2);         
        [Jhealth, sortind] = sort(Jhealth);        
        P(:, :) = P(sortind, :);
        
        for i = 1:Sr
            P(i + Sr, :) = P(i, :);
        end
        
    end
    
    % Check if bacteria colony can be dispersed due to harsh external
    % perturbation i.e. elimination and dispersal. If there is indeed such
    % a condition, reset the bacteria to random positions within the
    % limits.
    for m = 1:s
        if ped > rand
            P(m, :) = lower_limit + (upper_limit - lower_limit).*rand(1, p);
        end
    end

end
    
% Report best position and the best value of cost function along with time
% taken.
Pbest
Jbest
time = toc
% 
% %plot the results
%            for mm=1:length(vgs)
%            ids1 = mtkz(Pbest, vds, vgs);
%            end
%            plot (vds, ids, '*')
%            hold
%            plot(vds, ids1)
%            hold
data(1, number) = Pbest(1);
data(2, number) = Pbest(2);
data(3, number) = Pbest(3);
data(4, number) = Pbest(4);
data(5, number) = Jbest;
data(6, number) = time;
number
% 
% W_overall(number, :) = W;
end
        
        
                    
                                  
                

                
               
                
                
                
  
                
            
            



