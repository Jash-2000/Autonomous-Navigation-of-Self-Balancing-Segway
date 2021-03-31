% Code to plot simulation results from Coll3D_07_Balls_and_Sliding_Tube
%
% Copyright 2015-2018 The MathWorks, Inc.

% Reuse figure if it exists, else create new figure
try
    figure(h1_Coll3D_07_Balls_and_Sliding_Tube)
catch
    h1_Coll3D_07_Balls_and_Sliding_Tube=figure('Name','Coll3D_07_Balls_and_Sliding_Tube');
end

% Generate simulation results if they don't exist
if(~exist('simlog_Coll3D_07_Balls_and_Sliding_Tube','var'))
    sim('Coll3D_07_Balls_and_Sliding_Tube')
end

% Get tube dimensions from model workspace
temp_hws = get_param(bdroot,'modelworkspace');
temp_tube = temp_hws.getVariable('tube');
temp_ball = temp_hws.getVariable('ball');

% Get simulation results
temp_bpx_in = simlog_Coll3D_07_Balls_and_Sliding_Tube.Bushing_Joint_In.Px.p.series.values;
temp_bpy_in = simlog_Coll3D_07_Balls_and_Sliding_Tube.Bushing_Joint_In.Py.p.series.values;
temp_bpz_in = simlog_Coll3D_07_Balls_and_Sliding_Tube.Bushing_Joint_In.Pz.p.series.values;

temp_bpx_out = simlog_Coll3D_07_Balls_and_Sliding_Tube.Bushing_Joint_Out.Px.p.series.values;
temp_bpy_out = simlog_Coll3D_07_Balls_and_Sliding_Tube.Bushing_Joint_Out.Py.p.series.values;
temp_bpz_out = simlog_Coll3D_07_Balls_and_Sliding_Tube.Bushing_Joint_Out.Pz.p.series.values;

% Plot results
plot3(-temp_bpz_in,-temp_bpx_in,temp_bpy_in,'r','LineWidth',2);
grid on
box on
hold on
plot3(-temp_bpz_out,-temp_bpx_out,temp_bpy_out,'Color',[0.6 0.6 0.6],'LineWidth',2);

% Plot tube
[temp_tubex, temp_tubey, temp_tubez] = cylinder([1 1],100);
tube_h = surf(temp_tubez*temp_tube.length-temp_tube.length/2,temp_tubex*temp_tube.inner_rad,temp_tubey*temp_tube.inner_rad);
set(tube_h,'EdgeColor','none','DiffuseStrength',1,'AmbientStrength',1,'FaceColor',[0.0 0.5 0.7],'FaceAlpha',0.7);

% Plot ball
[temp_ballx, temp_bally, temp_ballz] = sphere(100);
ball_h = surf(...
    temp_ballx*temp_ball.rad-temp_bpz_in(1),...
    temp_bally*temp_ball.rad-temp_bpx_in(1),...
    temp_ballz*temp_ball.rad+temp_bpy_in(1));
set(ball_h,'EdgeColor','none','AmbientStrength',1,'FaceColor',[0.8 0.0 0.2],'FaceAlpha',0.4);

ballout_h = surf(...
    temp_ballx*temp_ball.rad-temp_bpz_out(1),...
    temp_bally*temp_ball.rad-temp_bpx_out(1),...
    temp_ballz*temp_ball.rad+temp_bpy_out(1));
set(ballout_h,'EdgeColor','none','AmbientStrength',1,'FaceColor',[0.6 0.6 0.6],'FaceAlpha',0.4);

lightangle(-45,30)

hold off
axis equal
%axis([[-1 1]*temp_tube.length/2*2 [-1 1 -1 1]*temp_tube.outer_rad])
title('Ball Position in Tube (m)');

% Remove temporary variables
clear temp_bpx_in temp_bpy_in temp_bpz_in 
clear temp_bpx_out temp_bpy_out temp_bpz_out 
clear tube_h temp_cylx temp_cyly temp_cylz
clear temp_tubex temp_tubey temp_tubez
clear temp_ballx temp_bally temp_ballz
clear temp_hws temp_ball temp_tube