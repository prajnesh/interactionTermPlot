close all;
% Ei=ones(2,2);
% Ej=ones(2,2);
% Eij=Ei(:)*Ej(:).';
% Jijkl=Eij(:)*Eij(:).';
% imshow(imresize(Jijkl,100))


Ei=[1,-1;-1,1];
Ej=Ei;
Eij=Ei(:)*Ej(:).';
Jijkl=Eij(:)*Eij(:).';
imshow(imresize(Jijkl, 10, 'nearest'))