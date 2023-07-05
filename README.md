# kelime-oyunu

Flutter kullanılara Dart dilinde yapılan bir kelime oyunudur.

Oyun 8x10’luk(yani 8 sütun 10 satır olacak) bir alan üzerinde kelime seçilerek anlamlı kelimeler oluşturulacaktır. 
Harfler yukarıdan aşağıya doğru düşecek. Oyun ilk başladığında yukarıdan aşağıya doğru 3 satır tamamen dolu olacak şekilde rastgele harfler indirilecek ve oyun başlanacaktır. 
Kullanıcıdan bu harfler kullanılarak anlamlı kelimeler oluşturulması beklenmektedir. Anlamlı kelimeler için sırası ile harfler seçilerek kelime oluşturulmalıdır. 
Oluşturulan kelimenin anlamlı kelime olduğunun kontrolü için onay düğmesine veya ekranı sağ tarafa doğru kaydırarak kontrol etmesi istenmektedir. 
ğer oluşturulan kelime anlamsız ise silme işlemi için silme butonu olması gereklidir. Harfler seçilip bırakması için aktif olmalıdır. 
Seçilen harf istenmiyorsa üstüne tıklanarak iptal edilebilmelidir. Harfler anlamlı bir kelime oluşturulabilmesi için sesli veya sessiz harf karışık gelmesi gerekmektedir. 
Bu durumun kontrol sağlanmalı ona göre belirli oranlarda sesli ve sessiz harfler ile başlanmalıdır. 
Oyun başlangıcından sonra belirlenen süre aralıklarında yukarıdan aşağıya doğru rastgele herhangi bir sütundan harf düşmesi beklenmektedir. 
Harfler sesli veya sessiz olmak üzere karışık bir şekilde olması gereklidir. Harf düşmesi işlemi ilk başta 5 saniyede bir gerçekleşecektir. 
Bu süre puanın her 100 ve katlarına ulaştığında bir saniye azalacaktır. Azalma işlemi 1 saniye ulaşıncaya kadar devam edecektir. 
Oyun içerisinde doğru kelimenin oluşturulması ile puan hesaplanması beklenmektedir. Puan hesaplaması için oluşturulan kelimenin harflerine bağlı olacak şekilde puan hesaplanacaktır. 
Harf doğru ise puan hesaplandıktan sonra harfler ekrandan kaybolacak ve üstündeki harfler aşağıya doğru hareket edecektir. 
Oluşturulan kelimenin yanlış olma durumu kayıt altına alınacaktır. 3 kez yanlış girilmesi
durumunda tüm sütunlardan harfler düşecektir ve hatalı kelime sayısı sıfırlanacaktır. Her üç yanlış kelime girilmesinde aynı işlem gerçekleşecektir. 
Oyun bir sütunun yukarıya doğru harfler ile tamamen dolması ile sonlanacaktır. Sonlandırdıktan sonra puanı güncel puan listesine eklenecektir.
