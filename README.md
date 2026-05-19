# Digital Signal Processing

MATLAB ile hazırlanmış dijital sinyal işleme deneyleri. Projede örnekleme, kuantalama, FFT tabanlı spektrum analizi, sayısal filtreleme, FIR/IIR filtre tasarımı, ses işleme, equalizer uygulaması ve EKG gürültü temizleme örnekleri yer alır.

## İçerik

- Sürekli zamanlı işaretlerin ayrık örneklerle incelenmesi
- Farklı bit sayılarıyla kuantalama ve kuantalama hatası analizi
- Sinüzoidal işaretlerin toplamı, çarpımı ve frekans spektrumu
- Beyaz Gauss gürültüsü üretimi ve analizi
- MATLAB `train.mat` ses verisi üzerinde zaman/frekans alanı incelemesi
- Başlangıç koşullu ve sıfır başlangıç koşullu sistem cevabı
- `freqz` ile FIR/IIR filtrelerin genlik ve faz cevabı
- Filter Designer ile oluşturulmuş FIR filtre tasarımları
- Gürültülü sinyal süzme, equalizer uygulaması ve EKG işareti temizleme

## Proje Yapısı

```text
.
├── deney_1/
│   └── say.m
├── deney_2/
│   ├── carpma.m
│   ├── gauss.m
│   ├── son_kisim.m
│   ├── toplama.m
│   └── train_load_1.m
└── deney_3/
    ├── deney_3_1_a.m
    ├── deney_3_1_b.m
    ├── deney_3_2_hepsi.m
    ├── deney_3_3.m
    ├── deney3_3_e.m
    ├── deney_3_4_filtre.fda
    ├── deney_3_5_1.fda
    ├── deney_3_5_2_hamming.fda
    ├── deney_3_5_all.m
    ├── deney_3_6.fda
    ├── deney_3_6_all.m
    ├── deney_3_7.m
    ├── deney_3_8.m
    └── deney_3_hoca.m
```

## Gereksinimler

- MATLAB
- Signal Processing Toolbox
- Ses çalma örnekleri için çalışan bir ses çıkışı
- Bazı scriptler için veri dosyaları:
  - `train.mat`: MATLAB'ın örnek ses verisi olarak kullanılabilir.
  - `ecgbn.dat`: EKG filtreleme örnekleri için gereklidir ve bu repoda bulunmaz.
- `.fda` dosyalarını açmak/düzenlemek için MATLAB Filter Designer veya eski adıyla FDATool kullanılabilir.

## Çalıştırma

1. Repoyu klonlayın.

```bash
git clone <repo-url>
cd Digital\ Signal\ Processing
```

2. MATLAB'da proje klasörünü çalışma dizini yapın.

3. Çalıştırmak istediğiniz dosyayı MATLAB Editor üzerinden açın veya komut penceresinden çalıştırın.

```matlab
run('deney_2/toplama.m')
run('deney_2/carpma.m')
run('deney_3/deney_3_1_a.m')
```

4. Birden fazla bölüm içeren dosyalarda MATLAB cell yapısını kullanarak ilgili `%%` bölümünü tek tek çalıştırabilirsiniz.

## Deney Dosyaları

### deney_1

| Dosya | Açıklama |
| --- | --- |
| `say.m` | 1000 Hz kosinüs işaretinin farklı örnekleme frekanslarıyla örneklenmesi, 2 bit/4 bit kuantalama, kuantalama hatası karşılaştırması ve `train.mat` sesi üzerinde kuantalama uygulamaları. |

### deney_2

| Dosya | Açıklama |
| --- | --- |
| `train_load_1.m` | `train.mat` sesini normalize eder, 2 bit kuantalar, orijinal/kuantalanmış işareti ve kuantalama hatasını çizer. |
| `toplama.m` | 500 Hz, 1200 Hz ve 1800 Hz sinüzoidleri üretir; toplam işareti oluşturur, FFT ile spektrumunu inceler ve ses olarak çalar. |
| `carpma.m` | 500 Hz ve 1200 Hz sinüzoidlerinin çarpımını üretir; zaman alanı ve frekans alanı sonuçlarını gösterir. |
| `gauss.m` | 4096 örnekli beyaz Gauss gürültüsü üretir, ilk 50 örneği ve genlik spektrumunu çizer. |
| `son_kisim.m` | `train.mat` tren düdüğü sesini zaman alanında ve FFT ile frekans alanında analiz eder. |

