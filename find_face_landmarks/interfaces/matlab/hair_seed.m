%% Hair seed detection
%% Hair seed region confirm
function [L_m,R_m,U_m,D_m, h, B, hair_RoI] = hair_seed(frames, I,test)
% initial parameters-------------------
[m,n] = size(I(:,:,1));
C_L1 = frames.faces.landmarks(38,:);
C_L2 = frames.faces.landmarks(39,:);
C_L3 = frames.faces.landmarks(42,:);
C_L = [(C_L1(1)+C_L2(1))/2, (C_L1(2)+C_L3(2))/2];

C_R1 = frames.faces.landmarks(44,:);
C_R2 = frames.faces.landmarks(45,:);
C_R3 = frames.faces.landmarks(48,:);
C_R = [(C_R1(1)+C_R2(1))/2,(C_R1(2)+C_R3(2))/2];

B = C_R(1) - C_L(1);
h = frames.faces.landmarks(65,2) - frames.faces.landmarks(28,2);
L_m = C_L(1) - B/2;
R_m = C_R(1) + B/2;
U_m = min(C_L(2),C_R(2)) - h*1.6;
D_m = min(C_L(2),C_R(2)) - h/10;
x = [L_m, R_m, R_m, L_m];
y = [U_m, U_m, D_m, D_m];

mask = poly2mask(double(x), double(y), m,n);
hair_RoI = mask_operator(mask,I);
%gabor_operator(hair_RoI);
gabor_operator(I);
title('After Gabor filter');
end