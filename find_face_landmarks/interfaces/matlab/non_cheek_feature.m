%% Function definites non cheek feature

function [non_cheek, non_featureVector] = non_cheek_feature(frames, phase)
    % pick the cheek region
    Cheek_u = frames.faces.landmarks(20, 2);
    Cheek_d = frames.faces.landmarks(20, 2);
    Cheek_l = frames.faces.landmarks(20, 1);
    Cheek_r = frames.faces.landmarks(21, 1);
    
    x = [Cheek_l, Cheek_r, Cheek_r, Cheek_l];
    y = [Cheek_u-10, Cheek_u-10, Cheek_d+10, Cheek_d+10];
    % [m,n] = size(phase);
    %mask = poly2mask(double(x), double(y), 20, 20);
    non_cheek = phase(Cheek_u:Cheek_u+15,Cheek_l:Cheek_l+15);
    % Segmente the RoI
    %non_cheek = mask .* phase;
    %cheek = cheek_roi(1:100,1:100);
    [non_featureVector,hogVisualization] = hog_features(non_cheek);
%     imshow(non_cheek);
%     title('non cheek region');
    
end