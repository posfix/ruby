PosFix Ruby On Rails Client Kütüphanesi
===================

PosFix Ruby On Rails Client Kütüphanesidir. PosFix API'lerine çok hızlı bir şekilde bağlanmanızı sağlar.
[https://www.posfix.com.tr](https://www.posfix.com.tr) adresimizden mağaza başvurusu yaparak
hesabınızı açabilirsiniz.

## Entegrasyon sürecinde dikkat edilecek noktalar

PosFix servislerini kullanabilmek için PosFix'e üye olmalısınız. Üye olduktan sonra Mağaza Listesi > Detay sayfası içerisindeki Public ve Private Key sizinle paylaşılacaktır. Paylaşılan bu anahtarları posfix-ruby projesinde ApplicationController'da yer alan publicKey ve privateKey alanlarına eklemeniz gerekmektedir.

```ruby
class ApplicationController < ActionController::Base
    @@settings = Settings.new
    @@settings.PublicKey = '' #//"Public Magaza Anahtarı - size mağaza başvurunuz sonucunda gönderilen public key (açık anahtar) bilgisini kullanınız.",
    @@settings.PrivateKey = '' #"Private Magaza Anahtarı  - size mağaza başvurunuz sonucunda gönderilen privaye key (gizli anahtar) bilgisini kullanınız.",
    @@settings.BaseUrl = 'https://api.posfix.com.tr/' #PosFix web servisleri API url'lerinin başlangıç bilgisidir. Restful web servis isteklerini takip eden kodlar halinde bulacaksınız.
    @@settings.Version = '1.0' # Kullandığınız PosFix API versiyonudur.
    @@settings.Mode = 'T' #Test -> T, entegrasyon testlerinin sırasında "T" modunu, canlı sisteme entegre olarak ödeme almaya başlamak için ise Prod -> "P" modunu kullanınız.
    @@settings.HashString = '' #// Kullanacağınız hash bilgisini, bağlanmak istediğiniz web servis bilgisine göre doldurulmalıdır. Bu bilgileri Entegrasyon rehberinin ilgili web servise ait bölümde bulabilirsiniz.
    @@settings.Echo = ''
end
```

Örnek projelerimizdeki servislerimizi daha iyi anlamak için [PosFix geliştirici merkezini](http://developer.posfix.com.tr) takip etmeniz büyük önem arz etmektedir.

* Entegrasyon işlemlerinde encoding “UTF-8” kullanılması önerilmektedir.Token parametrelerinden kaynaklı sorun encoding probleminden kaynaklanmaktadır. Özel karakterlerde encoding işlemi yapılmalıdır.
* Servis isteği yaparaken göndermiş olduğunuz alanların başında ve sonunda oluşabilecek boşluk alanlarını kaldırmanızı ( trim() ) önemle rica ederiz. Çünkü bu alanlar oluşacak hash sonuçlarını etkilemektedir.
* Entegrasyon dahilinde gönderilen input alanlarında, kart numarası alanı dışında kart numarası bilgisi gönderilmesi halinde işlem reddedilecektir.

PosFix örnek projelerinin amacı, yazılım geliştiricilere PosFix servislerine entegre olabilecek bir proje örneği sunmak ve entegrasyon adımlarının daha iyi anlaşılmasını sağlamaktır.
Projeleri doğrudan canlı ortamınıza alarak kod değişimi yapmadan kullanmanız için desteğimiz bulunmamaktadır. **Projeyi bir eğitsel kaynak (tutorial) olarak kullanınız.**

## Kurulum

Ruby on Rails projesini `bundle install --binstubs` komutu ile yapılandırmanız gerekmektedir. Sonrasında Gemfile.json'daki bilgilere uygun olarak gem paketlerinin ve /bin dizininin kurulduğunu göreceksiniz.

## Test Kartları

Başarılı bir ödemeyi test etmek için aşağıdaki kart numaralarını ve diğer bilgileri kullanabilirsiniz.

| Sıra No  | Kart Numarası     | SKT    | CVC  | Banka                 | Kart Ailesi            |
|--------- |------------------ |------- |----- | ---------------       | ---------              |
| 1        | 4282209004348015  | 12/26  | 123  | Garanti Bankası       | BONUS                  |
| 2        | 5571135571135575  | 12/26  | 000  | Akbank                | AXESS                  |
| 3        | 4355084355084358  | 12/26  | 000  | Akbank                | AXESS                  |
| 4        | 4662803300111364  | 10/25  | 000  | Alternatif Bank       | BONUS                  |
| 5       | 4022774022774026  | 12/24  | 000  | Finansbank            | CARD FINANS            |
| 6        | 5456165456165454  | 12/24  | 000  | Finansbank            | CARD FINANS            |
| 7         | 9792023757123604  | 01/26     | 861   | Finansbank            | FINANSBANK DEBIT       |
| 8        | 4531444531442283  | 12/24  | 000  | Aktif Yatırım Bankası | AKTIF KREDI KARTI      |
| 9        | 5818775818772285  | 12/24  | 000  | Aktif Yatırım Bankası | AKTIF KREDI KARTI      |
| 10       | 4508034508034509  | 12/24  | 000  | İş bankası            | MAXIMUM                |
| 11       | 5406675406675403  | 12/24  | 000  | İş bankası            | MAXIMUM                |
| 12       | 4025903160410013  | 07/26  | 123  | Kuveyttürk            | KUVEYTTURK KREDI KARTI |
| 13       | 5345632006230604  | 12/24  | 310  | Aktif Yatırım Bankası | AKTIF KREDI KARTI      |
| 14       | 4282209027132016  | 12/24  | 358  | Garanti Bankası       | BONUS                  |
| 15       | 4029400154245816  | 03/24  | 373  | Vakıf Bank            | WORLD                  |
| 16       | 4029400184884303  | 01/26  | 378  | Vakıf Bank            | WORLD                  |
| 17       | 9792350046201275  | 07/27   | 993  | TÜRK ELEKTRONIK PARA  | PARAM KART             |
| 18       | 6501700194147183 | 03/27   | 136  | Vakıf Bank            | WORLD                  |
| 19      | 6500528865390837 | 01/26   | 686  | Vakıf Bank            | VAKIFBANK DEBIT        |

Test kartlarımızda alınan hata kodları ve çözümleriyle ilgili detaylı bilgiye ulaşabilmek için [PosFix Hata Kodları](https://developer.posfix.com.tr/home/ErrorCode) inceleyebilirsiniz.

## Örnek Kullanım Yöntemi

```rb
    def nonThreeDPayment
        if request.post?
            req = Nonthreedpaymentrequest.new

            req.OrderId = SecureRandom.uuid
            req.Echo = 'Echo'
            req.Mode = @@settings.Mode
            req.Amount = '10000'
            req.CardOwnerName = 'Ahmet Veli'
            req.CardNumber = '5456165456165454'
            req.CardExpireMonth = '12'
            req.CardExpireYear = '24'
            req.Installment = '1'
            req.Cvc = '000'
            req.ThreeD = 'false'
            req.UserId = ''
            req.CardId = ''

            #region Sipariş veren bilgileri
            req.Purchaser = Purchaser.new
            req.Purchaser.Name = 'Ahmet'
            req.Purchaser.SurName = 'Veli'
            req.Purchaser.BirthDate = '1986-07-11'
            req.Purchaser.Email = 'ahmet@veli.com'
            req.Purchaser.GsmPhone = '5881231212'
            req.Purchaser.IdentityNumber = '1234567890'
            req.Purchaser.ClientIp = '127.0.0.1'

            #endregion

            #region Fatura bilgileri
            req.Purchaser.Invoiceaddress = Purchaseraddress.new
            req.Purchaser.Invoiceaddress.Name = 'Ahmet'
            req.Purchaser.Invoiceaddress.SurName = 'Veli'
            req.Purchaser.Invoiceaddress.Address =
                'Mevlüt Pehlivan Mah. PosFix Plaza Şişli'
            req.Purchaser.Invoiceaddress.ZipCode = '34782'
            req.Purchaser.Invoiceaddress.CityCode = '34'
            req.Purchaser.Invoiceaddress.IdentityNumber = '1234567890'
            req.Purchaser.Invoiceaddress.CountryCode = 'TR'
            req.Purchaser.Invoiceaddress.TaxNumber = '123456'
            req.Purchaser.Invoiceaddress.TaxOffice = 'Kozyatağı'
            req.Purchaser.Invoiceaddress.CompanyName = 'PosFix'
            req.Purchaser.Invoiceaddress.PhoneNumber = '2122222222'

            #endregion

            #region Kargo Adresi bilgileri
            req.Purchaser.Shippingaddress = Purchaseraddress.new
            req.Purchaser.Shippingaddress.Name = 'Ahmet'
            req.Purchaser.Shippingaddress.SurName = 'Veli'
            req.Purchaser.Shippingaddress.Address =
                'Mevlüt Pehlivan Mah. PosFix Plaza Şişli'
            req.Purchaser.Shippingaddress.ZipCode = '34782'
            req.Purchaser.Shippingaddress.CityCode = '34'
            req.Purchaser.Shippingaddress.IdentityNumber = '1234567890'
            req.Purchaser.Shippingaddress.CountryCode = 'TR'
            req.Purchaser.Shippingaddress.PhoneNumber = '2122222222'

            #endregion

            #region Ürün bilgileri
            req.Products = Array.new
            p = Product.new
            p.Title = 'Telefon'
            p.Code = 'TLF0001'
            p.Price = '5000'
            p.Quantity = 1
            req.Products << p

            p = Product.new
            p.Title = 'Bilgisayar'
            p.Code = 'BLG0001'
            p.Price = '5000'
            p.Quantity = 1
            req.Products << p

            #endregion

            @returnData = req.execute(req, @@settings) #3D secure olmadan ödeme servisinin başladığı kısımdır.
        else

        end
    end

```

## Hash Hesaplama

PosFix servislerine entegre olurken alınan hataların en sık karşılaşılanı hash değerinin doğru hesaplanmasıdır. Hash değeri her servise göre değişen verilerin yanyana eklenmesi ile oluşan değerin bir dizi işleme tabi tutulması ile oluşur.

Aşağıdaki adreste hash hesaplama ile ilgili detaylar yer almaktadır. Yine burada yer alan interaktif fonksiyon ile hesapladığınız hash fonksiyonlarını test edebilirsiniz.

[PosFix Hash Hesaplama](https://developer.posfix.com.tr/#hashCalculate)

Her örnek projenin Helper sınıfı içinde hash hesaplama ile alakalı bir fonksiyon bulunmaktadır. Entegrasyon sırasıdna bu hazır fonksiyonları da kullanabilirsiniz.

## Canlı Ortama Geçiş

* Test ortamında kullandığınız statik verilerin canlı ortamda gerçek müşteri datasıyla değiştirildiğinden emin olun.
* Canlı ortamda yanlış, sabit data gönderilmediğinden emin olun. Gönderdiğiniz işlemlere ait verileri mutlaka size özel panelden görüntüleyin.
* Geliştirmeler tamamlandıktan sonra ödeme adımlarını, PosFix test kartları ile tüm olası durumlar için test edin ve sonuçlarını görüntüleyin.
* PosFix servislerinden dönen ve olabilecek tüm hataları karşılayacak ve müşteriye uygun cevabı gösterecek şekilde kodunuzu düzenleyin ve test edin.
* PosFix hata kodları kullanıcı dostu mesajlar olup müşterinize gösterebilirsiniz.
* Hassas olmayan verileri ve servis yanıtlarını, hata çözümü ve olası sorunların çözümünde yardımcı olması açısından loglamaya dikkat edin.
* Canlı ortama geçiş sonrası ilk işlemleri kendi kredi kartlarınız ile deneyerek sonuçlarını size özel Kurum ekranlarından görüntüleyin. Sonuçların ve işlemlerin doğru tamamlandığından emin olun.

Sorularınız olması durumunda bize [Destek](http://developer.posfix.com.tr/Home/Support) üzerinden yazabilirsiniz.

## Versiyon Yenilikleri

| Versiyon | Versiyon Yenilikleri                                                                             |
|--------- |-------------------------------------------------------------------------------------------   |
| 1.0.1     | -İki adımlı ThreeD ödemesi kaldırılıp **Tek adımlı ThreeD** ödemesi eklendi.<br />-Ödeme sorgulama servisinde ek olarak **tarih filtresi** eklendi.<br />-**Link ile ödeme, ödeme linki sorgulama,ödeme linki silme** servisleri eklendi.<br />-**Ürün iade bilgisi sorgulama,ürün iade talebi** oluşturma servisleri eklendi. <br />-**Bin sorgulama servisine tutar bilgisi** eklenerek komisyon bilgisi kullanıcıya sunuldu. |
