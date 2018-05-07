%% Operate on original image
function Inew = mask_operator(mask_o,I)
test1 = repmat(mask_o,[1,1,3]);

Inew(:,:,1) = uint8(I(:,:,1)).* uint8(test1(:,:,1));
Inew(:,:,2) = uint8(I(:,:,2)).* uint8(test1(:,:,2));
Inew(:,:,3) = uint8(I(:,:,3)).* uint8(test1(:,:,3));

end