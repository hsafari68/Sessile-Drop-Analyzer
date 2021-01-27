%% Start
clc;
clear;
close all;

global sf rho_l rho_f g xcut zcut
load sf.mat;

%% Fluid properties

prompt = {'liquid density, g/cm^3', 'bulk density, g/cm^3'};
label = 'Fluid properties:';
defaults = {'0.8987','1.031'};
options.Resize = 'on';
params = inputdlg (prompt,label,repmat([1 50],2,1),defaults,options);
rho_l = str2num(params{1}); %#ok
rho_f = str2num(params{2}); %#ok
g = 981.7; 
% sig = str2num(params{4}); %#ok

%% Read image from file

[filename, pathname] = uigetfile(...
                                               {'*.bmp;*tif;*.gif;*.png;*.jpg','Image Files(*.bmp,*.tif,*.gif,*.png,*.jpg)';
                                                '*.*','All Files(*.*)'},...
                                               'Pick an Image');
% fid = fopen ('pathname.dat','w');
% fprintf(fid,'%s',pathname);
% fclose(fid);

image = imread([pathname,filename]);
image = rgb2gray(image);

choice = questdlg('Does this image need to be cropped? ', ...
	'Image cropping', ...
	'Yes','No','No');


switch choice
    case 'Yes'
        c_image = imcrop (image);
    case 'No'
        c_image = image;
end

% anglecr = questdlg('What is the image angle?  ', ...
% 	'Contact angle criteria:', ...
% 	'Greater than 90','Less than 90','Greater than 90');

imshow(c_image);

%% Primary image analysis
tic;
thresh = graythresh(c_image);
BW = imbinarize(c_image,thresh);

E = bwperim(BW);

% cu=5; 
% Trimmed_image = c_image (cu: size(c_image,1)-cu,cu:size(c_image,2)-cu);
% BW = BW (cu: size(BW,1)-cu,cu:size(BW,2)-cu);
% E = E (cu: size(E,1)-cu,cu:size(E,2)-cu);

imshow(BW,[]);

%% Tracing the image boundary

contour = bwtraceboundary (BW, [1,1], 'S');
bound1=contour(find(contour(:,2)==(size(BW,2)-1), 1, 'last' ):length(contour(:,1))-max(contour(:,1)),1);
bound2=contour(find(contour(:,2)==(size(BW,2)-1), 1, 'last' ):length(contour(:,1))-max(contour(:,1)),2);

bound=[bound2,bound1];
flip_bound=flipud(bound);

% Approximate apex coordinates
z = min(flip_bound(:,2));
x = flip_bound(round(mean(find(flip_bound(:,2)==z))),1);

hold on
plot(x,z,'bo')
hold on
plot(flip_bound(:,1),flip_bound(:,2),'r','LineWidth',2);
legend('Apex','Drop edge');

%% Data transformation

% Setting the apex to (0,0)
z_surf = flip_bound(:,2) - z;
x_surf = flip_bound(:,1) - x;

% Finding the left and right Z-plane
xind = round(mean(find(flip_bound(:,2)==z)));

left = z_surf(1);
right = z_surf(end);

pindleft = find(z_surf>= left-1 & z_surf <=left+1);
pindright = find(z_surf>= right-1 & z_surf<=right+1);

idxlf = find(pindleft<xind);
idxrt = find(pindright>xind);

lpidx = pindleft(idxlf);
rpidx = pindright(idxrt);

% Height determination

Leftplane = z_surf(lpidx);
Rightplane = z_surf(rpidx);

lfavg = mean(Leftplane);
rtavg = mean(Rightplane);

lr =[lfavg rtavg];

p = round(mean(lr)); % Height

% Equator radius calculation

dh = p;
cutoff = round(0.95*dh); % 5 percent cuttoff

idx = find(z_surf<=cutoff);
start = idx(1);
finish = idx(end);

xcut = x_surf (start:finish);
zcut = z_surf (start:finish);


xeqpleft = xcut(1); % left contact point x-coordinates
xeqpright = xcut(end); % right contact point x-coordinates


% xeqpleft = min(xcut); % left contact point x-coordinates
% xeqpright = max(xcut); % right contact point x-coordinates

xeqpleft_cm = xeqpleft/sf; % left contact point in cm
xeqpright_cm = xeqpright/sf; % right contact point in cm

er = 0.5*(abs(xeqpleft_cm)+abs(xeqpright_cm)); % wetted radius
Xequator = 2*max(abs(xcut/sf))*10;

