%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function[x,y,ibw]=isub(i_aft,i_bef)
%Takes two images from two frames ,subtracts them and detect the position
%of object by threshholding and calculating centroid
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function[x,y,ibw]=isubtract(i_aft,i_bef)
%subtract image
i_sub=i_bef-i_aft;
%convert to binary
igray=rgb2gray(i_sub);
level=graythresh(i_sub);
ibw=im2bw(i_sub,level);
%compute centre of gravity
ibw = imfill(ibw,'holes');
L=bwlabel(ibw);
stats=regionprops(L,'Area','Centroid');
ar=[stats.Area];
s=[stats.Centroid];
armax=max(ar);
mx=max(max(L));
for i=1:mx
if stats(i).Area==armax
centroid=stats(i).Centroid;
end
end
x=centroid(1);
y=centroid(2);
x=round(x);
y=round(y);
[m n r]=size(i_aft);
for k=1:m
for l= 1:n
if (k==y && l==x)
for t= 0:4
i_aft(k-t,l-t,:)= 0;
i_aft(k-t,l-t,3)=255;
i_aft(k-t,l+t,:)= 0;
i_aft(k-t,l+t,3)=255;
end
end
end
end
imshow(i_aft);
