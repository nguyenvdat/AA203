clc;clear;
A = [0 1; 0 -1];
B = [0; 1];
Q = [1 0; 0 0];
R = 3;
Qf = [0 0; 0 4];
tspan = [10 0];
opts = odeset('RelTol',1e-5,'AbsTol',1e-10);
[t,V] = ode45(@(t,V) LQR_ode(V,[2 2],A,B,Q,R), tspan, reshape(Qf, [], 1), opts);
n = size(t, 1);
V = reshape(V, [n, 2, 2]);
u = zeros(n, 1);
x = zeros(n, 2);
x_current = [1;1];
x(1,:) = x_current';
for i=1:n
    u(i,1) = -inv(R)*B'*squeeze(V(n+1-i,:,:))*x_current;
    x_current = A*x_current + B*u(i,1);
    x(i+1,:) = x_current';
end
plot(t,x(1:end-1, 1),'-o',t,x(1:end-1, 2),'-.')
% plot(t, x(1:end-1,:))
% [K,S,e] = lqr(A,B,Q,R)


