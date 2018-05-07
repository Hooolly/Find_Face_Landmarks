%% Density regularization function
function img_dens_reg = Dens_reg(img, N)

%% Discard all points at the edge of the density map
    [r,c,l] = size(img);
    
    img(1,:) = 0;
    img(r,:) = 0;
    img(:,1) = 0;
    img(:, c) =0;
    
%% counts number of full density points

    for i = 0:ceil(c/N)-2
        for j = 0:ceil(r/N)-2
            num = 0;
            for m = 1:N
                for n = 1:N
                    if (img(j*N + m,i*N + n) == 1)
                        num = num + 1; 
                    else
                        num = num;
                    end
                end
            end
            if (num == N*N)
                img_dens_reg(j+1,i+1) = 1;
            else
                img_dens_reg(j+1,i+1) = 0;
            end
        end
    end
    %figure;imshow(img_dens_reg);
