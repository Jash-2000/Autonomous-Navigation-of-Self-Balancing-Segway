clear all;
close all;
clc;
% Bacteria Foraging Optimization %
% ------- initialisation ----------%
Ne=10;
Nr=10;
Nc=10;
Np=5;
Ns=8;
D=5;
C=0.01;
Ped=0.9; % elimination dispersion probability

% initializing bacteria with proper of x for which ricatti equation is
% solvable
x=  [ 7.000000000000000   0.500000000000000                   0                   0   0.000100000000000;
   7.788751273517272   0.347898695070861   0.163385655339712   0.038252544147685   0.000007336042891;
   7.126858683930900   0.040608399663108   0.150562417774016   0.049294271749241   0.000093622850008;
   8.112320210505949   0.368102915584891   0.480736836721369   0.025368836870055   0.000076636604052;
   8.628307695765541   0.199041455630806   0.188079154272970   0.029127853009886   0.000016648572929;];
    
J=zeros(Np,1);
for k=1:Np 
        J(k,1) = Cost([x(k,1) x(k,2) x(k,3) x(k,4) x(k,5)]); % initial fitness calculation
end
Jlast=J;
for l=1:Ne
    for k=1:Nr
        Jchem=J;
        for j=1:Nc
            % Chemotaxis Loop %
            for i=1:Np-1
                del=(rand(1,D)-0.5)*2;
                x(i,:)=x(i,:)+(C/sqrt(del*del'))*del;
                J(i) = Cost([x(i,1) x(i,2) x(i,3) x(i,4) x(i,5)]);
              
                for m=1:Ns
                    if J(i)<Jlast(i)
                        Jlast(i)=J(i);
                        x(i,:)=x(i,:)+C*(del/sqrt(del*del'));
                        J(i) = Cost([x(i,1) x(i,2) x(i,3) x(i,4) x(i,5)]);
                    else
                        del=(rand(1,D)-0.5)*2;
                        x(i,:)=x(i,:)+C*(del/sqrt(del*del'));
                        J(i) = Cost([x(i,1) x(i,2) x(i,3) x(i,4) x(i,5)]);
                    end   
                end
                
            end
            
            Jchem=[Jchem J];
        end  % End of Chemotaxis %
        
        
            for i=1:Np-1
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
            J(i) = Cost([x(i,1) x(i,2) x(i,3) x(i,4) x(i,5)]);
        end
    end
       
end
plot(Jmin);