%% Gabor test
function [mag, phase] = Gabor_test(gray_img, I)

wavelength = 5;
orientation = 90;
[mag,phase] = imgaborfilt(gray_img,wavelength,orientation);
figure
subplot(1,3,1);
imshow(I);
title('Original Image');
subplot(1,3,2);
imshow(mag,[])
title('Gabor magnitude');
subplot(1,3,3);
imshow(phase,[]);
title('Gabor phase');
end