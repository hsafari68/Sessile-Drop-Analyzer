% Scale calculation program
clc;
clear;
close all;


[filename, pathname] = uigetfile(...
                                               {'*.bmp;*.png;*.jpg','Image Files(*.bmp,*.png,*.jpg)';
                                                '*.*','All Files(*.*)'},...
                                               'Pick an Image');
% fid = fopen ('pathname.dat','w');
% fprintf(fid,'%s',pathname);
% fclose(fid);

scale_image = imread([pathname,filename]);


scale_image = rgb2gray(scale_image);

th = graythresh(scale_image);

BW_image = imbinarize(scale_image,th);

% figure;
% imshow (scale_image,[]);
% [x,y] = ginput(2);
% 
% pixels = x(2)-x(1);

pixels = abs(sum(BW_image(3,:)-1));

prompt = {'Scale, mm'};
label = 'Enter scale:';
defaults = {'0.75'};
options.Resize = 'on';
params = inputdlg (prompt,label,[1 20],defaults,options);
scale_mm = str2num(params{1}); %#ok

scale_cm = scale_mm/10;

sf = abs(pixels/scale_cm);

save sf.mat;