Eq_diameter = Xequator;
Wet_diameter = 2*er*10;
% idxlefteq = find(xcut == xeqpleft);
% idxrighteq = find(xcut == xeqpright);
% 
% zeqpleft = mean(zcut(idxlefteq)); % left contact point z-coordinates
% zeqpright = mean(zcut(idxrighteq)); % right contact point z-coordinates

zeqpleft = zcut(1);
zeqpright = zcut(end);


% [xeqpleft,xeqpright]
% [zeqpleft,zeqpright]

% figure;
% plot(x_surf,z_surf,'bo')
% hold all
% plot(xcut,zcut,'y','LineWidth',2)
% plot([xeqpleft,xeqpright],[zeqpleft,zeqpright],'gs','MarkerFaceColor','g')
% set(gca,'YDir','reverse');

%% Spherical cap approximation

zp = [zeqpleft,zeqpright];
xp = [xeqpleft,xeqpright];

ma = zp(1)/xp(1);
mb = zp(2)/xp(2);

xcenter = (ma*mb*(zp(2)-zp(1))+mb*xp(1)-ma*xp(2))/(2*(mb-ma));
zcenter = ((-1/ma)*(xcenter-(xp(1)/2)))+(zp(1)/2);

radius = sqrt(xcenter^2+zcenter^2);
center = [xcenter, zcenter];
nop=1000;
[Xnew,Znew] = circle(center, radius,nop);

value1 = Znew-dh;
value2 = abs(value1);
value3 = min(value2);

index = find(value2 == value3);

xx = Xnew (index);
zz = Znew (index);

xd = xcenter - xx;
zd = zcenter - zz;

theta_a = atan(zd/xd);
theta_a = abs(theta_a);

rad_angle1 = theta_a+(pi/2);
rad_angle2 = rad_angle1*180/pi;

bl90angle =mod (180-rad_angle2,180);
gr90angle = mod(180+rad_angle2,180);

%% Applying GA-PS to tune fis parameters

Var_Num = 2;  % Number of coefficients to determine

% GA constraints
% Upper bound on the design variables: lb <= x <= ub
% If bounds are set to scalars, they will automatically propagate to all variables
lb=[8,0.001];
ub=[50,50];
A = [];  % Linear inequality constraint: A*X <= b
bin= [];  % Linear inequality constraint: A*X <= b
Aeq = [];  % Linear equality constraint: Aeq*X = beq 
beq = [];  % Linear equality constraint: Aeq*X = beq
nonlcon = [];  % A function returning the nonlinear inequality (C(x)<=0) and equality (Ceq(x)=0) vectors

% Crucial GA and PS options
PopulationSize = 30;  % Number of individuals at each generation
Generations = 200;  % Maximum number of generations
CrossoverFraction = 0.7;  % Fraction of crossover children
StallGenLimit = 70;  % Maximum number of generations where improvement is less than the function tolerance
EliteCount = 2;  % Number of elite children to select at each generation
TimeLimit_Hybrid = 1;  % Hybrid function's operating time limit in minutes
InitialPopulation = []; % Row vector providing the initial population 

%% Setting Options as Specified by the User

% Defining GA options
% GA_Options = gaoptimset;
% GA_Options = gaoptimset(GA_Options, 'PopInitRange', [0;1]);
% GA_Options = gaoptimset(GA_Options, 'InitialPopulation', InitialPopulation);
% GA_Options = gaoptimset(GA_Options, 'PopulationSize', PopulationSize); % for multi-column population sizes, remove "@gaplotgenealogy" from plots
% GA_Options = gaoptimset(GA_Options, 'EliteCount', EliteCount);
% GA_Options = gaoptimset(GA_Options, 'CrossoverFraction', CrossoverFraction);
% GA_Options = gaoptimset(GA_Options, 'MigrationDirection', 'both');
% GA_Options = gaoptimset(GA_Options, 'MigrationInterval', 20);
% GA_Options = gaoptimset(GA_Options, 'Generations', Generations);
% GA_Options = gaoptimset(GA_Options, 'TimeLimit', Inf);
% GA_Options = gaoptimset(GA_Options, 'FitnessLimit', -Inf);
% GA_Options = gaoptimset(GA_Options, 'StallGenLimit', StallGenLimit);
% GA_Options = gaoptimset(GA_Options, 'StallTimeLimit', Inf);
% GA_Options = gaoptimset(GA_Options, 'TolFun', 1e-10);
% GA_Options = gaoptimset(GA_Options, 'TolCon', 1e-6);
% GA_Options = gaoptimset(GA_Options, 'Display', 'iter');
% GA_Options = gaoptimset(GA_Options, 'PlotFcns', {  @gaplotbestf @gaplotbestindiv @gaplotdistance @gaplotexpectation @gaplotrange ...
%     @gaplotscorediversity @gaplotscores @gaplotselection @gaplotstopping }); % @gaplotgenealogy @gaplotmaxconstr });
% GA_Options = gaoptimset(GA_Options, 'OutputFcns', { [] });
% GA_Options = gaoptimset(GA_Options, 'Vectorized', 'off');
% GA_Options = gaoptimset(GA_Options, 'UseParallel', 'always');

