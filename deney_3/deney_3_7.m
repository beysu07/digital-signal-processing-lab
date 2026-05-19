fs = 44100;         % Örnekleme frekansı [cite: 600]
T = 1/fs;
n = 0:20000;        % Analiz için örnek sayısı
t = n * T;

% 1. Test Sinyalinin Oluşturulması 
x = sin(200*pi*n/fs) + ...
    sin(400*pi*n/fs + pi/14) + ...
    sin(800*pi*n/fs + pi/7) + ...
    sin(2000*pi*n/fs + 3*pi/14) + ...
    sin(5000*pi*n/fs + 2*pi/7) + ...
    sin(12000*pi*n/fs + 5*pi/14) + ...
    sin(30000*pi*n/fs + 3*pi/7);

% 2. Filtre Katsayılarının Tanımlanması (B: Pay, A: Payda) 
B0=[0.0031954934 0 -0.0031954934]; A0=[1.0000000000 -1.9934066716 0.9936090132];
B1=[0.0063708102 0 -0.0063708102]; A1=[1.0000000000 -1.9864516324 0.9872583796];
B2=[0.0126623878 0 -0.0126623878]; A2=[1.0000000000 -1.9714693192 0.9746752244];
B3=[0.0310900413 0 -0.0310900413]; A3=[1.0000000000 -1.9181849043 0.9378199174];
B4=[0.0746111954 0 -0.0746111954]; A4=[1.0000000000 -1.7346085867 0.8507776092];
B5=[0.1663862883 0 -0.1663862884]; A5=[1.0000000000 -1.0942477187 0.6672274233];
B6=[0.3354404899 0 -0.3354404899]; A6=[1.0000000000 0.7131366534 0.3291190202];

% 3. Kazanç Değerleri
g0=10; g1=10; g2=0; g3=0; g4=0; g5=10; g6=10;

% 4. Filtreleme ve Kazanç Uygulama (IIR Filter)
y0 = filter(B0, A0, x) * g0;
y1 = filter(B1, A1, x) * g1;
y2 = filter(B2, A2, x) * g2;
y3 = filter(B3, A3, x) * g3;
y4 = filter(B4, A4, x) * g4;
y5 = filter(B5, A5, x) * g5;
y6 = filter(B6, A6, x) * g6;

% Çıkış sinyali
y_toplam = y0 + y1 + y2 + y3 + y4 + y5 + y6;

% 5. Analiz ve Görselleştirme
figure('Name', 'Equalizer Uygulama Sonuçları');

% Zaman Domeni
subplot(2,1,1);
plot(t(1:1000), x(1:1000), 'b'); hold on;
plot(t(1:1000), y_toplam(1:1000), 'r', 'LineWidth', 1.2);
title('Zaman Domeni: Giriş (Mavi) vs Equalizer Çıkışı (Kırmızı)');
xlabel('Zaman (sn)'); ylabel('Genlik');
legend('Giriş Sinyali', 'Çıkış Sinyali');

% Frekans Domeni (FFT)
subplot(2,1,2);
N_fft = length(x);
f = (0:N_fft-1) * (fs / N_fft);
X_abs = abs(fft(x)) / N_fft;
Y_abs = abs(fft(y_toplam)) / N_fft;

plot(f(1:N_fft/2), X_abs(1:N_fft/2), 'b'); hold on;
plot(f(1:N_fft/2), Y_abs(1:N_fft/2), 'r', 'LineWidth', 1.2);
title('Frekans Spektrumu: Bas ve Tizlerin Güçlendirilmesi, Orta Seslerin Silinmesi');
xlabel('Frekans (Hz)'); ylabel('Genlik');
axis([0 20000 0 1]); % 20kHz'e kadar odaklan
legend('Giriş Spektrumu', 'Çıkış Spektrumu');

% 6. Ses Dinleme 
%sound(x/max(abs(x)), fs); pause(1);
%sound(y_toplam/max(abs(y_toplam)), fs);