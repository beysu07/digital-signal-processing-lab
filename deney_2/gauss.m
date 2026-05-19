clear; clc; close all; % Eski verileri ve pencereleri temizler

% --- 1. BÖLÜM: Gauss Dağılımlı Beyaz Gürültü ---
x = 5 * randn([1,4096]); % 4096 tane rastgele gürültü örneği oluşturulması

% a. İlk 50 örneğin stem (ayrık) grafiğinin çizilmesi
figure;
subplot(2,1,1);
stem(x(1:50));
title('Beyaz Gürültü (İlk 50 Örnek)');
xlabel('Zaman İndeksi (n)');
ylabel('Genlik');

% b. FFT hesaplaması ve genlik spektrumunun çizilmesi
Ak = abs(fft(x)) / length(x); % Fourier dönüşümü alınıp normalize ediliyor
fs = 8000; % Örnekleme hızı
k = 0:1:length(x)-1;  % frekans indeksi
f = k * fs / length(x); % İndekslerin Hz (Frekans) cinsine çevrilmesi

subplot(2,1,2);
plot(f, Ak); % Spektrum grafiği
title('Beyaz Gürültü Genlik Spektrumu');
xlabel('Frekans (Hz)');
ylabel('Genlik (|Ak|)');

% c. Sinyali Dinleme
disp('Beyaz gürültü sesi çalınıyor (Televizyon karıncalanması gibi bir ses duyacaksın)...');
sound(x/max(abs(x)), 8000);