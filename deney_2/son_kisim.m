clear; clc; close all;

% --- a. Sesi Yükleme ve Zaman Uzayında Çizdirme ---
load train.mat;         % y: ses verisi, Fs: 8192 Hz
x = y;                  % Sinyali x değişkenine aktarma

figure('Name', 'Gerçek Ses (Tren Düdüğü) Analizi');

n = 0:1:length(x)-1;    % Zaman indeksleri
T = 1/Fs;               % Adım büyüklüğü (Periyot)
t = n*T;                % Saniye cinsinden zaman vektörü

subplot(2,1,1); 
plot(t, x); 
title('Tren Düdüğü Ses Sinyali (Zaman Uzayı)'); 
xlabel('Zaman (s)'); ylabel('Genlik');

% --- b. FFT Hesaplaması ve Spektrum Çizimi ---
Ak = abs(fft(x)) / length(x);
k = 0:1:length(x)-1;    % Frekans indeksleri

% HATA DÜZELTMESİ: Föydeki 8000 yerine gerçek Fs değişkenini kullanıyoruz
f = k * Fs / length(Ak); 

subplot(2,1,2); 
plot(f, Ak); 
title('Tren Düdüğü Genlik Spektrumu');
xlabel('Frekans (Hz)'); ylabel('Genlik (|Ak|)');
xlim([0 Fs/2]);         % Nyquist teoremine göre sadece fs/2'ye kadar çizdirmek yeterlidir

% --- c. Sesi Dinleme ---
disp('Tren düdüğü sesi çalınıyor...');
sound(x/max(abs(x)), Fs);