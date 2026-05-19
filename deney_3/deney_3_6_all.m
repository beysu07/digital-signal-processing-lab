clc;
close all;

fs = 8000;
n = 0:499;

v = 0.5*randn(size(n));
x = 1.4141*sin(2*pi*500*n/fs) + v;

y = filter(Num_6, 1, x);

t = n/fs;

figure;
plot(t, x);
grid on;
xlabel('Zaman (s)');
ylabel('Genlik');
title('Filtrelenmemiş sinyal');

figure;
plot(t, y);
grid on;
xlabel('Zaman (s)');
ylabel('Genlik');
title('Filtrelenmiş sinyal');

Nfft = length(x);
f = fs*(0:Nfft/2)/Nfft;

X = fft(x);
P2 = abs(X/Nfft);
P1 = P2(1:Nfft/2+1);
P1(2:end-1) = 2*P1(2:end-1);

figure;
plot(f, P1);
grid on;
xlabel('Frekans (Hz)');
ylabel('Genlik');
title('Filtrelenmemiş sinyal - Frekans domeni');

Y = fft(y);
P2y = abs(Y/Nfft);
P1y = P2y(1:Nfft/2+1);
P1y(2:end-1) = 2*P1y(2:end-1);

figure;
plot(f, P1y);
grid on;
xlabel('Frekans (Hz)');
ylabel('Genlik');
title('Filtrelenmiş sinyal - Frekans domeni');