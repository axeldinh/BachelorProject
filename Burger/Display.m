function [] = Display(x,saved, t0, dt, Pause)

%--Displays saved in time

for i = 1:length(saved(1,1,:))
    
   plot(x,saved(:,:,i))
   xlabel("Time = " + num2str(t0 + (i-1)*dt))
   pause(Pause);
end