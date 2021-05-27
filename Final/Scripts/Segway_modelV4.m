%% Version 4 deals with the angular movement of the segway and its control. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Km = 1;
%K1 = 2*Km*Ke;
%beta = 2*Mw + Mp + 2*Iw/(r.^2);
%alpha = Ip*beta + 2*Mp*(I.^2)*(Mw + Iw/(r.^2));
%Kw = 2*Mw + 2*Iw/(r.^2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Km = 0.062;
Ke = 0.062;
r = 1.6;
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
Bo = [0 ; 0 ; 0 ; 0;];

C = [1 0 0 0;
    0 0 1 0];             % We want the distance and the angle as the output. 

C_temp = [1 0 0 0];

D = [0; 0;];

X0 = [0 ;0 ;0 ;0;];             % For initializing the integrator.

sys = ss(A, B, C, D);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

q11 = 7.056311630519287;
q22 = 0.040608399663108;
q33 = 0.150562417774016;
q44 = 0.030452791998497;
R = 0.000016648572929;

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
s = tf('s');

sts_dist = tf([K(1)*0.05746, -K(1)*1.531e-16, -K(1)*3.12],[1, 41.12, 325.5, 1224, 2031]);     % For distance
sts_angle = tf([-K(1)*0.7141,-K(1)*1.018e-06,-K(1)*9.143e-15],[1, 41.12, 325.5, 1224, 2031]);       % For angle.

%% Plotting the params.

figure
subplot(311), impulse(sts_dist);   % Impulse reponse of distance
subplot(212), step(sts_dist);      % Step Response of distance
%% Developing the Controller for angular deviations

tf_turn = tf(Km,[r*Iw,Km*Ke,0]);