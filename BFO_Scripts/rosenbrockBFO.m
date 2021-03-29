% Rosenbrock minimization using BFO %
% by Kalyan Sourav Dash  %
clear all;
close all;
clc;
% Bacteria Foraging Optimization %
% ------- initialisation ----------%
Ne=20;
Nr=20;
Nc=20;
Np=20;
Ns=10;
D=5;
C=0.01;
Ped=0.9; % elimination dispersion probability
x=(rand(Np,D)-0.5)*60; % x lies in [-30 30]
J=zeros(Np,1);
for k=1:Np
    for i=1:D-1
        
    J(k)=sum(100*(x(k,i+1)-x(k,i)^2)^2+(x(k,i)-1)^2); % initial fitness calculation
    
    end
end
Jlast=J;
for l=1:Ne
    for k=1:Nr
        Jchem=J;
        for j=1:Nc
            % Chemotaxis Loop %
            
            for i=1:Np
                del=(rand(1,D)-0.5)*2;
                x(i,:)=x(i,:)+(C/sqrt(del*del'))*del;
                for d=1:D-1
                    J(i)=sum(100*(x(i,d+1)-x(i,d)^2)^2+(x(i,d)-1)^2);
                end
              
                for m=1:Ns
                    if J(i)<Jlast(i)
                        Jlast(i)=J(i);
                        x(i,:)=x(i,:)+C*(del/sqrt(del*del'));
                        for d=1:D-1
                            J(i)=sum(100*(x(i,d+1)-x(i,d)^2)^2+(x(i,d)-1)^2);    
                        end
                    else
                        del=(rand(1,D)-0.5)*2;
                        x(i,:)=x(i,:)+C*(del/sqrt(del*del'));
                        for d=1:D-1
                            J(i)=sum(100*(x(i,d+1)-x(i,d)^2)^2+(x(i,d)-1)^2);    
                        end
                    end   
                end
                
            end
            
            Jchem=[Jchem J];
        end  % End of Chemotaxis %
        
        
            for i=1:Np
                Jhealth(i)=sum(Jchem(i,:)); % sum of cost function of all chemotactic loops for a given k & l
            end
            [Jhealth1,I]=sort(Jhealth,'ascend');
            x=[x(I(1:Np/2),:);x(I(1:Np/2),:)];
            J=[J(I(1:Np/2),:);J(I(1:Np/2),:)];
            xmin=x(I(1),:);
    end
    Jmin(l)=min(J);
    % random elimination dispersion
   
  for i=1:Np
        r=rand;
        if r>=Ped
            x(i,:)=(rand(1,D)-0.5);
            for d=1:D-1
                    J(i)=sum(100*(x(i,d+1)-x(i,d)^2)^2+(x(i,d)-1)^2);
            end
        end
    end
       
end
plot(Jmin);