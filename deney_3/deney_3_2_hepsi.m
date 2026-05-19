% a Şıkkı
Ba = [1]; 
Aa = [1, -0.5];

figure('Name', 'Filtre a: ');
freqz(Ba, Aa, 512); % 512 nokta kullanarak tepkiyi hesaplar ve otomatik çizdirir


% b Şıkkı: FIR
Bb = [1, -0.5]; 
Ab = [1];

figure('Name', 'Filtre b: ');
freqz(Bb, Ab, 512);


%c Şıkkı: ıır
Bc = [0.5, 0, -0.32]; 
Ac = [1, -0.5, 0.25];

figure('Name', 'Filtre c');
freqz(Bc, Ac, 512);