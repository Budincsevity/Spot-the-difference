function [] = spotTheDifference( kep_1, kep_2 )
%Keresd meg a k�l�nbs�geket a k�pen!	
%Adott k�t hasonl� k�p. Jel�ld be piros t�glalappal a k�l�nbs�geket! 

%Haszn�lati p�lda: spotTheDifference('kep1.jpg', 'kep2.jpg');

%Els� k�p megnyit�sa
RGB_kep_1 = imread(kep_1);
%M�sodik k�p megnyit�sa
RGB_kep_2 = imread(kep_2);

%M�retek lek�rdez�se
kep1_size = size(RGB_kep_1);
kep2_size = size(RGB_kep_2);

%Ha a k�t k�p nem egyenl?, dobjon hib�t
if(~isequal(kep1_size, kep2_size))
    error('A k�t k�p egyforma nagys�g� �s sz�n�rnyalat� kell, hogy legyen!');
end

%K�l�nbs�g kisz�mol�sa, majd ezek �sszead�sa
kep_kulonbseg1 = RGB_kep_2 - RGB_kep_1;
kep_kulonbseg2 = RGB_kep_1 - RGB_kep_2;
kep_kulonbseg = kep_kulonbseg1 + kep_kulonbseg2;    

%Sz�rke�rnyalatos k�p k�sz�t�se
GRAY_kep = rgb2gray(kep_kulonbseg);

%Treshold kisz�m�t�sa
treshold = graythresh(GRAY_kep);

%Bin�ris k�p k�sz�t�se
BINARY_kep = GRAY_kep > treshold;

%A regionprops f�ggv�ny seg�ts�g�vel lek�rdezi a bin�ris k�p elemeinek
%befoglal� t�glalapj�t
LABELED_kep = bwlabel(BINARY_kep,8);
BB = regionprops(LABELED_kep, 'BoundingBox');

%A bin�ris alakok sz�m�nak alapj�n v�gigmegy az alakzatokon �s az index
%�rt�k alapj�n bejel�li az elemet
subplot(1,2,1),
imshow(RGB_kep_1);
title('Elso kep');
for k = 1 : size(BB)
    rectangle('Position', BB(k).BoundingBox, 'EdgeColor','r');
end

%A m�sodik megadott k�pre is hasonl�an hajtja v�gre az utas�t�st
subplot(1,2,2),
imshow(RGB_kep_2);
title('Masodik kep');
for k = 1:size(BB)
    rectangle('Position', BB(k).BoundingBox, 'EdgeColor','r');
end
end

