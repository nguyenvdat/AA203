% Adjoints equations related to our rocket.

function zdot = Zdyn(t,z)
           
global g;
global b;
global uMax;

v = z(2);
m = z(3);
py = z(4);
pv = z(5);
pm = z(6);

phi = pv/m - pm*b; % TODO compute phi

% TODO use phi to compute control action
u = 0.0;
if phi < 0
    u = uMax;
end

zdot = [v; u/m - g; -b*u; 0; -py; pv*u/(m*m)];% TODO Rocket dynamics and adjoint equations