### deney_3

| Dosya | Açıklama |
| --- | --- |
| `deney_3_1_a.m` | `B = [2 -4]`, `A = [1 0.5 1]` sisteminde başlangıç koşullarıyla filtre cevabını hesaplar. |
| `deney_3_1_b.m` | Aynı sistemin sıfır başlangıç koşullu cevabını üretir. |
| `deney_3_2_hepsi.m` | Üç farklı filtrenin genlik ve faz tepkisini `freqz` ile inceler. |
| `deney_3_3.m` | `y[n] = x[n] - x[n-1]` biçimindeki FIR fark filtresini ses işaretine uygular; zaman ve frekans alanı sonuçlarını çizer. |
| `deney3_3_e.m` | `deney_3_3.m` sonrasında oluşan `x`, `y_filt` ve `fs` değişkenlerini kullanarak Hamming pencere ile spektrum analizi yapar. |
| `deney_3_4_filtre.fda` | Filter Designer oturumu: 8000 Hz örnekleme frekanslı, pencere tabanlı band geçiren FIR filtre tasarımı. |
| `deney_3_5_1.fda` | Filter Designer oturumu: 24. dereceden, rectangular pencereli, 2000 Hz kesim frekanslı alçak geçiren FIR filtre. |
| `deney_3_5_2_hamming.fda` | Filter Designer oturumu: 24. dereceden, Hamming pencereli, 2000 Hz kesim frekanslı alçak geçiren FIR filtre. |
| `deney_3_5_all.m` | `train.mat` sesini rectangular ve Hamming FIR filtrelerle süzer; orijinal ve filtrelenmiş spektrumları karşılaştırır. |
| `deney_3_6.fda` | Filter Designer oturumu: 132. dereceden, Hamming pencereli, 900 Hz kesim frekanslı alçak geçiren FIR filtre. |
| `deney_3_6_all.m` | Gürültülü 500 Hz sinüs üretir, FDA'dan gelen FIR katsayılarıyla süzer ve zaman/frekans alanı karşılaştırması yapar. |
| `deney_3_7.m` | Gürültülü EKG verisini 60/120/180 Hz notch filtreler ve 0.25-40 Hz band geçiren filtre ile temizler; zero-crossing yaklaşımıyla kalp hızı hesaplar. |
| `deney_3_8.m` | Çok bantlı IIR equalizer örneği; bas ve tiz bileşenleri güçlendirip orta frekansları bastırır. |
| `deney_3_hoca.m` | EKG filtreleme için referans/öğretmen versiyonu. `deney_3_7.m`, bu akışın daha tamamlanmış ve çalıştırılabilir halidir. |

## FDA Dosyaları ve Katsayı Aktarımı

`deney_3_5_all.m` ve `deney_3_6_all.m` doğrudan `.fda` dosyalarını okumaz; MATLAB çalışma alanında önceden oluşturulmuş filtre katsayılarını bekler.

Beklenen değişkenler:

| Script | Gerekli değişken | İlgili tasarım dosyası |
| --- | --- | --- |
| `deney_3_5_all.m` | `Num_rect` | `deney_3_5_1.fda` |
| `deney_3_5_all.m` | `Num_Ham` | `deney_3_5_2_hamming.fda` |
| `deney_3_6_all.m` | `Num_6` | `deney_3_6.fda` |

Bu değişkenleri oluşturmak için ilgili `.fda` dosyasını Filter Designer içinde açıp filtre katsayılarını workspace'e export edin. Ardından ilgili `.m` dosyasını çalıştırın.

## Notlar

- Bu proje eğitim/laboratuvar amaçlıdır; scriptler genellikle tek tek deney adımlarını gösterecek şekilde yazılmıştır.
- Bazı dosyalar grafik pencereleri açar, bazıları `sound` komutu ile ses çalar.
- `ecgbn.dat` repoda olmadığı için EKG örneklerini çalıştırmadan önce bu dosyayı proje dizinine eklemeniz gerekir.
- `.fda` dosyaları MATLAB v5 MAT dosyası formatında kaydedilmiş Filter Designer oturumlarıdır.

## Lisans

Bu proje için henüz lisans dosyası eklenmemiştir. GitHub'da paylaşmadan önce uygun bir lisans seçebilirsiniz.
