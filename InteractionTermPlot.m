% wp=2.4E-3;   %m
lambda_P=1551E-9;    %m
f=200E-3;    %m
E0=1.5E4; %V/m
Wfiber=60E-6;    %m
SLMResolution=[1050,1050];
waist=2.4E-3;
pixelPitch=10.4E-6;
waistPixel=round(2.4E-3/pixelPitch,0);
% scale=0.1;
% qsize=round(SLMResolution*scale,0);

qsize=[10,10];
scale=qsize(1)/SLMResolution(1);

waistPixelScaled=waistPixel*scale;
pixelPitchScaled=pixelPitch*scale;
WfiberScaled=Wfiber*scale;
lambda_PScaled=lambda_P*scale;
fScaled=f*scale;
center=round(qsize./2,0);
%generate the electric field at the input of slm
E_lm=gauss2d(qsize, waistPixelScaled, center);
E_no=gauss2d(qsize, waistPixelScaled, center);
x=1:qsize(1);
y=1:qsize(2);
[X,Y] = meshgrid(x,y);
Z=X.^2 + Y.^2;
%fiber modes
K_lm=exp(((-pi^2*pixelPitchScaled^2*WfiberScaled^2)/(lambda_PScaled^2*fScaled^2))*Z);
%generate random number 0,1 for qsize dimension to modify the input
r=randi([0,1],qsize);
E_lm=E_lm.*r;
E_no=E_no.*r;
%multiply the input field with fiber mode
E_lm=E_lm.*K_lm;
E_no=E_no.*K_lm;

%plot the modified electric field
figure;
% imshow(E_lm);
imagesc(E_lm);
colormap hot
%display interaction matric Jij
Eij=E_lm(:)*E_no(:).';
figure;
% imshow(Eij);
imagesc(Eij);
colormap hot
% figure;
% dims=size(Eij);
% x=1:dims(1);
% y=1:dims(2);
% [X,Y] = meshgrid(x,y);
% surf(X,Y,Eij);
function mat = gauss2d(gsize, waist, center)
%     gsize = size(mat);
    [R,C] = ndgrid(1:gsize(1), 1:gsize(2));
    mat = gaussC(R,C, waist, center);
end

function val = gaussC(x, y, waist, center)
    xc = center(1);
    yc = center(2);
    exponent = ((x-xc).^2 + (y-yc).^2)./(2*waist^2);
    val       = (exp(-exponent));
end