# LexicalAnaliz
Programlama Dili Ödevi
# LexicalAnaliz

Bu proje Swift dilinde basit bir **Lexical Analyzer (sözcüksel çözümleyici)** uygulamasıdır.  
Kullanıcı yazdığı kodu analiz eder ve kelimeleri (token) ayırarak listeler.

## Özellikler
- Kullanıcı arayüzü SwiftUI ile yapıldı.
- Girilen kodda:
  - **Anahtar kelimeler (keyword)**  
  - **Değişken isimleri (identifier)**  
  - **Sayılar (number)**  
  - **Operatörler (+, -, *, /, =)**  
  - **Tanımlanamayan karakterler (unknown)**  
  ayırt edilir.
- `//` ile başlayan yorum satırlarını yok sayar.

## Kullanım
1. Uygulamayı aç.
2. Kodunu metin kutusuna yaz.
3. “Analiz Et” butonuna bas.
4. Token listesini aşağıda görebilirsin.

## Örnek Kod
```swift
int x = 10
if (x > 5) return x
