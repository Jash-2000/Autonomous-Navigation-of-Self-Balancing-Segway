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
P_Block = tf(Kp,1);
I_Block = tf(Ki,[1,0]);
D_Block = tf(100*Kd, [1,100]);

% Time Constant should be 0.25