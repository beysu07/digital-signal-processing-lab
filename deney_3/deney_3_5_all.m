clc;
close all;

load train.mat
x = y;
fs = 8000;

% Filtreleme
y_rect = filter(Num_rect, 1, x);
y_ham  = filter(Num_Ham, 1, x);

% FFT hazırlık
N = length(x);
f = fs*(0:N/2)/N;

%% Orijinal sinyal
X = fft(x);
P2_x = abs(X/N);
P1_x = P2_x(1:N/2+1);
P1_x(2:end-1) = 2*P1_x(2:end-1);

figure;
plot(f, P1_x);
grid on;
xlabel('Frekans (Hz)');
ylabel('Genlik');
title('Orijinal sinyal');

%% Rectangular filtreli
Y_rect = fft(y_rect);
P2_rect = abs(Y_rect/N);
P1_rect = P2_rect(1:N/2+1);
P1_rect(2:end-1) = 2*P1_rect(2:end-1);

figure;
plot(f, P1_rect);
grid on;
xlabel('Frekans (Hz)');
ylabel('Genlik');
title('Rectangular filtreli sinyal');

%% Hamming filtreli
Y_ham = fft(y_ham);
P2_ham = abs(Y_ham/N);
P1_ham = P2_ham(1:N/2+1);
P1_ham(2:end-1) = 2*P1_ham(2:end-1);

figure;
plot(f, P1_ham);
grid on;
xlabel('Frekans (Hz)');
ylabel('Genlik');
title('Hamming filtreli sinyal');