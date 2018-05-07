%% segment face function
function [imag_face_reg,num] = face_reg(img,Y, Cb, Cr)
B=graythresh(img(:,:,1));
BW0=im2bw(img(:,:,1),B);

L=graythresh(img(:,:,2));
BW1=im2bw(img(:,:,2),L);

M=graythresh(img(:,:,3));
BW2=im2bw(img(:,:,3),M); 
[num_x, num_y] = size(BW1);
num = 0;
    for i = 1:num_x
        for j = 1:num_y
        %i >= BB2(1,temp-2) && i<= BB2(1,temp)+20 && j >= BB2(1,temp-1) && j <= BB2(1,temp+1)+50 &&
            if ( img(i,j,2)>= Cb-30 && img(i,j,2)<= Cb+50 && img(i,j,3)>= Cr-10 && img(i,j,3)<= Cr+80 && img(i,j,1)>=Y-35 && img(i,j,1) <= Y+380  )
                imag_face_reg(i,j) = 1;
                num = num+1;
            else
                imag_face_reg(i,j) = 0;
            end 
        end
    end
end