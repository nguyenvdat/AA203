
function dVdt = ode_q2(V, a, b, am, bm, gamma, r)
    y = V(1);
    ym = V(2);
    kr = V(3);
    ky = V(4);
    dVdt = zeros(4,1);
    dVdt(1,1) = b*(kr*r + ky*y) - a*y;
    dVdt(2,1) = bm*r - am*ym;
    dVdt(3,1) = -sign(b)*gamma*(y - ym)*r;
    dVdt(4,1) = -sign(b)*gamma*(y - ym)*y;
end