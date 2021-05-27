clear all;
close all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A22 = -0.0316;
A23 = 0.3817;
A42 = 0.3927;
A43 = 49.5531;

B2 = 0.05746;
B4 = -0.7141;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A = [0  1  0  0;
     0 A22 A23 0;
     0 0 0 1;
     0 A42 A43 0;];

B = [0 ; B2 ; 0 ; B4;];

C = [1 0 0 0;
    0 0 1 0];             % We want the distance and the angle as the output. 

C_temp = [1 0 0 0];

D = [0; 0;];

X0 = [0 ;0 ;0 ;0;];             % For initializing the integrator.

sys = ss(A, B, C, D);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Obtained by BFO
 q = [72471.87066219141 -0490.898006878771 -04750.45905426314 -05.18027662623499 0.401824162185799];
 
% q = [289.104 -5.15e-5 -5e-5 -5.1e-5 0.00028]; one mentioned in paper
Q = [
    q(1,1) 0 0 0;
    0 q(1,2) 0 0;
    0 0 q(1,3) 0;
    0 0 0 q(1,4);
];
R = q(1,5);

[K,S,e] = lqr(A,B,Q,R);
Kvalue = K
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
states = {'distance' 'speed' 'angle' 'angular velocity'};
inputs = {'Voltage'};
outputs = {'distance' 'angle'};
system = ss(A-B*K, B, C, D, 'statename',states,'inputname',inputs,'outputname',outputs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sts = tf([K(1)*0.05746, K(1)*7.145e-16, -K(1)*3.12],[1, 30.33, 284.3, 1202, 2028]);
% KValue = K
s = stepinfo(sts);
J = abs(s.RiseTime)+ abs(s.SettlingTime)+ abs(s.Overshoot);
step(sts);

% for i=1:10
%      s = history(:,:,i);
%      avg1(i) = mean(s(:,1));
%      avg2(i) = mean(s(:,2));
%      avg3(i) = mean(s(:,3));
%      avg4(i) = mean(s(:,4));
%      avg5(i) = mean(s(:,5));
%      
% end
% n = 1:1:10;
% figure('Name','Q1')
% plot(n,avg1)
% figure('Name','Q2')
% plot(n,avg2)
% figure('Name','Q3')
% plot(n,avg3)
% figure('Name','Q4')
% plot(n,avg4)
% figure('Name','R')
% plot(n,avg5)
    
