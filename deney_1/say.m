%% PROGRAM 1: Orijinal işaretin örneklenmesi
fs=500;%örnekleme frekansı bir sonrakinde 1000 daha sonra da 2000 yapılcak!
T=1/fs;%örnekeleme periyodu
t=0:T:0.004;%0.004 saniyelik zaman dilimi
x=6*cos(2*pi*1000*t);%oluşturulan sinyal
stem(t,x)
%% PROGRAM 1A
fs=1000;%örnekleme frekansı bir sonrakinde 1000 daha sonra da 2000 yapılcak!
T=1/fs;%örnekeleme periyodu
t=0:T:0.004;%0.004 saniyelik zaman dilimi
x=6*cos(2*pi*1000*t);%oluşturulan sinyal
stem(t,x)
%% PROGRAM 1B
fs=2000;%örnekleme frekansı bir sonrakinde 1000 daha sonra da 2000 yapılcak!
T=1/fs;%örnekeleme periyodu
t=0:T:0.004;%0.004 saniyelik zaman dilimi
x=6*cos(2*pi*1000*t);%oluşturulan sinyal
stem(t,x)
%% PROGRAM 2A: 2 bit (4 seviye) kuantalama
fs=32000;%örnekleme frekansı bir sonrakinde 1000 daha sonra da 2000 yapılcak!
T=1/fs;%örnekeleme periyodu
t=0:T:0.004;%0.004 saniyelik zaman dilimi
x=6*cos(2*pi*1000*t);%oluşturulan sinyal
bitsay=2; %kuantalayıcı çıkışının kod uzunluğu
xmin=-6.5; %kuantalayıcı girişinin minimum değeri
xmax=6.5;% kuantalayıcı girişinin maximum değeri
L=2^bitsay;%seviye sayısı
delta=(xmax-xmin)/L;%adım büyüklüğü
boy=length(x);%giriş sinyalinin örnek sayısı
for k=1:boy
I=round((x(k)-xmin)/delta);%alınan değerin minimum değere yuvarlatılmış olarak kaç adım
%uzaklıkta olduğu
if (I==boy)
I=I-1;%+6.5V'u aşmamak için
end
if (I<0)
I=0;%-6.5V'u aşmamak için
end
xq(k)=xmin+I*delta;%kuantalanmış değer
end;
plot(t,x,t,xq);


%% PROGRAM 2B: 4 bit (16 seviye) kuantalama
fs=32000;%örnekleme frekansı bir sonrakinde 1000 daha sonra da 2000 yapılcak!
T=1/fs;%örnekeleme periyodu
t=0:T:0.004;%0.004 saniyelik zaman dilimi
x=6*cos(2*pi*1000*t);%oluşturulan sinyal
bitsay=4; %kuantalayıcı çıkışının kod uzunluğu
xmin=-6.5; %kuantalayıcı girişinin minimum değeri
xmax=6.5;% kuantalayıcı girişinin maximum değeri
L=2^bitsay;%seviye sayısı
delta=(xmax-xmin)/L;%adım büyüklüğü
boy=length(x);%giriş sinyalinin örnek sayısı
for k=1:boy
I=round((x(k)-xmin)/delta);%alınan değerin minimum değere yuvarlatılmış olarak kaç adım
%uzaklıkta olduğu
if (I==boy)
I=I-1;%+6.5V'u aşmamak için
end
if (I<0)
I=0;%-6.5V'u aşmamak için
end
xq(k)=xmin+I*delta;%kuantalanmış değer
end;
plot(t,x,t,xq);
%% PROGRAM 2C ---
fs = 32000; 
T = 1/fs;
t = 0:T:0.004;
x = 6*cos(2*pi*1000*t); 

% Ortak Kuantalama Parametreleri
xmin = -6.5; 
xmax = 6.5; 
boy = length(x); 

% --- 2 BİT (4 SEVİYE) İÇİN KUANTALAMA ---
bitsay_2 = 2; 
L_2 = 2^bitsay_2; 
delta_2 = (xmax-xmin)/L_2; 
xq_2 = zeros(1, boy); % İşlemi hızlandırmak için hafıza ayırıyoruz

for k = 1:boy
    I = round((x(k)-xmin)/delta_2); 
    if (I >= L_2) % Föydeki boy hatası L_2 olarak düzeltildi
        I = L_2 - 1; 
    end
    if (I < 0) 
        I = 0; 
    end
    xq_2(k) = xmin + I*delta_2; 
