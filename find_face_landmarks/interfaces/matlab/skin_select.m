%% Function to select skin area
function [Y, Cb, Cr] = skin_select(frames,a)
    aver_Cb = 0;
    aver_Cr = 0;
    aver_Y = 0;
    for i = 30:31
        select_point = frames.faces.landmarks(i,:);% (x,y)localization vector of center pixel
        p_x = select_point(1);
        p_y = select_point(2);
        aver_Y = aver_Y + mean(mean(a(p_x-1:p_x+1, p_y-1:p_y+1, 1)));
        aver_Cb = aver_Cb + mean(mean(a(p_x-1:p_x+1, p_y-1:p_y+1, 2)));
        aver_Cr = aver_Cr + mean(mean(a(p_x-1:p_x+1, p_y-1:p_y+1, 3)));
    end
    Y = aver_Y/2;
    Cb = aver_Cb/2;
    Cr = aver_Cr/2;

end