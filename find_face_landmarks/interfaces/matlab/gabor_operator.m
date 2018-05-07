%% Gabor test
function feature2DImage = gabor_operator(I)

Agray = rgb2gray(I);
% figure;
% imshow(I);
%% Design array of Gabor filters
imageSize = size(I);
numRows = imageSize(1);
numCols = imageSize(2);
wavelengthMin = 4/sqrt(2);
wavelengthMax = hypot(numRows,numCols);
n = floor(log2(wavelengthMax/wavelengthMin));
wavelength = 2.^(0:(n-2)) * wavelengthMin;


% wavelength = 5;
% orientation = 0:90:90;
deltaTheta = 45;
orientation = 0:deltaTheta:(180-deltaTheta);

g = gabor(wavelength,orientation);
% Store magnitude putput image correspoding to Gabor filter g 
gabormag = imgaborfilt(Agray,g);
%% Add Gaussian filter and smooth Gabor magnitude responses
for i = 1:length(g)
    sigma = 0.5*g(i).Wavelength;
    K = 5;
    gabormag(:,:,i) = imgaussfilt(gabormag(:,:,i),K*sigma); 
    
end
% figure; imshow(gabormag(:,:,1));
%% Add spatial location info
X = 1:numCols;
Y = 1:numRows;
[X,Y] = meshgrid(X,Y);
featureSet = cat(3,gabormag,X);
featureSet = cat(3,featureSet,Y);
% 24 Gabor features and 2 spatial features for each pixel
numPoints = numRows*numCols;
X = reshape(featureSet,numRows*numCols,[]);
%normalize features to be zero mean, unit variance.
X = bsxfun(@minus, X, mean(X));
X = bsxfun(@rdivide,X,std(X));
%visualize feature set
coeff = pca(X);
feature2DImage = reshape(X*coeff(:,1),numRows,numCols);
% figure
% imshow(feature2DImage,[])
% title( 'Extracted texture feature' );
%% -------------------
% L = kmeans(X,5,'Replicates',5);
% L = reshape(L,[numRows numCols]);
% figure
% imshow(label2rgb(L))
% title( 'After k-means classifier' );
end