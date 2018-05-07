%% Function definites cheek feature

function [cheek, featureVector] = cheek_feature(frames, phase)
    % pick the cheek region
    Cheek_u = frames.faces.landmarks(30, 2);
    Cheek_d = frames.faces.landmarks(31, 2);
    Cheek_l = frames.faces.landmarks(38, 1);
    Cheek_r = frames.faces.landmarks(40, 1);
    
    x = [Cheek_l, Cheek_r, Cheek_r, Cheek_l];
    y = [Cheek_u, Cheek_u, Cheek_d, Cheek_d];
    [m,n] = size(phase);
    %mask = poly2mask(double(x), double(y), m,n);
    cheek = phase(Cheek_u: Cheek_u+15, Cheek_l:Cheek_l+15);
    % Segmente the RoI
    %cheek = mask .* phase;
    %cheek = cheek_roi(1:100,1:100);
    [featureVector,hogVisualization] = hog_features(cheek);
%     imshow(cheek);
%     title('cheek region');
    
end