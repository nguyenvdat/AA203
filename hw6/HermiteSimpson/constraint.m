% Function providing equality and inequality constraints
% ceq(var) = 0 and c(var) \le 0

function [c,ceq] = constraint(var)

global N;
global T;

global y0;
global v0;
global m0;
global mf;

% Put here constraint inequalities
c = [];

% Note that var = [y;v;m;u]
y = var(1:N+1); v = var(N+2:2*N+2); m = var(2*N+3:3*N+3); u = var(3*N+4:4*N+4); % Note: var = [y;v;m;u]

% Computing dynamical constraints via the Hermite-Simpson rule
h = 1.0*T/(1.0*N);
[yDyn, vDyn, mDyn] = fDyn(y,v,m,u);
y_ic = 1/2*(y(1:end-1)+y(2:end)) + h/8*(yDyn(1:end-1)-yDyn(2:end));
v_ic = 1/2*(v(1:end-1)+v(2:end)) + h/8*(vDyn(1:end-1)-vDyn(2:end));
m_ic = 1/2*(m(1:end-1)+m(2:end)) + h/8*(mDyn(1:end-1)-mDyn(2:end));
u_ic = (u(1:end-1) + u(2:end))/2;
[y_ic_f, v_ic_f, m_ic_f] = fDyn(y_ic, v_ic, m_ic, u_ic);
y_ic_dot = -3/(2*h)*(y(1:end-1)-y(2:end)) - 1/4*(yDyn(1:end-1)+yDyn(2:end));
v_ic_dot = -3/(2*h)*(v(1:end-1)-v(2:end)) - 1/4*(vDyn(1:end-1)+vDyn(2:end));
m_ic_dot = -3/(2*h)*(m(1:end-1)-m(2:end)) - 1/4*(mDyn(1:end-1)+mDyn(2:end));
ceq(1:N) = y_ic_dot - y_ic_f;
ceq(N+1:2*N) = v_ic_dot - v_ic_f;
ceq(2*N+1:3*N) = m_ic_dot - m_ic_f;

% Put here initial and final conditions
ceq(1+3*N) = y(1) - y0;
ceq(2+3*N) = v(1) - v0;
ceq(3+3*N) = m(1) - m0;
ceq(4+3*N) = m(end) - mf;