%% Version 3 deals with the calculations and parameter estimation intelligent control. 
%%      We deal with a MIMO system here with state feedback topology. We have derived the transfer functions of individual interacting 
%%      elements and the resut obtained in simulink is thus, verified.

clear all;
close all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Km = 1;
%K1 = 2*Km*Ke;
%beta = 2*Mw + Mp + 2*Iw/(r.^2);
%alpha = Ip*beta + 2*Mp*(I.^2)*(Mw + Iw/(r.^2));
%Kw = 2*Mw + 2*Iw/(r.^2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

R = 1.6;
L = 1.2e-3;
l = 0.16;
Mw = 0.02;
Mp = 0.52;
Iw = 0.0032;
Ip = 0.0038;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % X = [x , x_dot , theta , theta_dot]
  
    % X_dot = AX + BU
    % Y = CX + DU
    
    % Here, x is a state variable and X is the state matrix itself.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

q11 = 72471.87066219141;
q22 = -0490.898006878771 ;
q33 = -04750.45905426314;
q44 =  -05.18027662623499 ;
R = 0.401824162185799;

Q = [
    q11 0 0 0;
    0 q22 0 0;
    0 0 q33 0;
    0 0 0 q44;
];

[K,S,e] = lqr(A,B,Q,R);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
states = {'distance' 'speed' 'angle' 'angular velocity'};
inputs = {'Voltage'};
outputs = {'distance' 'angle'};

system = ss(A-B*K, B, C, D, 'statename',states,'inputname',inputs,'outputname',outputs);

%% In the command window, type tf(system)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sts_dist = tf([K(1)*0.05746, K(1)*7.145e-16, -K(1)*3.12],[1, 30.33, 284.3, 1202, 2028]);     % For distance
sts_angle = tf([K(1)*-0.7141,K(1)*- 1.018e-06,K(1)*- 5.936e-15],[1,30.33,284.3,1202,2028]);       % For angle.

step(sts_angle);
step(sts_dist);

