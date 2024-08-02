% Run LQR to balance inverted pendulum on cart
% Used to gather Input/Output data to train NN
function [th_LQR, F_LQR] = LQR_pendulum()
% q = [x;dx;th;dth]
% u = F

% Define Parameters
m1val = 2;
bval = 0.5;
Lval = 1;
gval = 10;
m2val = 1;

% Define Operating Point - Upright Pendulum Position
OP = [0;0;pi;0];

% Nonlinear Dynamics
% Compute Nonlinear Dynamics
[ddx, ddth] = ComputeDynamics;

f1 = ddx;
f2 = ddth;

% Linearized dynamics 
syms x dx th dth F m1 m2 b L g
q = [x; dx; th; dth];
u = F;

% A matrix
Asym = jacobian([dx; f1; dth; f2], q);
A_OP = subs(Asym, q, OP);
A = subs(A_OP, {m1 b L g m2}, {m1val bval Lval gval m2val})

% B matrix
Bsym = jacobian([dx; f1; dth; f2], u);
B_OP = subs(Bsym, q, OP);
B = subs(B_OP, {m1 b L g m2}, {m1val bval Lval gval m2val})

% Define quadratic cost for infinite time horizon
Q = eye(4);
R = 1;

% Compute gain matrix with LQR
K = lqr(double(A),double(B),Q,R)


% Define Parameters for nonlinear simulation
m1 = 2;
b = 0.5;
L = 1;
g = 10;
m2 = 1;

% Dynamics of nonlinear feedback-controlled pendulum
odecon = @(t,q) [q(2); ...
    (3*L*g*m2*cos(q(3))*sin(q(3)))/(4*L*m1 + 4*L*m2 - 3*L*m2*cos(q(3))^2) - ...
    (4*((L*m2*sin(q(3))*q(4)^2)/2 - (-K(3)*(q(3)-OP(3))) + b*q(2)))/(4*m1 + 4*m2 - 3*m2*cos(q(3))^2); ...
    q(4);
    (6*cos(q(3))*((L*m2*sin(q(3))*q(4)^2)/2 - (-K(3)*(q(3)-OP(3))) + b*q(2)))/(4*L*m1 + 4*L*m2 - ...
    3*L*m2*cos(q(3))^2) - (6*L*g*m2*sin(q(3))*(m1 + m2))/(4*L^2*m2^2 - ...
    3*L^2*m2^2*cos(q(3))^2 + 4*L^2*m1*m2)];

% Simulate
tspan = [0 30];
q0 = [0; 0; pi+pi/12; 0];

% Nonlinear simulation of controlled pendulum
[tcon, qcon] = ode45(odecon, tspan, q0);


figure
subplot(4,1,1)
plot(tcon,qcon(:,1))
title('Plot of x Over Time')
ylabel('x')
xlabel('t')

subplot(4,1,2)
plot(tcon,qcon(:,2))
title('Plot of dx/dt Over Time')
ylabel('dx/dt')
xlabel('t')

subplot(4,1,3)
plot(tcon,qcon(:,3))
title('Plot of th Over Time')
ylabel('th')
xlabel('t')

subplot(4,1,4)
plot(tcon,qcon(:,4))
title('Plot of dth/dt Over Time')
ylabel('dth/dt')
xlabel('t')

sgtitle('State Plots')

figure
plot(tcon,-K(3)*(qcon(:,3)-OP(3)))
title('Plot of F Over Time')
ylabel('F')
xlabel('t')

%% Plot of Input/Output Data
Fvec_data = -K(3)*(qcon(:,3)-OP(3));
thvec_data = qcon(:,3);

figure
plot(thvec_data,Fvec_data)
title('Input/Output Data LQR')
ylabel('F')
xlabel('\theta')

clc
close all
th_LQR = thvec_data;
F_LQR = Fvec_data;