end
e2 = xq_2 - x; % 4 seviye için hata

% --- 4 BİT (16 SEVİYE) İÇİN KUANTALAMA ---
bitsay_4 = 4; 
L_4 = 2^bitsay_4; 
delta_4 = (xmax-xmin)/L_4; 
xq_4 = zeros(1, boy);

for k = 1:boy
    I = round((x(k)-xmin)/delta_4); 
    if (I >= L_4) % Föydeki boy hatası L_4 olarak düzeltildi
        I = L_4 - 1; 
    end
    if (I < 0) 
        I = 0; 
    end
    xq_4(k) = xmin + I*delta_4; 
end
e4 = xq_4 - x; % 16 seviye için hata


figure;
% e2 siyah düz çizgi, e4 siyah nokta işaretli çizgi olarak çizdiriliyor
plot(t, e2, 'k-', t, e4, 'k.-'); 
title('Kuantalama Hatalarının Karşılaştırması');
xlabel('Zaman (s)');
ylabel('Hata (V)');
legend('4 seviye ile kuantalanınca oluşan hata', '16 seviye ile kuantalanınca oluşan hata');

% Ortalama hataları komut penceresine yazdıralım
disp(['4 Seviye Ortalama Hata: ', num2str(mean(abs(e2)))]);
disp(['16 Seviye Ortalama Hata: ', num2str(mean(abs(e4)))]);
%% PROGRAM 4
clc;
clear;
clear all;
load('train.mat');

fs=Fs;
T=1/fs;
boy=length(y);
t=[0:1:boy-1]*T;
x=y/max(abs(y));

sure = boy/fs;
fprintf('Sinyalin suresi: %.4f saniye\n', sure);

% 1. grafik: kuantalanmamis sinyal
subplot(3,1,1);
plot(t,x);
title('Kuantalanmamis Sinyal');
xlabel('Zaman (s)');
ylabel('Genlik');

% 2 bit kuantalama
bitsay= 8;
xmin=-1;
xmax=1;
L=2^bitsay;
delta=(xmax-xmin)/L;

xq=zeros(size(x));

for k=1:boy
    I=round((x(k)-xmin)/delta);

    if I>=L
        I=L-1;
    end
    if I<0
        I=0;
    end

    xq(k)=xmin+I*delta;
end

% 2. grafik: kuantalanmis sinyal
subplot(3,1,2);
plot(t,xq);
title('Kuantalanmis Sinyal');
xlabel('Zaman (s)');
ylabel('Genlik');

% 3. grafik: kuantalama hatasi
e = xq - x;
subplot(3,1,3);
plot(t,e);
title('Kuantalama Hatasi');
xlabel('Zaman (s)');
ylabel('Hata');

%% PROGRAM son
% sesleri dinleme
sound(xq,Fs);
pause(sure+1);
sound(x,Fs);
%% PROGRAM 5
% sonraki adım :maksimum ve minimum değerlerini (xmax, xmin) -1.5V ile +1.5V 
clc;
clear;
clear all;
load('train.mat');

fs=Fs;
T=1/fs;
boy=length(y);
t=[0:1:boy-1]*T;
x=y/max(abs(y));

sure = boy/fs;
fprintf('Sinyalin suresi: %.4f saniye\n', sure);

% 1. grafik: kuantalanmamis sinyal
subplot(3,1,1);
plot(t,x);
title('Kuantalanmamis Sinyal');
xlabel('Zaman (s)');
ylabel('Genlik');

% 2 bit kuantalama
bitsay=2;
xmin=-1.5;
xmax=1.5;
L=2^bitsay;
delta=(xmax-xmin)/L;

xq=zeros(size(x));

for k=1:boy
    I=round((x(k)-xmin)/delta);

    if I>=L
        I=L-1;
    end
    if I<0
        I=0;
    end

    xq(k)=xmin+I*delta;
end

% 2. grafik: kuantalanmis sinyal
subplot(3,1,2);
plot(t,xq);
title('Kuantalanmis Sinyal');
xlabel('Zaman (s)');
ylabel('Genlik');

% 3. grafik: kuantalama hatasi
e = xq - x;
subplot(3,1,3);
plot(t,e);
title('Kuantalama Hatasi');
xlabel('Zaman (s)');
ylabel('Hata');