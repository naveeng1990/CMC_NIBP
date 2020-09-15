 
%%
clc;
clear;
close all;
[fileName, path] = uigetfile('*.png; *.jpg');
img = imread([path fileName]);
imshow(img);
hold on;

% img = imbinarize(img);% thresholds certain pixels to 0 or 1 (Denoising)
R = img(:,:,1); %Red Layer- gives mono chrome image
imshow(R);
hRect=R;
% hRect=img;
% 
% hRect = imcrop;
% figure, imshow(hRect);
% grayImage = min(hRect, [], 3); 


grayImage=hRect;

try
   BW = grayImage<70;
   imshow(BW);
catch e
   BW = grayImage<93;
end



% BW = grayImage<40;
imshow(BW);
% BW = imfill(BW, 'holes'); 

BW= imcomplement(BW);
imshow(BW)


BW = imclearborder(BW); 
imshow(BW);


% edges_depth_distance=edge(BW,'canny',[0 0.8],4);
% BW = bwmorph(edges_depth_distance, 'bridge')
% se = strel('line', 1, 180); % Structuring element for dilation
% BW = imdilate(BW, se);
% figure, imshow(BW);

% BW1=imcomplement(BW);
% figure, imshow(BW1);
% 
% BB=imfill(BW1,'holes')
% imshow(BB);

CC = bwconncomp(BW);
disp(CC);           
numPixels = cellfun(@numel,CC.PixelIdxList);   
[maxPixel, indexOfMax] = max(numPixels);  
largest = zeros(size(BW));    
largest(CC.PixelIdxList{indexOfMax}) = 1;                     
figure;
imshow(largest); 

area_img = bwarea(largest);
r = sqrt(area_img/pi);
dia = 2*r;
dia1 = 0.003631*dia;
fprintf('diameter of cropped circle %fcm \n',dia1)
r1 = dia1/2;
cir_area = pi*r1*r1;
fprintf('Area of circle = %fcm2',cir_area);

%%

