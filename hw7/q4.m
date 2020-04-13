clear; clc;
A = [0.99 1; 0 0.99];
B = [0; 1];
Q = [1 0; 0 1];
R = 1;
[P,L,d,d] = idare(A,B,Q,R,[],[]);

system = LTISystem('A', A + B*L);
system.x.min = [-5; -5];
system.x.max = [5; 5];
Po = Polyhedron('A', [L;-L], 'b', [0.5; 0.5]);
system.x.with('setConstraint');
system.x.setConstraint = Po;
Tset = system.invariantSet();
Tset.plot()

model  = LTISystem('A', A, 'B', B);
model.x.min = [-5; -5];
model.x.max = [5; 5];
model.u.min = -0.5;
model.u.max = 0.5;
model.x.penalty = QuadFunction(Q);
model.u.penalty = QuadFunction(R);
model.x.with('terminalSet');
Tset = model.LQRSet;
model.x.terminalSet = Tset;
model.x.with('terminalPenalty');
PN = model.LQRPenalty;
model.x.terminalPenalty = PN;
% ctrl = MPCController(model, 2);
expmpc = ctrl.toExplicit();
loop = ClosedLoop(ctrl, model);
x0 = [-4.7; 2];
[u, feasible, openloop] = ctrl.evaluate(x0)
Nsim = 30;
data = loop.simulate(x0, Nsim);

subplot(2,1,1)
plot(data.X(1,:), data.X(2,:));
hold on;
title('outputs')
subplot(2,1,2)
plot(1:Nsim, data.U);
hold on;
title('inputs')
