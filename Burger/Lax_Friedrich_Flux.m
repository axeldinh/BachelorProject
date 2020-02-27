function u = Lax_Friedrich_Flux(u1,u2,F)

%-- Computes the Lax_Friedrich's numerical flux at the interface
%-- u1 is the exterior value while u2 is the interior value
%-- F is the flux

c = max(u1,u2);

u = 1/2*(F(u1) + F(u2)) - c/2 * (u1 - u2);