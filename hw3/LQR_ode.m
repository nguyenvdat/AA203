function dVdt = LQR_ode(V, shape, A, B, Q, R)
    V = reshape(V, shape);
    dVdt = Q - V*B*inv(R)*B'*V + V*A + A'*V;
    dVdt = -reshape(dVdt, [], 1);
end