function [] = spotTheDifference( kep_1, kep_2 )
%Keresd meg a különbségeket a képen!	
%Adott két hasonló kép. Jelöld be piros téglalappal a különbségeket! 

%Használati példa: spotTheDifference('kep1.jpg', 'kep2.jpg');

%Elsö kép megnyitása
RGB_kep_1 = imread(kep_1);
%Második kép megnyitása
RGB_kep_2 = imread(kep_2);

%Méretek lekérdezése
kep1_size = size(RGB_kep_1);
kep2_size = size(RGB_kep_2);

%Ha a két kép nem egyenl?, dobjon hibát
if(~isequal(kep1_size, kep2_size))
    error('A két kép egyforma nagyságú és színárnyalatú kell, hogy legyen!');
end

%Különbség kiszámolása, majd ezek összeadása
kep_kulonbseg1 = RGB_kep_2 - RGB_kep_1;
kep_kulonbseg2 = RGB_kep_1 - RGB_kep_2;
kep_kulonbseg = kep_kulonbseg1 + kep_kulonbseg2;    

%Szürkeárnyalatos kép készítése
GRAY_kep = rgb2gray(kep_kulonbseg);

%Treshold kiszámítása
treshold = graythresh(GRAY_kep);

%Bináris kép készítése
BINARY_kep = GRAY_kep > treshold;

%A regionprops függvény segítségével lekérdezi a bináris kép elemeinek
%befoglaló téglalapját
LABELED_kep = bwlabel(BINARY_kep,8);
BB = regionprops(LABELED_kep, 'BoundingBox');

%A bináris alakok számának alapján végigmegy az alakzatokon és az index
%érték alapján bejelöli az elemet
subplot(1,2,1),
imshow(RGB_kep_1);
title('Elso kep');
for k = 1 : size(BB)
    rectangle('Position', BB(k).BoundingBox, 'EdgeColor','r');
end

%A második megadott képre is hasonlóan hajtja végre az utasítást
subplot(1,2,2),
imshow(RGB_kep_2);
title('Masodik kep');
for k = 1:size(BB)
    rectangle('Position', BB(k).BoundingBox, 'EdgeColor','r');
end
end

