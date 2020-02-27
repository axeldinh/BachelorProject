function U = Num_Flux_Lax_Friedrich(u,F)

U = zeros(size(u));

u_tilde = [u(:,end), u, u(:,1)];

for i = 1:length(u(1,:))
    U(1,i) = -Lax_Friedrich_Flux(u_tilde(end,i),u_tilde(1,i+1),F);
    U(2,i) = Lax_Friedrich_Flux(u_tilde(1,i+2), u_tilde(end,i+1),F);
end

