function Error = ContactFcn (X)

global  sf rho_l rho_f g xcut zcut

S_span = [0:0.01:10];
c = abs(rho_l - rho_f)*g/X(1);
% c = X(1);
b = X(2);


[S,Y] = ode45(@LaplaceFCN, S_span, [0 1e-100 0 0 0], [], b, c);
Z = Y(:,1);

i=1;
while Z(i)<Z(i+1)
    
    i=i+1;
    
end

x_yl (1:i,1) = Y(1:i,2);
z_yl (1:i,1) = Y(1:i,1);
% S_yl (1:i,1) = S(1:i,1);
% phi_yl (1:i,1) = Y (1:i,3)*180/pi;

xcut_nd = (c^0.5)*xcut/sf;
zcut_nd = (c^0.5)*zcut/sf;

[m,n] = min(abs(zcut_nd(end)-z_yl(:,1)));
% Error = abs((xcut_nd (end)) - (x_yl (n)));
% Error = sqrt((zcut_nd(end)-z_yl(n))^2+(xcut_nd(end)-x_yl(n))^2);
Error = 0.5*((zcut_nd(end)-z_yl(n))^2+(xcut_nd(end)-x_yl(n))^2);
