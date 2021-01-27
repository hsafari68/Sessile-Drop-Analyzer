function [X,Y,H] = circle(center, radius,nop,style)

if nargin < 3
    
    error ('Not enough input arguments!!')
    
elseif nargin == 3
    
    style= 'b-';
    
end

theta = linspace(0,2*pi,nop);
rho = ones(1,nop)*radius;
[X,Y] = pol2cart(theta,rho);

X = X + center(1);
Y = Y + center(2);

% H = plot(X,Y,style);
axis square;