N = length(x);
f = fs*(0:N/2)/N;

% Hamming pencere
w_ham = hamming(N);

% Filtrelenmemiş ses
x_ham = x .* w_ham;

X_ham = fft(x_ham);
P2_x_ham = abs(X_ham/N);
P1_x_ham = P2_x_ham(1:N/2+1);
P1_x_ham(2:end-1) = 2*P1_x_ham(2:end-1);

figure;
plot(f, P1_x_ham);
grid on;
xlabel('Frekans (Hz)');
ylabel('Genlik');
title('Filtrelenmemiş ses - Hamming pencere');

% Filtrelenmiş ses
y_ham = y_filt .* w_ham;

Y_ham = fft(y_ham);
P2_y_ham = abs(Y_ham/N);
P1_y_ham = P2_y_ham(1:N/2+1);
P1_y_ham(2:end-1) = 2*P1_y_ham(2:end-1);

figure;
plot(f, P1_y_ham);
grid on;
xlabel('Frekans (Hz)');
ylabel('Genlik');
title('Filtrelenmiş ses - Hamming pencere');