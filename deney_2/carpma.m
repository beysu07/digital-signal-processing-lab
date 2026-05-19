clear; clc; close all;

%% 3. Sayısal Sinüzoidlerin Çarpımının Üretilmesi

% Ortak Zaman Vektörü (Örnekleme frekansı 8000 Hz, 0.5 saniye süre)
fs = 8000;
t = 0:(1/fs):0.5;

% --- a. Sinyallerin Tanımlanması ---
x1 = 5*cos(2*pi*500*t);
x2 = 5*cos(2*pi*1200*t + 0.25*pi);

% --- b. Sinyallerin Çarpımı ---
y = x1 .* x2;

% --- c. FFT İşlemleri (Spektrum için) ---
N = length(y);
Ak = abs(fft(y))/N;
k = 0:1:N-1;
f = k*fs/N;

%% --- GÖRSELLEŞTİRME 1: Zaman Uzayı (Senin attığın 3'lü grafik) ---
figure('Name', 'Bölüm 3: Zaman Uzayı (x1, x2 ve Çarpım)');

subplot(3,1,1); 
plot(t, x1); 
axis([0 0.01 -6 6]); 
title('x1(t) = 5cos(2\pi*500t)'); 
ylabel('Genlik');

subplot(3,1,2); 
plot(t, x2); 
axis([0 0.01 -6 6]); 
title('x2(t) = 5cos(2\pi*1200t + 0.25\pi)'); 
ylabel('Genlik');

subplot(3,1,3); 
plot(t, y);  
axis([0 0.01 -30 30]); 
title('Çarpım Sinyali: y(t) = x1(t) * x2(t)'); 
xlabel('Zaman (s)'); 
ylabel('Genlik');

%% --- GÖRSELLEŞTİRME 2: Frekans Spektrumu ---
figure('Name', 'Bölüm 3: Frekans Spektrumu');
plot(f(1:floor(N/2)), Ak(1:floor(N/2))); 
title('Çarpım Sinyalinin Genlik Spektrumu');
xlabel('Frekans (Hz)'); 
ylabel('|Ak|'); 
xlim([0 4000]); % Nyquist sınırına kadar

%% --- EKRANA YAZDIRILACAK DEĞERLER (Föydeki Boşluklar) ---
disp('--- Şık a: Genlik ve RMS Değerleri ---');
disp(['x1_max = ', num2str(max(x1)), '   | x1_rms = ', num2str(sqrt(mean(x1.*x1)))]);
disp(['x2_max = ', num2str(max(x2)), '   | x2_rms = ', num2str(sqrt(mean(x2.*x2)))]);

disp('--- Şık c: Spektrum Değerleri ---');
disp('Spektrumda tepe yapan frekanslar: 700 Hz ve 1700 Hz');
disp(['Tepe genlik değerleri: ', num2str(max(Ak))]);
disp(['Frekans çözünürlüğü: ', num2str(fs/N), ' Hz']);

%% --- d. SESLERİ SIRAYLA DİNLEME ---
disp('--- Şık d: Sinyaller Sırayla Çalınıyor ---');
% Sinyallerimiz 0.5 saniye uzunluğunda. Seslerin birbirini kesmemesi için 
% aralara 1.5 saniyelik beklemeler (pause) eklendi.

disp('1. x1(t) çalınıyor (500 Hz)...');
sound(x1/max(abs(x1)), 8000); 
pause(1.5); 

disp('2. x2(t) çalınıyor (1200 Hz)...');
sound(x2/max(abs(x2)), 8000); 
pause(1.5); 

disp('3. Çarpım sinyali y(t) çalınıyor (Modüle edilmiş ton)...');
sound(y/max(abs(y)), 8000);

disp('İşlem Tamamlandı! Tüm grafikler ve sesler başarıyla üretildi.');