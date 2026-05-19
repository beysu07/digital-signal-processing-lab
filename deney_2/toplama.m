clear; clc; close all;

%% 2. Sayısal Sinüzoidlerin Toplamının Üretilmesi

% Ortak Zaman Vektörü (Örnekleme frekansı fs = 8000 Hz)
fs = 8000;
T = 1/fs; 
t = 0:T:0.5; % 0'dan 0.5 saniyeye kadar (sinyaller 0.5 sn sürecek)

% a. Sinyallerin Tanımlanması
x1 = 5*cos(2*pi*500*t);
x2 = 5*cos(2*pi*1200*t + 0.25*pi);
x3 = 5*cos(2*pi*1800*t + 0.5*pi);

% --- Hesaplanan ve Ölçülen Değerlerin Ekrana Yazdırılması ---
disp('--- Şık a: Faz ve Genlik Kontrolü ---');
disp(['Hesaplanan x1(0) = ', num2str(5 * cos(0)), '   | x1_max = 5']);
disp(['Ölçülen    x1(0) = ', num2str(x1(1)), '   | x1_max = ', num2str(max(x1))]);

disp(['Hesaplanan x2(0) = ', num2str(5 * cos(0.25*pi)), ' | x2_max = 5']);
disp(['Ölçülen    x2(0) = ', num2str(x2(1)), ' | x2_max = ', num2str(max(x2))]);

disp(['Hesaplanan x3(0) = ', num2str(5 * cos(0.5*pi)), '   | x3_max = 5']);
disp(['Ölçülen    x3(0) = ', num2str(x3(1)), ' | x3_max = ', num2str(max(x3))]);
disp('------------------------------------------');

% --- Şık a: 3 Sinyalin Ayrı Ayrı Çizimi ---
figure('Name', 'Bölüm 2a: Bireysel Sinyaller');
subplot(3,1,1); plot(t, x1); axis([0 0.01 -6 6]); title('x1(t) = 5cos(2\pi*500t)');
subplot(3,1,2); plot(t, x2); axis([0 0.01 -6 6]); title('x2(t) = 5cos(2\pi*1200t + 0.25\pi)');
subplot(3,1,3); plot(t, x3); axis([0 0.01 -6 6]); title('x3(t) = 5cos(2\pi*1800t + 0.5\pi)'); xlabel('Zaman (s)');

%% b. Üretilen Üç Sinyalin Toplamı
x_toplam = x1 + x2 + x3;

figure('Name', 'Bölüm 2b ve 2c: Toplam Sinyal ve Spektrum');
subplot(2,1,1);
plot(t, x_toplam); axis([0 0.01 -15 15]); 
title('Sinyallerin Toplamı: x(t) = x1(t) + x2(t) + x3(t)');
xlabel('Zaman (s)'); ylabel('Genlik');

%% c. FFT ile Spektrum Analizi
N = length(x_toplam);
Ak = abs(fft(x_toplam)) / N; 
k = 0:1:N-1;
f = k * fs / N; 

subplot(2,1,2);
plot(f(1:floor(N/2)), Ak(1:floor(N/2))); 
title('Sinyal Toplamının Genlik Spektrumu');
xlabel('Frekans (Hz)'); ylabel('|Ak|');
xlim([0 4000]); 

% --- Şık c: Soruların Cevaplarının Ekrana Yazdırılması ---
disp('--- Şık c: Spektrum Analizi Soruları ---');
disp(['Örnekleme hızı nedir?: ', num2str(fs), ' Hz']);
disp('Spektrumda hangi frekanslar gözükmektedir?: 500 Hz, 1200 Hz ve 1800 Hz');
disp(['Görebildiğiniz en yüksek frekans kaçtır?: ', num2str(fs/2), ' Hz']);
disp(['Programınıza göre frekans çözünürlüğü kaçtır?: ', num2str(fs/N), ' Hz']);

%% d. Sinyalleri Dinleme (Otomatik Geçişli)
disp('--- Şık d: Sinyaller Dinleniyor ---');

disp('1. x1(t) çalınıyor (500 Hz)...');
sound(x1/max(abs(x1)), 8000); 
pause(1); % Sesin bitmesini ve diğerine geçmesini bekler

disp('2. x2(t) çalınıyor (1200 Hz)...');
sound(x2/max(abs(x2)), 8000); 
pause(1);

disp('3. x3(t) çalınıyor (1800 Hz)...');
sound(x3/max(abs(x3)), 8000); 
pause(1);

disp('4. Toplam sinyal x(t) çalınıyor (Hepsi bir arada)...');
sound(x_toplam/max(abs(x_toplam)), 8000);

disp('İşlem tamamlandı!');