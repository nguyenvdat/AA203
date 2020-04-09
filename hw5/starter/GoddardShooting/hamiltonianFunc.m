% Hamiltonian related to the Goddard's problem.

function H = hamiltonianFunc(y,v,m,py,pv,pm)

global g;
global b;
global uMax;

phi = pv/m - pm*b; % TODO compute phi

% TODO use phi to compute control action
u = 0.0;
if phi < 0
    u = uMax;
end

H = py*v + pv*(u/m - g) + pm*(-b*u);% TODO Return Hamiltonian H(y,v,m,ph,pv,pm)