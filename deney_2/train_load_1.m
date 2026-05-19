clc;                        % Komut penceresini temizler
clear;                      % Çalışma alanındaki tüm değişkenleri siler
close all;                  % Açık olan tüm grafik pencerelerini kapatır

load('train.mat')           % train.mat dosyasını yükler
                            % Bu dosya y adlı ses dizisini ve Fs adlı örnekleme frekansını içerir

fs = Fs;                    % Ses işaretinin örnekleme frekansı alınır
T = 1/fs;                   % Örnekleme periyodu hesaplanır
boy = length(y);            % y dizisindeki toplam örnek sayısı bulunur
t = [0:1:boy-1]*T;          % Her örneğe karşılık gelen zaman ekseni oluşturulur

x = y/max(abs(y));          % Ses sinyali normalize edilir
                            % Böylece sinyalin genlik değerleri -1 ile +1 aralığına getirilir
                            % Bu işlem kuantalama öncesi taşmayı önlemek ve standartlaştırmak için yapılır

bitsay = 2;                 % Kuantalayıcı çıkışının bit sayısı 2 olarak seçilir
xmin = -1;                  % Normalize edilen işaretin minimum değeri
xmax = 1;                   % Normalize edilen işaretin maksimum değeri
L = 2^bitsay;               % Toplam kuantalama seviye sayısı hesaplanır
                            % 2 bit için 2^2 = 4 seviye vardır
delta = (xmax-xmin)/L;      % Her bir kuantalama adımının büyüklüğü hesaplanır

xq = zeros(1,boy);          % Kuantalanmış sinyali saklamak için sıfırlardan oluşan bir dizi oluşturulur

for k = 1:boy               % Tüm örnekler sırayla işlenir
    
    I = round((x(k)-xmin)/delta);
                            % x(k) örneğinin xmin değerine göre kaç adım uzakta olduğu bulunur
                            % round komutu ile en yakın kuantalama seviyesine yuvarlama yapılır
    
    if I == L
        I = I-1;            % Üst sınırı aşan durumlarda indis son geçerli seviyeye çekilir
    end
    
    if I < 0
        I = 0;              % Alt sınırın altına düşen değerler minimum seviyeye sabitlenir
    end
    
    xq(k) = xmin + I*delta; % Hesaplanan seviyeye karşılık gelen kuantalanmış değer atanır
end

figure;                     % Yeni bir grafik penceresi açılır
plot(t,x,t,xq);             % Orijinal ve kuantalanmış işaret aynı grafikte çizilir
grid on;                    % Izgara eklenir
xlabel('Zaman (s)');        % x ekseni etiketi
ylabel('Genlik');           % y ekseni etiketi
title('Orijinal ve Kuantalanmış Ses İşareti');   % Grafik başlığı
legend('Orijinal','Kuantalanmış');               % İşaretlerin isimleri gösterilir

e = xq - x;                 % Kuantalama hatası hesaplanır
                            % Her örnek için kuantalanmış değer ile gerçek değer arasındaki fark bulunur

figure;                     % Yeni bir grafik penceresi açılır
plot(t,e);                  % Kuantalama hatası zamana karşı çizilir
grid on;                    % Izgara eklenir
xlabel('Zaman (s)');        % x ekseni etiketi
ylabel('Hata');             % y ekseni etiketi
title('Kuantalama Hatası'); % Grafik başlığı

eort = mean(abs(e));        % Ortalama mutlak kuantalama hatası hesaplanır
                            % Hatanın işareti önemli olmadığı için mutlak değeri alınır
                            % Daha sonra tüm örnekler için ortalama alınır

disp(['Ortalama kuantalama hatası = ', num2str(eort)]);
                            % Hesaplanan ortalama hata komut penceresinde gösterilir