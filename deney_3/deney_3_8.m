clc; 
close all;

load ecgbn.dat;  % Gürültülü EKG verisini yükle 

% --- ADIM 1: Notch (Çentik) Filtreler ---
% Şebeke gürültüsü (60Hz) ve harmoniklerini (120Hz, 180Hz) siler [cite: 260-265]
b1=[0.9803 -1.5862 0.9803]; a1=[1 -1.5842 0.9586]; % 60 Hz Notch
b2=[0.9794 -0.6053 0.9794]; a2=[1 -0.6051 0.9586]; % 120 Hz Notch
b3=[0.9793 0.6052 0.9793];  a3=[1 0.6051 0.9586];  % 180 Hz Notch

y1=filter(b1,a1,ecgbn);  
y2=filter(b2,a2,y1);        
y3=filter(b3,a3,y2); % Şebeke gürültüsü temizlenmiş sinyal [cite: 277]

% --- ADIM 2: Band Geçiren Filtre Tasarımı (0.25 - 40 Hz) ---
% DC kaymayı ve kas gürültülerini siler [cite: 281-285]
fs=600; T=1/600; % Örnekleme hızı 600 Hz
wd1=2*pi*0.25; wd2=2*pi*40; % Hedef radyan frekanslar

% Bilinear Dönüşümü (BLT) hazırlığı
wa1=(2/T)*tan(wd1*T/2);
wa2=(2/T)*tan(wd2*T/2);
[B_ana, A_ana] = lp2bp([1.4314], [1 1.4652 1.5162], sqrt(wa1*wa2), wa2-wa1);

% HATA DÜZELTME: Analogtan Dijitale geçiş ve atama
[b, a] = bilinear(B_ana, A_ana, fs); 

y4 = filter(b, a, y3); % Band geçiren filtreleme [cite: 281]

% --- ADIM 3: Görselleştirme ---
t=0:T:(length(ecgbn)-1)*T;
subplot(3,1,1); plot(t, ecgbn); title('Gürültülü EKG'); grid; ylabel('(a)');
subplot(3,1,2); plot(t, y3); title('Notch Filtre Sonrası'); grid; ylabel('(b)');
subplot(3,1,3); plot(t, y4); title('Band Geçiren Filtre Sonrası (Temiz)'); grid; ylabel('(c)');
xlabel('Zaman (sn)');

% --- ADIM 4: Kalp Hızı Hesaplama (Zero-Crossing Algoritması) ---
zcross=0.0; threshold=0.5;
for n=2:length(y4)
    pre_sign = -1; cur_sign = -1;
    if y4(n-1) > threshold, pre_sign = 1; end
    if y4(n) > threshold, cur_sign = 1; end
    % Eşik değerini geçen tepe noktalarını sayar 
    zcross = zcross + abs(cur_sign - pre_sign) / 2;
end

heart_rate = (zcross * 60) / (length(y4) / fs) / 2; % Dakikadaki atım sayısı
fprintf('Hesaplanan Kalp Hızı: %.2f BPM\n', heart_rate);