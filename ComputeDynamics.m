function [ddx, ddth] = ComputeDynamics
syms m1 m2 L b F g x dx ddx th dth ddth

A11 = m1 + m2;
A12 = 1/2*m2*L*cos(th);
A21 = 1/2*m2*L*cos(th);
A22 = 1/3*m2*L^2;

B1 = -b*dx + F - 1/2*m2*L*(dth)^2*sin(th);
B2 = -m2*g*L/2*sin(th);

A = [A11 A12; A21 A22];
B = [B1; B2];
ddVec = inv(A)*B;
ddx = ddVec(1);
ddth = ddVec(2);
