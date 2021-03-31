
% ======================================================================================================================
% 
% Program          :      Model Based Diagnosis Seminar
% Author           :      (1) Dinesh Thirumurugan, (2) Bhavesh Kataria ,(3) Allauddin Shaikh
% Date             :      04-11-2018
% Version          :      1.1
% Description      :      This program is used for initializing variables
% Called by        :      SEM_MBD_Bike_CMG.slx
% =======================================================================================================================

%% System Parameters 
% Here the parameters for the modelling of the complete system is defines(Bicycle and CMG)

Drw = 0.6;    %Diameter of rear wheel (in m)
Dfw = 0.6;    %Diameter of front wheel (in m)
T = 0.05;     %Wheel thickness (in m)
MR = 1;       %Mass of the rear wheel (in kg)
MF = 1;       %Mass of the rear wheel (in kg)
L = 2;        %Wheelbase (in m)
M = 10;        %Mass of the bicycle (in kg)
Rf = 0.2;     %Radius of the flywheel (in m)
Tf = 0.3/5;   %Thickness of the flywheel (in m)
Mf = 2;       %Mass of flywheel (in kg)
H = 1/2;      %Height of CMG (in m)
IntP = 0;     %Initial position of pendulum (in deg)
IntG = 70;    %Initial position of the CMG gimbal (in deg)

% %
% 
% Fly_R1 = Rf*0.75;
% Fly_R2 = Tf/2*1.01;
% Fly_R3 = Rf*0.35;
% Fly_R4 = Tf/2*1.01;
% Fly_R5 = Rf*0.35;
% Fly_R6 = -Tf/2*1.01;
% Fly_R7 = Rf*0.75;
% Fly_R8 = -Tf/2*1.01;



%% Desired Inputs
% Here the user defined input parameters for the bicycle and CMG function are defined 

% Input Flywheel Speed Block
Nf = 5000;    %Flywheel speed (in rpm)

%Input Desired Steering Parameters Block

%Left steering inputs
Tend = 35;    %Total time duration for simulation signal (in sec)
Ldelta = 15;  %Left steering angle (in deg) defines the angle input requried for left steering
tpdl = 10;    %Phase delay for left steering (in sec) defines the time duration after which the left steering angle input should be achived
tdl = 10;     %Duration for the left steering (in sec) defines the duration for which the left steering signal should be active

%Right steering inputs       
Rdelta = 0;   %Right steering angle (in deg) defines the angle input requried for right steering
tpdr = 1;     %Phase delay for right steering (in sec) defines the time duration after which the right steering angle input should be achived
tdr = 1;      %Duration for the right steering (in sec) defines the duration for which the right steering signal should be active

%Desired rear wheel velocity input
v = 5;        %Desired velocity (in km/h) defines the desired velocity input for the bicycle

%External Disturbance Enable/Disable
Switch = 0;    %The external disturbance to the pendulum is kept enabled or disabled using 1 or 0

%% Controller parameters

%PD Controller parameters for pendulum/bicycle lean stability
Kphi = -60;    %Proportional Gain for Phi 
Kphidot = -6;  %Derivative Gain for phi
Ktheta = 0.1;  %Proportional Gain for theta
Kthetadot = -5;%Derivative Gain gor theta
reftheta = 0;  %Reference position for gimbal angle (in deg)
refphi = 0;    %Reference position for the lean angle (in deg)

%PD Controller parameters for the steering torque of the bicycle
Kdelta = -2.5; %Proportional Gain for Delta 
Kdeltadot = -5;%Derivative Gain gor Delta

%P Controller parameters for the rear wheel velocity torque of the bicycle
Kv = -2.69;    %Proportional Gain for the rear wheel velocity torque of the bicycle

%% Floor parameters
Floor.l = 250/2;  %lenght of floor in m
Floor.w = 250/2;  % width of floor in m
Floor.h = 0.01;   % height of floor in m

% Grid parameters
Grid.clr = [1 1 1]*1;
Grid.numSqrs = 100;
Grid.lineWidth = 0.02;
Grid.box_h = (Floor.l-(Grid.lineWidth*(Grid.numSqrs+1)))/Grid.numSqrs;
Grid.box_l = (Floor.l-(Grid.lineWidth*(1+1)))/1;
Grid.extr_data = Extr_Data_Mesh(Floor.w,Floor.w,Grid.numSqrs,1,Grid.box_h,Grid.box_l);

%% Camera Setup
topCameraX = -4.5;
topCameraZ = -0.5;
topCameraY = 0;

followerCameraX = -1.5;
followerCameraZ = -3;
followerCameraY = 0.5;

isoCameraX = -3.1;
isoCameraY = 3.5;
isoCameraZ = 1.5;
isoCameraAimX = (1/2)*L;

IsoCameraDamping = 30;
IsoCameraStiffness = 5;
Filtering1Dto3DConnection = 0.1;


%% Scenario Descriptions 

%This performance of the bicycle and the control device (CMG) is validated through the following scenarios: 
%Scenario 1: This investigates the stabilization of the bicycle using CMG at static conditions, where the bicycle is at v=0; ?=0; and the disturbance is given to the pendulum as an external random torque inputs, which in turn is stabilized by the torque generated by the CMG.   
%Scenario 2: Here the stabilization property is analysed through dynamic of bicycle, where the disturbance to the pendulum is through the bicycle dynamics. The bicycle in this scenario is said to be at v>0; ?>0, whose stability is analysed through the inverted pendulum which in turn is stabilized by the CMG.   
%Scenario 3: The general behaviour of the bicycle dynamics is investigated in this scenario, here the control device is kept completely inactive and the pendulum is put at completely downward resting position. The bicycle is give a velocity v>0; and steering ?>0 for a specific time period to inspect the forces generated while cornering to produce a leaning behaviour by the pendulum approximating to that of the bicycle behaviour. 

%Scenario 1: Ldelta/Rdelta = 0; v = 0; Switch = 1; Nf = 5000; Kphi = -60; Kphidot = -6; Ktheta = 0.1; Kthetadot = -5;
%Scenario 2: Ldelta/Rdelta = 5; v = 5; Switch = 0; Nf = 5000; Kphi = -60; Kphidot = -6; Ktheta = 0.1; Kthetadot = -5;
%Scenario 3: Ldelta/Rdelta = 5; v = 5; Switch = 0; Nf = 0; Kphi = 0; Kphidot = 0; Ktheta = 0; Kthetadot = 0;
