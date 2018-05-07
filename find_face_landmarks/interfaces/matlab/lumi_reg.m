%% Luminance regularization
function img_lumi_reg = lumi_reg(img,dens_reg)
    
    %% Discard all points at the edge of the density map
    [r,c,l] = size(img);
    img(1,:) = 0;
    img(c,:) = 0;
    img(:,1) = 0;
    img(:, r) =0;
    [r2,c2,l] = size(dens_reg);
    img_lumi_reg = zeros(r2,c2);


    %% Calculate standard deviation with std2
     for i = 0:c2-1
            for j = 0:r2-1
                devi =  std2(img(j*4+1 : j*4+4, i*4+1 : i*4+4));
                if (devi <= 0.00001)
                    img_lumi_reg(j+1,i+1) = 1;
                else
                    img_lumi_reg(j+1,i+1) = 0;
                end
            end
     end
    img_lumi_reg = -img_lumi_reg + dens_reg;
    img_lumi_reg = resizem(img_lumi_reg,4);
    img_lumi_reg = resizem(img_lumi_reg,[r,c]);
end