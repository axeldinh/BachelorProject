clc
close all
clear all

%--Numerical approximation with DG method of du/dt+d[1/2*u^2]/dt = du/dt+u*du/dx=0 with x in [a,b]
%--With basis V = { 1-x , x } and the same test functions space

T = 1; %-- seconds, final time
a = -1;
b = 1;

F = @(u) 1/2*u.^2; %--Flux


%--Discretization of [a,b] in N elements

N = 100;

x = linspace(a,b,N+1)';
x_elem = [x(1:end-1) x(2:end)]';

h = x(2)-x(1); %--length of an element (if changes over elements create a vector)

%--Initial value

    %--u(x,0) = sin(pi*x);
    
u = sin(pi*x_elem);

    %--u(x,0) = 1 on x<0 and 0 on x>0

% u = 0*x_elem;
% for i = 1:2
%    for j = 1:length(x_elem(1,:));
%        if x_elem(i,j) > 0
%            u(i,j) = 0.5;
%        end
%        if x_elem(i,j) <0
%            u(i,j) = 1;
%         end
%     end
% end


h = x(2)-x(1); %--length of an element (if changes over elements create a vector)

%--Mass Matrix :

M = h*[1/3, 1/6;
    1/6, 1/3];

%--Stifness Matrix

S = [-1/2, -1/2;
    1/2, 1/2];

%--Numerical Flux, still need to figure it out
%{

% Num_Flux = @(u,x) [-u(1,1), -u(1,2:end);  
%     u(2,:)];
 
% Num_Flux =  @(u,x) [u(2,:) .* (1-x(2,:));
%   u(2,:).*x(2,:)] - [ [u(2,1)*(1-x(1,1)); u(2,1)*x(1,1)], [u(2,1:end-1).*(1-x(2,1:end-1));u(2,1:end-1).*(x(2,1:end-1))]];

%}

    %--Lax_Friedrich's Flux
Num_Flux = @(u,F) Num_Flux_Lax_Friedrich(u,F);


%--Derivative Matrix

du = @(t,u) M\(S*F(u) - Num_Flux(u,F)); %-- Function which is equal to u'


%--Discretization of time

dt = 0.0005;
t = 0;

Nsteps = T/dt; %--Number of time steps


saved = zeros(2,N+1); %--saved stores data for plotting
saved = u;


%--Solves the ode system with RK4

for i = 1:Nsteps
    u_tilde = RK4(u,t,dt,du);
    u = u_tilde;
    t = t + dt;
    saved = [saved u];
end

saved = reshape(saved, 2, N, Nsteps+1);

%--Plotting

for i = 1:length(saved(1,1,:))
    plot(x_elem,saved(:,:,i))
%     hold on
%     plot(x_elem(2,:),saved(2,:,i))
%     hold off
    %axis([a b -2 2]);
    text(1.02,10,'Time')
    text(1.02,0,num2str((i-1)*dt));
    pause(.01);
end