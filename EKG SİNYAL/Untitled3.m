clc
hamsinyal=load('ecg_60hz_200.dat'); 
plot(hamsinyal); title('Ham Sinyal');
dcsizsinyal=(hamsinyal-mean(hamsinyal));
plot(dcsizsinyal); title('DC Bilesenleri Atilan Sinyal');
B=(1/10)*ones(1,10);
A=1;
freqz(B,A); 
title('10 Point Moving Avarage Filtre');
avaragefiltrelisinyal=filter(B,A,dcsizsinyal);
plot(avaragefiltrelisinyal) 
title('Moving Avarage (Low Pass) Filtreden Gecmis Sinyal');
B=conv([1 1],[0.6310 -0.2149 0.1512 -0.1288 0.1227 -0.1288 0.1512 -0.2149 0.6310]);
A=1;
freqz(B,A);
title('Comb Filter');
comb=filter(B,A,avaragefiltrelisinyal);
plot(comb) 
title('(60Hz ve Harmoniklerini Bastiran) Filtreden Gecmis Sinyal');
t=comb(1:length(comb),1)>500;
degerler=comb(t);
plot(degerler)
title('QRS sinyalinin Peak Değerleri')

[pks,locs] = findpeaks(comb);
plot(degerler);
hold on; 
plot(locs,pks,'rv','MarkerFaceColor','r');

title('Peak değerleri işaretlenmiş QRS siyali ');
hold off
beat_count=0; 
for k=2:length(degerler)-1

if(degerler(k)> degerler(k-1) && degerler(k) > degerler(k+1) && degerler(k) >1 )
disp('peak bulundu')

beat_count= beat_count+1;  
end
end
