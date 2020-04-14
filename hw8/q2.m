V0 = [0; 0; 0; 0];
tspan = [0 10];
a = -1;
b = 3;
am = 4;
bm = 4;
gamma = 2;
opts = odeset('RelTol',1e-5,'AbsTol',1e-10);
[t,V] = ode45(@(t,V) ode_q2(V, a, b, am, bm, gamma, 4*sin(3*t)), tspan, V0, opts);

figure(1)
plot(t, V(:,1), 'r')
hold on
plot(t, V(:,2), 'b')

figure(2)
plot(t, V(:,3), 'r')
hold on
plot(t, ones(size(t))*bm/b, 'b')
hold on
plot(t, V(:,4), 'r')
hold on
plot(t, ones(size(t))*(a - am)/b, 'b')
