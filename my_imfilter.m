function output = my_imfilter(image, filter)
% This function is intended to behave like the built in function imfilter()
% See 'help imfilter' or 'help conv2'. While terms like "filtering" and
% "convolution" might be used interchangeably, and they are indeed nearly
% the same thing, there is a difference:
% from 'help filter2'
%    2-D correlation is related to 2-D convolution by a 180 degree rotation
%    of the filter matrix.

% Your function should work for color images. Simply filter each color
% channel independently.

% Your function should work for filters of any width and height
% combination, as long as the width and height are odd (e.g. 1, 7, 9). This
% restriction makes it unambigious which pixel in the filter is the center
% pixel.

% Boundary handling can be tricky. The filter can't be centered on pixels
% at the image boundary without parts of the filter being out of bounds. If
% you look at 'help conv2' and 'help imfilter' you see that they have
% several options to deal with boundaries. You should simply recreate the
% default behavior of imfilter -- pad the input image with zeros, and
% return a filtered image which matches the input resolution. A better
% approach is to mirror the image content over the boundaries for padding.

% % Uncomment if you want to simply call imfilter so you can see the desired
% % behavior. When you write your actual solution, you can't use imfilter,
% % filter2, conv2, etc. Simply loop over all the pixels and do the actual
% % computation. It might be slow.
% output = imfilter(image, filter);


%%%%%%%%%%%%%%%%
% Your code here
%%%%%%%%%%%%%%%%

IMG = im2double(image);

[rows , cols , channel] = size(IMG);
 output=[rows,cols];
 F = filter;
if channel == 1
        output = loop(IMG,F);
       
else if channel >1
        [R,G,B] = imsplit(IMG);
        output1 = loop (R,F);
        output2 = loop (G,F);
        output3 = loop (B,F);
        output  = cat(3,output1 , output2 , output3);
       
end
end


function output = loop(IMG,F)
[filterrow,filtercol] = size(F);
paddingrow = floor(filterrow/2);
paddingcol = floor(filtercol/2);

PIMG = padarray(IMG , [paddingrow,paddingcol]);
Final = zeros(size(IMG));
for  rowcount= 1+paddingrow  : 1  :  height(PIMG)-paddingrow
    for colcount=1+paddingcol: 1  :  width(PIMG)-paddingcol
      Smoothval=sum(sum(PIMG(rowcount-paddingrow:rowcount+paddingrow,colcount-paddingcol : colcount+paddingcol).*F));
      Final(rowcount-paddingrow,colcount-paddingcol)=Smoothval;
    end    
end  
output = Final;
end
end

