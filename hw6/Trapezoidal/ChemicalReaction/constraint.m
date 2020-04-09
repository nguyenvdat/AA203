% Function providing equality and inequality constraints
% ceq(var) = 0 and c(var) \le 0 

function [c,ceq] = constraint(var)

global N;
global T;

global x0;
global y0;

% Note that var = [x;y;u]
x = var(1:N+1); y = var(N+2:2*N+2); u = var(2*N+3:3*N+3);

% Put here constraint inequalities
for i = 1:N+1
    c(i) = x(i) - 1;
    c(i+N+1) = y(i) - 1;
    c(i+2*(N+1)) = u(i) - 1;
    c(i+3*(N+1)) = -x(i);
    c(i+4*(N+1)) = -y(i);
    c(i+5*(N+1)) = -u(i);
end

% Computing dynamical constraints via the trapezoidal rule
h = 1.0*T/(1.0*N);
for i = 1:N
    % Provide here dynamical constraints via the trapeziodal formula
    ceq(i) = x(i+1) - x(i) - h*(-x(i)*u(i)+y(i)*u(i)*u(i) - x(i+1)*u(i+1)+y(i+1)*u(i+1)*u(i+1))/2;
    ceq(i+N) = y(i+1) - y(i) - h*(x(i)*u(i)-3*y(i)*u(i)*u(i) + x(i+1)*u(i+1)-3*y(i+1)*u(i+1)*u(i+1))/2;
end

% Put here initial conditions
ceq(1+2*N) = x(1)-1;
ceq(2+2*N) = y(1);