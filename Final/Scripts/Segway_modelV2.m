%% Version 2 deals with development of the LQR controller on simulink using the predefined functions and given Q and R.
%%    This is a naive approach wherin we are using the simulink based block diagram to get the responses of individual parameters.


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

q11 = 8.969;
q22 =0.308;
q33 =0.121;
q44 =0.0085;
R = 2.123e-5;

Q = [
    q11 0 0 0;
    0 q22 0 0;
    0 0 q33 0;
    0 0 0 q44;
];

[K,S,e] = lqr(A,B,Q,R);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
system = ss(A-B*K, B, C, D);
