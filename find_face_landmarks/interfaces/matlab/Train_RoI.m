%% Pick one RoI as training data

function [train_skin, temp, Class_final] = Train_RoI(landmark_num,threshold, W, Input, frames, feature2DImage)

    Cheek_l = frames.faces.landmarks(landmark_num, 1);
    Cheek_u = frames.faces.landmarks(landmark_num, 2);
    train_skin = feature2DImage(Cheek_l+1:Cheek_l+8,Cheek_u+1:Cheek_u+8);
    train_skin = reshape(train_skin,4,16);
    Class_train = [ ones(4,1) train_skin] * W';
    % Calculate class probabilities
    P = Class_train ./ repmat(sum(Class_train,2),[1 2]);
    % Calculate classification of this region
    [row_p, col_p] = size(P);
    temp = 0;
    %threshold = 0.5;
    for i = 1:row_p
        if (P(i,1) > P(i,2))
            temp = temp + 1;
        else
             temp = temp;
        end 
        i = i +1;
    end

    if temp > row_p * threshold
        Class_final = 1;
    else 
        Class_final = 0;
    end 
end