% Defining pattern search (hybrid function) options
Hybrid_Options = psoptimset(@patternsearch);
Hybrid_Options = psoptimset(Hybrid_Options,'CompletePoll','on',...
    'TolMesh',1e-4,'TolFun',1e-4,'TolX',1e-4,...
    'Display','iter','PlotFcn',{@psplotbestf  @psplotmeshsize  @psplotfuncount  @psplotbestx});
% GA_Options = gaoptimset(GA_Options, 'HybridFcn', { @patternsearch,Hybrid_Options });
% 'TolMesh',1e-10,'TolFun',1e-10,'TolX',1e-10,
%% Preparing and Executing the Genetic Algorithm

% Extending lower and upper bounds to the same size as number of variables, if they are entered as scalars
if size(lb,2) == 1 && Var_Num > 1  
    lb(1,1:Var_Num) = lb;
    ub(1,1:Var_Num) = ub;
end

% Running the genetic algorithm
[Coefficients] = patternsearch(@ContactFcn,[1,1],A,bin,Aeq,beq,lb,ub,nonlcon,Hybrid_Options);


%% Numerical soution of the Young-Laplae equation
S_span = [0:0.01:10];
sig = Coefficients(1);
c = abs(rho_l - rho_f)*g/sig;
zn = c^.5;
l_c = 1/zn;
b=  Coefficients(2);
[S,Y] = ode45(@LaplaceFCN, S_span, [0 1e-100 0 0 0], [], b, c);
Z = Y(:,1);

i=1;
while Z(i)<Z(i+1)
    
    i=i+1;
    
end

x_yl (1:i,1) = Y(1:i,2);
z_yl (1:i,1) = Y(1:i, 1);
V_yl (1:i,1) = Y(1:i,4);
A_yl (1:i,1) = Y(1:i,5);
S_yl (1:i,1) = S(1:i,1);
phi_yl (1:i,1) = Y (1:i,3)*180/pi;

xcut_nd = c^0.5*xcut/sf;
zcut_nd = c^0.5*zcut/sf;


Xcirc_nd = Xnew*c^0.5/sf;
Zcirc_nd = Znew*c^0.5/sf;



[m,n] = min(abs(zcut_nd(end)-z_yl(:,1)));
% % Error = abs(xcut_nd (end) - x_yl (n));
ContactAngle = phi_yl(n);
Error_Laplace = 0.5*((zcut_nd(end)-z_yl(n))^2+(xcut_nd(end)-x_yl(n))^2);


[pr,qr] = min(abs(zcut_nd(end)-Zcirc_nd(1,:)));
Error_Circ = 0.5*((zcut_nd(end)-Zcirc_nd(qr))^2+(xcut_nd(end)-Xcirc_nd(qr))^2);

Drop_vol_cm3 = V_yl(n)/c^1.5;
Drop_area_cm2 = A_yl(n)/c;

Bo = c*er^2; % Bond number

drop_height_nd = dh*c^0.5/sf;

w_H = 5/(sf*c^0.5);
w_R = 2*b*c^0.5;
w_theta = ContactAngle*sqrt((w_H/drop_height_nd)^2+(w_R/(0.19*drop_height_nd))^2);
w_theta = w_theta/1000;

%% Drop volume calculation



Z_yl_ind = find(z_yl <= drop_height_nd); % Index of end point on drop

Z_YL = z_yl(1:length(Z_yl_ind)); % End Z
X_YL = x_yl(1:length(Z_yl_ind)); % End X
V = zeros(length(Z_YL)-1,1); % Size of Volume matrix
A = zeros(length(Z_YL)-1,1);
for n = 2:length(Z_YL)
V(n-1) = pi*(((X_YL(n)+X_YL(n-1))/2)^2)*(Z_YL(n)-Z_YL(n-1));
A(n-1) = pi * ((X_YL(n)+X_YL(n-1)));
end
drop_vol = sum(V)*1000;

drop_vol_micL = (drop_vol/c^1.5);


%% Visualization


