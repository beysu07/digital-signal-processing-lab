clc;
close all;

% Filtre
fs = 8000;
alpha = 1;
B = [1 -alpha];
A = [1];

% (a) Frekans tepkisi
[H,fresp] = freqz(B, A, 1024, fs);4

figure;
plot(fresp, 20*log10(abs(H)));
grid on;
xlabel('Frekans (Hz)');
ylabel('Genlik (dB)');
title('Deney 3(a) - Genlik tepkisi');

figure;
plot(fresp, angle(H));
grid on;
xlabel('Frekans (Hz)');
ylabel('Faz (radyan)');
title('Deney 3(a) - Faz tepkisi');

% (b) Ses dosyasını yükleme
load train.mat
x = y;                     % train.mat içindeki ses değişkeni y ise
y_filt = filter(B, A, x);

% (c) Zaman domeni
N = length(x);
t = (0:N-1)/fs;

figure;
plot(t, x);
grid on;
xlabel('Zaman (s)');
ylabel('Genlik');
title('Filtrelenmemiş ses - Zaman domeni');

figure;
plot(t, y_filt);
grid on;
xlabel('Zaman (s)');
ylabel('Genlik');
title('Filtrelenmiş ses - Zaman domeni');

% (c)-(d) Frekans domeni ve tek taraflı tayf
X = fft(x);
Y = fft(y_filt);

P2_x = abs(X/N);
P1_x = P2_x(1:N/2+1);
P1_x(2:end-1) = 2*P1_x(2:end-1);

P2_y = abs(Y/N);
P1_y = P2_y(1:N/2+1);
P1_y(2:end-1) = 2*P1_y(2:end-1);

f = fs*(0:N/2)/N;

figure;
plot(f, P1_x);
grid on;
xlabel('Frekans (Hz)');
ylabel('Genlik');
title('Filtrelenmemiş ses - Tek taraflı tayf');

figure;
plot(f, P1_y);
grid on;
xlabel('Frekans (Hz)');
ylabel('Genlik');
title('Filtrelenmiş ses - Tek taraflı tayf');