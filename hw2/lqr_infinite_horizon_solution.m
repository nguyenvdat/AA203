function [L, P] = lqr_infinite_horizon_solution(Q, R)

%% find the infinite horizon L and P through running LQR back-ups
%%   until norm(L_new - L_current, 2) <= 1e-4  
dt = 0.1;
mc = 10; mp = 2.; l = 1.; g= 9.81;

% TODO write A,B matrices
a1 = mp*g/mc;
a2 = (mc + mp)*g/(l*mc);
df_ds = [0 0 1 0; 0 0 0 1; 0 a1 0 0; 0 a2 0 0];
df_du = [0; 0; 1/mc; 1/(l*mc)];
A = eye(4) + dt*df_ds;
B = dt*df_du;

% TODO implement Riccati recursion
L_current = 1e9*ones(1,4);
P = eye(4);
Q = eye(4);
R = 1;
while true
    L_new = -inv(R + B'*P*B)*(B'*P*A);
    P = Q + L_new'*R*L_new + (A + B*L_new)'*P*(A + B*L_new);
    if norm(L_new - L_current) <= 1e-4
        break
    end
    L_current = L_new;
end
L = L_current;
end