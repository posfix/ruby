=begin
		Bu fonksiyon diğer fonksiyonların aksine 3D sınıfı bir formun post edilmesi ile başlar.
		Bundan dolayı bu fonksiyon toHtmlString metodunda ilgili HTML formu oluşturur ve geri döndürür.
=end
class Threedpaymentrequest
    #3D secure ödeme formu başlatmak için gerekli olan servis girdi parametrelerini temsil eder.
    attr_accessor :Echo
    attr_accessor :Mode
    attr_accessor :OrderId
    attr_accessor :Amount
    attr_accessor :CardOwnerName
    attr_accessor :CardNumber
    attr_accessor :CardExpireMonth
    attr_accessor :CardExpireYear
    attr_accessor :Installment
    attr_accessor :Cvc
    attr_accessor :SuccessUrl
    attr_accessor :FailUrl
    attr_accessor :Version
    attr_accessor :TransactionDate
    attr_accessor :Token
    attr_accessor :VendorId
    attr_accessor :UserId
    attr_accessor :CardId
    attr_accessor :Purchaser

    def execute(req, settings)
        settings.transactionDate = Core::Helper.GetTransactionDateString
        settings.HashString =
            settings.PrivateKey + req.OrderId + req.Amount + settings.Mode +
                req.CardOwnerName + req.CardNumber + req.CardExpireMonth +
                req.CardExpireYear + req.Cvc + req.UserId + req.CardId +
                req.Purchaser.Name + req.Purchaser.SurName +
                req.Purchaser.Email + settings.transactionDate
        req.Token =
            Core::Helper.CreateToken(settings.PublicKey, settings.HashString)

        formInputs =
            JSON.generate(
                {
                    'orderId': req.OrderId,
                    'cardOwnerName': req.CardOwnerName,
                    'cardNumber': req.CardNumber,
                    'cardExpireMonth': req.CardExpireMonth,
                    'cardExpireYear': req.CardExpireYear,
                    'cardCvc': req.Cvc,
                    'userId': req.UserId,
                    'cardId': req.CardId,
                    'installment': req.Installment,
                    'amount': req.Amount,
                    'echo': '',
                    'language': 'tr-TR',
                    'purchaser': {
                        'name': req.Purchaser.Name,
                        'surname': req.Purchaser.SurName,
                        'email': req.Purchaser.Email,
                        'clientIp': req.Purchaser.ClientIp,
                        'birthDate': req.Purchaser.BirthDate,
                    },
                    'products': [
                        {
                            'productCode': 'TLF0001',
                            'productName': 'Telefon',
                            'quantity': '1',
                            'price': '5000',
                        },
                        {
                            'productCode': 'BLG0001',
                            'productName': 'Bilgisayar',
                            'quantity': '1',
                            'price': '50000',
                        },
                    ],
                    'successUrl':
                        'https://api.posfix.com.tr/rest/payment/threed/test/result',
                    'failureUrl':
                        'https://api.posfix.com.tr/rest/payment/threed/test/result',
                    'mode': settings.Mode,
                    'version': settings.Version,
                    'transactionDate': settings.transactionDate,
                    'token': req.Token,
                },
            )
        return self.toHtmlString(formInputs, settings).force_encoding('UTF-8')
    end

    def toHtmlString(formInputs, settings)
        return(
            '<!DOCTYPE html>' + "<html lang='en'>" + '<head>' +
                "<meta charset='UTF-8' />" +
                "<meta name='viewport' content='width=device-width, initial-scale=1.0' />" +
                '</head>' + '<body>' +
                "<form action='https://api.posfix.com.tr/rest/payment/threed' method='POST' id='PosFixMerchantRequestForm'>" +
                "<input id='token' type='hidden' name='parameters' value='" +
                formInputs + "' />" + '</form>' + '<script>' +
                "document.getElementById('PosFixMerchantRequestForm').submit();" +
                '</script>' + '</body>' + '</html>'
        )
        p builder
    end
end

#Müşteri bilgisinin alanlarını temsil eder.
class Purchaser
    attr_accessor :Name
    attr_accessor :SurName
    attr_accessor :BirthDate
    attr_accessor :Email
    attr_accessor :GsmPhone
    attr_accessor :IdentityNumber
    attr_accessor :ClientIp
    attr_accessor :Invoiceaddress
    attr_accessor :Shippingaddress
end
