%% || Detection of Face on the basis of skin color(normal potrait)                                                ||
%% || Reference code: https://de.mathworks.com/matlabcentral/answers/uploaded_files/32328/freehand_masking_demo.m ||
%% ||=============================================================================================================||
clear all;
close all;
clc
%% Load the original image
image_path = '3.jpg';
I=imread(image_path);
a = rgb2ycbcr(I);
%I = imread('dataset_dir/img_01.jpg')
frames = find_face_landmarks('shape_predictor_68_face_landmarks.dat', image_path);
%[L_m,R_m,U_m,D_m, h, B, hair_RoI] = hair_seed(frames, I);
imshow(I);
hold on
%  show_landmarks_frame(frames);
%rectangle('Position',[L_m U_m 2*B 1.5*h],'EdgeColor','g')
%figure;imshow(a);
%% Select the skin area to generat color map
% Use 68 face-landmark algorithm automaticly select skin area(nose)
[Y, Cb, Cr] = skin_select(frames,a);
% For image 2 position
%select = [271,168];
% For image 3 position
%select = [258,253];
% For image 4 position(minus)
%select = [624,258];

%% Generate three types of bitmap 
B=graythresh(a(:,:,1));
BW0=im2bw(a(:,:,1),B);

L=graythresh(a(:,:,2));
BW1=im2bw(a(:,:,2),L);

M=graythresh(a(:,:,3));
BW2=im2bw(a(:,:,3),M);
% Combine Cr and Cb type 
bw = BW2.* ~BW1;

%% Get coordinates of the boundary
structBoundaries = bwboundaries(bw);
[A,index] = max(cellfun('length',structBoundaries ));
xy=structBoundaries{index}; % Get n by 2 array of x,y coordinates.
[bound_num, bound] = size(xy);
x = xy(1:ceil(bound_num/50):bound_num, 2); % Columns.
y = xy(1:ceil(bound_num/50):bound_num, 1); % Rows.

%% Generat mask of face region£¨method from reference link£©
[rows, columns, numberOfColorChannels] = size(BW0);
mask = poly2mask(x, y, rows, columns);
%geo_mask = geo_reg(mask,2, BW0);
%% Use skin color map£¨method from essay£©
% pixel = a(select(1,1),select(1,2),:);
% Cb = pixel(:,:,2);
% Cr = pixel(:,:,3);
[face, num] = face_reg(a, Y, Cb, Cr);
dens = Dens_reg(face, 4);
%lumi = lumi_reg(BW0,dens);
%figure;imshow(face);
geo = geo_reg(dens,2, face);
% %% Add mask on original image
% essay = mask_operator(geo,I);
% improved = mask_operator(mask,I);
%  figure;imshow(geo);
%  title( 'Skin Mask' );
% % figure;imshow(mask);
%  figure;imshow(essay);
%  title( 'Skin Extration' );
% % figure;imshow(improved);


