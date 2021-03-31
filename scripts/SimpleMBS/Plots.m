%% Omega Plot
figure;
plot(Omega.Time,Omega.Data,'LineWidth',2);
title('Omega Vs Time Plot')
legend(' {\it \omega} in rad/s');
xlabel(' Time{\it T} in sec','FontWeight','bold');
ylabel('Flywheel spinning rate{\it \omega} in rad/s','FontWeight','bold');
xlim([0 35]);
ylim([0 1000]);

%% X-Y Plot Path
figure;
plot(X.Data,Y.Data,'LineWidth',2);
hold on
plot(X.Data(1),Y.Data(1),'rdiamond','MarkerEdgeColor','k','MarkerSize',10,'MarkerFaceColor',[0 1 0]);
% set(h,X.Data(1),Y.Data(1));[.49 1 .63]
title('Bicycle Position on the X-Y Plane');
xlabel('Longitudinal Distance{\it x} in m');
ylabel('Lateral Distance{\it y} in m');
xlim([-20 30]);
ylim([-50 40]);
txt = '  \leftarrow Start Point';
text(X.Data(1),Y.Data(1),txt)
hold on
plot(X.Data(end),Y.Data(end),'rdiamond','MarkerEdgeColor','k','MarkerSize',10,'MarkerFaceColor',[1 0 0]);
txt1 = '  \leftarrow End Point';
text(X.Data(end),Y.Data(end),txt1);

%% Orientation Plot
figure;
plot(Psi.Time,Psi.Data,'LineWidth',2);
title('Orientation Vs Time Plot')
legend(' {\it \psi} in deg');
xlabel(' Time{\it T} in sec','FontWeight','bold');
ylabel('Orientation {\it \psi} in deg','FontWeight','bold');
xlim([0 35]);
ylim([-100 100]);

%% Steering Angle Plot - Delta

figure;
plot(Delta.Time,Delta.Data,'LineWidth',2);
title('Steering Vs Time Plot')
legend(' {\it \delta} in deg');
xlabel(' Time{\it T} in sec','FontWeight','bold');
ylabel('Steering Angle{\it \delta} in deg','FontWeight','bold');
xlim([-0 35]);
ylim([-10 10]);

%% Bike Lean Angle Plot

figure;
plot(Phi.Time,Phi.Data,'LineWidth',2);
title('Lean Angle vs Time Plot')
legend(' {\it \phi} in deg');
xlabel(' Time{\it T} in sec','FontWeight','bold');
ylabel('Lean Angle{\it \phi} in deg','FontWeight','bold');
xlim([-0 50]);
ylim([3.1 3.2]);

%% Gimbal Angle Plot

figure;
plot(Theta.Time,Theta.Data,'LineWidth',2);
title('Gimbal Precision Angle Vs Time Plot')
legend(' {\it \theta} in deg');
xlabel(' Time{\it T} in sec','FontWeight','bold');
ylabel('Gimbal Precision Angle{\it \theta} in deg','FontWeight','bold');
xlim([-0 35]);
ylim([0 150]);

%% External Disturbance plot

figure;
plot(U_ex.Time,U_ex.Data,'LineWidth',2);
title('External Disturbance Vs Time Plot')
legend(' {\it U_{ex}} in Nm');
xlabel(' Time{\it T} in sec','FontWeight','bold');
ylabel('External Disturbance{\it U_{ex}} in Nm','FontWeight','bold');
xlim([-0 35]);
ylim([-20 20]);


%% Lean Rate Plot


figure;
plot(PhiDot.Time,PhiDot.Data,'LineWidth',2);
title('PhiDot Vs Time Plot')
legend('{\it \phidot} in rad/s');
xlabel(' Time{\it T} in sec','FontWeight','bold');
ylabel('Lean Angle{\it \phidot} in rad/s','FontWeight','bold');
xlim([-0 35]);
ylim([-10 10]);

%% Steering Rate Plot

figure;
plot(DeltaDot.Time,DeltaDot.Data,'LineWidth',2);
title('DeltaDot Vs Time Plot')
legend('{\it \deltadot} in rad/s');
xlabel(' Time{\it T} in sec','FontWeight','bold');
ylabel('Steering Rate{\it \deltadot} in rad/s','FontWeight','bold');
xlim([-0 35]);
ylim([-10 10]);


%% Gimbal Precision Rate 

figure;
plot(DeltaDot.Time,DeltaDot.Data,'LineWidth',2);
title('ThetaDot Vs Time Plot')
legend('{\it \thetadot} in rad/s');
xlabel(' Time{\it T} in sec','FontWeight','bold');
ylabel('Gimbal Precision Rate{\it \thetadot} in rad/s','FontWeight','bold');
xlim([-0 35]);
ylim([-10 10]);

%% Desired Steering Input

figure;
plot(DeltaDesired.Time,DeltaDesired.Data,'LineWidth',2);
title('Desired Steering Angle Input Vs Time Plot')
legend(' {Desired \it \delta } in deg');
xlabel(' Time{\it T} in sec','FontWeight','bold');
ylabel('Desired Steering Input {\it \delta} in deg','FontWeight','bold');
xlim([0 50]);
ylim([-20 20]);

