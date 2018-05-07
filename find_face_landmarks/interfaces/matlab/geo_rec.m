%% Geometric regularization
function img_geo_rec = geo_rec(img,N)
     [r,c] = size(img);
     for i = 1:c-N
            for j = 1:r-N
                for n = 0:N-1
                    for m = 0:N-1
                        if(img(j+n,i+m)==1)
                            img_geo_rec(j,i) = 1;
                        else
                            img_geo_rec(j,i) = 0;
                        end
                    end
                end
            end
     end
     
                

end