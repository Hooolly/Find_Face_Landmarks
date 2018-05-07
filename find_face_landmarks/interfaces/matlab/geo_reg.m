%% Geometry regularization
function img_geo_reg = geo_reg(img_dens_reg, N, face)
    
    %% geo regularization
    [r,c] = size(face);
    [r1,c1] = size(img_dens_reg);
    img_geo_reg = img_dens_reg;
    for i = N/2+1:c1-N/2
        for j = N/2+1:r1-N/2
            num = 0;
            if (img_dens_reg(j,i) == 0)
                for m = -N/2:N/2
                    for n = -N/2:N/2
                        if (img_dens_reg(j+m,i+n) == 0)
                            num = num + 1; 
                        else
                            num = num;
                        end
                    end
                end
                if (num == 9)
                    img_geo_reg(j,i) = 0;
                else
                    img_geo_reg(j,i) = 1;
                end
                
            else
                img_geo_reg(j,i) = img_geo_reg(j,i);
            end
        end
    end
    %figure; imshow(img_geo_reg);
    %figure; imshow(img_dens_reg);
    img_geo_reg = resizem(img_geo_reg,4);
    img_geo_reg = resizem(img_geo_reg,[r,c]);
    
end