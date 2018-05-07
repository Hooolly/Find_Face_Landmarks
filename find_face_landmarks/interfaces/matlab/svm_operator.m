%% SVM classifier
function L = svm_operator(mag, phase, I)

imageSize = size(I);
numRows = imageSize(1);
numCols = imageSize(2);

X = reshape(phase,numRows*numCols,[]);
%normalize features to be zero mean, unit variance.
X = bsxfun(@minus, X, mean(X));
X = bsxfun(@rdivide,X,std(X));
% Add gaussian filter
sigma = 0.5 * 5; % 5 is the value of wavelength
K = 5; % K is the smooth weight
X = imgaussfilt(X, K*sigma); 

L = kmeans(X,2,'Replicates',5);
L = reshape(L,[numRows numCols]);
figure
imshow(label2rgb(L))
 title( 'After k-means classifier' );
 
end