function J = Cost(parms)  
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

Q = [parms(1) 0 0 0;
    0 parms(2) 0 0;
    0 0 parms(3) 0;
    0 0 0 parms(4);];
R = parms(5);
try
    [K,S,e] = lqr(A,B,Q,R);
    Kvalue = K
    Qvalue = Q
    Rvalue = R
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    states = {'distance' 'speed' 'angle' 'angular velocity'};
    inputs = {'Voltage'};
    outputs = {'distance' 'angle'};
    
    % system = ss(A-B*K, B, C, D, 'statename',states,'inputname',inputs,'outputname',outputs);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    sts = tf([K(1)*0.05746, K(1)*7.145e-16, -K(1)*3.12],[1, 30.33, 284.3, 1202, 2028]);
    
    s = stepinfo(sts);
    J = abs(s.RiseTime)+ abs(s.SettlingTime) + abs(s.Overshoot);
    % riseTime = s.RiseTime
    % settlingTime = s.SettlingTime
    % overshoot = s.Overshoot
    
    % step(sts);
    % h = findobj(gcf,'type','line');
    % set(h,'linewidth',2);
    % drawnow
catch
    J = 10000;
    disp("LQR Can't be solved, so cost is taken some randomly high value");
end

end