if abs(Eq_diameter-Wet_diameter)<0.1
    
    fprintf('Contact angle (Spherical Cap), degree:%f \t Error = %2.2e \n',bl90angle,Error_Circ);
    fprintf('Contact angle (Young-Laplace), degree:%4.2f ± %2.2f\t Error = %2.2e \n',ContactAngle, w_theta, Error_Laplace);
    fprintf('Bond number:  %f\n',Bo);
    fprintf('Drop volume, cm^3:  %f\n',Drop_vol_cm3);
    fprintf('Drop surface area, cm^2:  %f\n',Drop_area_cm2);
    fprintf('Wetted diameter, mm:  %f\n',2*er*10);
    fprintf('Equator diameter, mm:  %f\n',2*er*10);
    fprintf('Height, mm:  %f\n',p*10/sf);


else 
    
    fprintf('Contact angle (Spherical Cap), degree:%f \t Error = %2.2e \n',rad_angle2,Error_Circ);
    fprintf('Contact angle (Young-Laplace), degree:%4.2f ± %2.2f\t Error = %2.2e \n',ContactAngle, w_theta, Error_Laplace);
    fprintf('Bond number:  %f\n',Bo);
    fprintf('Drop volume, cm^3:  %f\n',Drop_vol_cm3);
    fprintf('Drop surface area, cm^2:  %f\n',Drop_area_cm2);
    fprintf('Wetted diameter, mm:  %f\n',2*er*10);
    fprintf('Equator diameter, mm:  %f\n',Xequator);
    fprintf('Height, mm:  %f\n',p*10/sf);
 
end





% switch anglecr
%     case 'Greater than 90'
%         fprintf('Contact angle (Spherical Cap), degree:%f \t Error = %2.2e \n',rad_angle2,Error_Circ);
%         fprintf('Contact angle (Young-Laplace), degree:%4.2f ± %2.2f\t Error = %2.2e \n',ContactAngle, w_theta, Error_Laplace);
%         fprintf('Bond number:  %f\n',Bo);
%         fprintf('Drop volume, cm^3:  %f\n',Drop_vol_cm3);
%         fprintf('Drop surface area, cm^2:  %f\n',Drop_area_cm2);
%         fprintf('Wetted diameter, mm:  %f\n',2*er*10);
%         fprintf('Equator diameter, mm:  %f\n',Xequator);
%         fprintf('Height, mm:  %f\n',p*10/sf);
%         
%     case 'Less than 90'
%          fprintf('Contact angle (Spherical Cap), degree:%f \t Error = %2.2e \n',bl90angle,Error_Circ);
%          fprintf('Contact angle (Young-Laplace), degree:%4.2f ± %2.2f\t Error = %2.2e \n',ContactAngle, w_theta, Error_Laplace);
%          fprintf('Bond number:  %f\n',Bo);
%          fprintf('Drop volume, cm^3:  %f\n',Drop_vol_cm3);
%          fprintf('Drop surface area, cm^2:  %f\n',Drop_area_cm2);
%          fprintf('Wetted diameter, mm:  %f\n',2*er*10);
%          fprintf('Equator diameter, mm:  %f\n',2*er*10);
%          fprintf('Height, mm:  %f\n',p*10/sf);
%          
% end


% scrsz = get(0,'ScreenSize'); % full screen looks better
% figure('Position', scrsz, 'Units', 'normalized');
figure;
plot(xcut_nd,zcut_nd,'g','LineWidth',2); 
hold all; 
plot(-x_yl,z_yl,'b--','LineWidth',2); 
plot(x_yl,z_yl,'b','LineWidth',2); 
plot(Xcirc_nd,Zcirc_nd,'r','LineWidth',2);
plot([xeqpleft*c^0.5/sf,xeqpright*c^0.5/sf],[zeqpleft*c^0.5/sf,zeqpright*c^0.5/sf],'ks','MarkerFaceColor','k')
set(gca,'YDir','reverse');
% set(gca,'Xlim',[min(Xcirc_nd)-0.7 max(Xcirc_nd)+0.7]);
% set(gca,'Ylim',[min(Zcirc_nd)-0.7 max(Zcirc_nd)+0.7]);
axis square
pbaspect([2 2 1])
legend('Experimental profile','Young-Laplace left profile','Young-Laplace right profile',...
    'Spherical cap approximation','Contact points','Location','SouthWest');
xlabel('\bfHorizontal coordinates');
ylabel('\bfVertical coordinates');
title('\bfComparison of the non-dimensionalized data');


% pnd=c^0.5*p/sf;
% dif = z_yl - pnd;
% adif = abs(dif);
% low = min (adif);
% id = find(adif == low);
% anglecc = phi_yl (id)



toc;