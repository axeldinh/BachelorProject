function y1 = RK4(y0,t0,h,f)

k1 = f(t0,y0);
k2 = f(t0 + h/2, y0 + h/2 * k1);
k3 = f(t0 + h/2, y0 + h/2 * k2);
k4 = f(t0 + h, y0 +h*k3);

y1 = y0 + (h/6)*(k1 + 2*k2 + 2*k3 +k4);