%% Ant colony optimization
Km = 0.062;
Ke = 0.062;
r = 1.6;
L = 1.2e-3;
l = 0.16;
Mw = 0.02;
Mp = 0.52;
Iw = 0.0032;
Ip = 0.0038;

tf_turn = tf(4*3.14*Km/r,[r*Iw,Km*Ke,0]);
%% Paramters

n_iter=1; %number of iteration
NA=30; % Number of Ants
alpha=0.8; % alpha
beta=0.2; % beta
roh=0.7; % Evaporation rate
n_param=3; % Number of paramters
LB=[0.1 0.5 0.1]; % lower bound
UB=[77 5 2]; % upper bound
n_node=1000; % number of nodes for each param

%% intializing some variables 
cost_best_prev=inf;
ant = zeros(NA,n_param);
cost = zeros(NA,1);
tour_selected_param = zeros(1,n_param);
param_mat = zeros(n_iter,n_param);
Nodes = zeros(n_node,n_param);
prob = zeros(n_node, n_param);

%% Generating Nodes
T=ones(n_node,n_param).*eps; % Phormone Matrix
dT=zeros(n_node,n_param); % Change of Phormone
for i=1:n_param
    Nodes(:,i) =linspace(LB(i),UB(i),n_node); % Node generation at equal spaced points
end

%% Iteration loop
for iter=1:n_iter
  
    for tour_i=1:n_param
        prob(:,tour_i)= (T(:,tour_i).^alpha) .* ((1./Nodes(:,tour_i)).^beta);
        prob(:,tour_i)=prob(:,tour_i)./sum(prob(:,tour_i));
    end
    
    for A=1:NA
        for tour_i=1:n_param
            node_sel=rand;
            node_ind=1;
            prob_sum=0;
            for j=1:n_node
                prob_sum=prob_sum+prob(j,tour_i);
                if prob_sum>=node_sel
                    node_ind=j;
                    break
                end
            end
            ant(A,tour_i)=node_ind;
            tour_selected_param(tour_i) = Nodes(node_ind, tour_i);
        end
        
        cost(A)=cost_func(tour_selected_param,0);
        clc
        disp(['Ant number: ' num2str(A)])
        disp(['Ant Cost: ' num2str(cost(A))])
        disp(['Ant Paramters: ' num2str(tour_selected_param)])
        if iter~=1
        disp(['iteration: ' num2str(iter)])
        disp('_________________')
        disp(['Best cost: ' num2str(cost_best)])
        for i=1:n_param
            tour_selected_param(i) = Nodes(ant(cost_best_ind,i), i);
        end
        disp(['Best paramters: ' num2str(tour_selected_param)])
        end
        
    end
    [cost_best,cost_best_ind]=min(cost);
    
    % Elitsem
    if (cost_best>cost_best_prev) && (iter~=1)
        [cost_worst,cost_worst_ind]=max(cost);
        ant(cost_worst_ind,:)=best_prev_ant;
        cost_best=cost_best_prev;
        cost_best_ind=cost_worst_ind;
    else
        cost_best_prev=cost_best;
        best_prev_ant=ant(cost_best_ind,:)
    end
    
    dT=zeros(n_node,n_param); % Change of Phormone
    for tour_i=1:n_param
        for A=1:NA
            dT(ant(A,tour_i),tour_i)=dT(ant(A,tour_i),tour_i)+cost_best/cost(A);
        end
    end
    
    T= roh.*T + dT;
  
    %% Plots , this section will not effect the algorithem
    % you can remove it to speed up the run
    cost_mat(iter)=cost_best;
    figure(1)
    plot(cost_mat)
    figure(2)
    for i=1:n_param
            tour_selected_param(i) = Nodes(ant(cost_best_ind,i), i);
    end
    cost_func(tour_selected_param,1);
    %% store data 
    param_mat(iter,:) = tour_selected_param;
    save('ACO_data.mat','cost_mat','param_mat')
    drawnow
end