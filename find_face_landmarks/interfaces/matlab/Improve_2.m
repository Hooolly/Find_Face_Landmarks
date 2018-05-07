%% || Detection of Face on the basis of color and texture feature(normal potrait)                 ||
%% || Code function: Input randomly one landmark number, run the code.                            ||
%% ||                If the Class_final value is 1, the region around this point is skin region.  ||
%% ||                                                                                             ||
%% ||=============================================================================================||
clear all;
close all;
clc
%% Please select the landmark number and the treshold value
 % For example:
 % 20 is the brow and is not the skin region;
 % 62 is the mouth and is not the skin region;
 % 11 is the skin region.
landmark_num = 62;
threshold = 0.75;
%% Load the original image
image_path = '3.jpg';
I=imread(image_path);
a = rgb2ycbcr(I);
frames = find_face_landmarks('shape_predictor_68_face_landmarks.dat', image_path);

% imshow(I);
% hold on
% show_landmarks_frame(frames);
%% Gabor filter -------------------
feature2DImage = gabor_operator(I);

%% crop cheek RoI and non cheek RoI, get HoG feature
[cheek, featureVector] = cheek_feature(frames, feature2DImage);
[non_cheek, non_featureVector] = non_cheek_feature(frames, feature2DImage);
[cheek_r, cheek_c] = size(cheek);

%% project on LFDA vector
Input = [cheek;non_cheek];
Lable = [ones(cheek_r, 1);zeros(cheek_r,1)];
W = LDA_1(Input, Lable);
[train_skin, temp, Class_final] = Train_RoI(landmark_num,threshold, W, Input, frames, feature2DImage);
%% Output the final classification result
if (Class_final ==1)
    disp('This region is skin region');
else
    disp('This region is not skin region');
end

