function [dy] = LaplaceFCN (s,y,b,c)
% Laplace function defines the ordinary differential equation that needs to
% be solved.


% Z = y(1); Z' = dZ/dS = dy(1); 
% X = y(2); X' = dX/dS = d(2);
% phi = y(3); phi ' = dphi/dS =dy(3);
% All the derivatives are with respect to arc-length s


% Z' = sin(phi);
% X' = cos(phi);
% phi' = 2/B + Z - (sin(phi)/X);



dy = zeros(5,1);


B = b*c^0.5;

dy(1) = sin(y(3));
dy(2) = cos(y(3));
dy(3) = (2/B) + y(1) - (sin(y(3))/y(2));
dy(4) = pi*(y(2)^2)*sin(y(3));
dy(5) = 2*pi*y(2);

end