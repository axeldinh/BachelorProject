function y1 = RK4_Int(f,T,y0,h)

t = T(1);
y1 = y0;

while t < T(2)
    
    if t+h < T(2)
        
        y1 = RK4(y1,t,h,f);
    
    else
        h = T(2)-t;
        y1 = RK4(y1,t,h,f);
    end
    
    t = t + h;
    
end