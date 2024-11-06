class PreAuthRequest
  attr_accessor :Echo
  attr_accessor :Mode
  attr_accessor :ThreeD
  attr_accessor :OrderId
  attr_accessor :Amount
  attr_accessor :CardOwnerName
  attr_accessor :CardNumber
  attr_accessor :CardExpireMonth
  attr_accessor :CardExpireYear
  attr_accessor :Installment
  attr_accessor :Cvc
  attr_accessor :VendorId
  attr_accessor :UserId
  attr_accessor :CardId
  attr_accessor :ThreeDSecureCode
  attr_accessor :Products
  attr_accessor :Purchaser
  attr_accessor :Token

  def execute(req, settings)
    settings.transactionDate = Core::Helper.GetTransactionDateString
    settings.HashString =
      settings.PrivateKey + req.OrderId + req.Amount + settings.Mode +
        req.CardOwnerName + req.CardNumber + req.CardExpireMonth +
        req.CardExpireYear + req.Cvc + req.UserId + req.CardId +
        req.Purchaser.Name + req.Purchaser.SurName +
        req.Purchaser.Email + settings.transactionDate
    req.Token = Core::Helper.CreateToken(settings.PublicKey, settings.HashString)

    return(
      JSON.parse(Core::HttpClient.post(
        settings.BaseUrl + 'rest/payment/preauth',
        Core::Helper.GetHttpHeaders(
          settings,
          Core::Helper::Application_json,
        ),
        self.to_json(req, settings))
      ))
  end

  def to_json(req, settings)
    return(JSON.generate(
      {
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
        'mode': settings.Mode,
        'version': settings.Version,
        'transactionDate': settings.transactionDate,
        'token': req.Token,
        'purchaser': {
          'name': req.Purchaser.Name,
          'surname': req.Purchaser.SurName,
          'email': req.Purchaser.Email,
          'clientIp': req.Purchaser.ClientIp,
          'birthDate': req.Purchaser.BirthDate,
          'gsmNumber': req.Purchaser.BirthDate,
          'tcCertificate': req.Purchaser.BirthDate,
          'invoiceAddress': {
            'name': req.Purchaser.Invoiceaddress.Name,
            'surname': req.Purchaser.Invoiceaddress.SurName,
            'address': req.Purchaser.Invoiceaddress.Address,
            'zipcode': req.Purchaser.Invoiceaddress.ZipCode,
            'city': req.Purchaser.Invoiceaddress.CityCode,
            'tcCertificate': req.Purchaser.Invoiceaddress.IdentityNumber,
            'country': req.Purchaser.Invoiceaddress.CountryCode,
            'taxNumber': req.Purchaser.Invoiceaddress.TaxNumber,
            'taxOffice': req.Purchaser.Invoiceaddress.TaxOffice,
            'companyName': req.Purchaser.Invoiceaddress.CompanyName,
            'phoneNumber': req.Purchaser.Invoiceaddress.PhoneNumber
          },
          'shippingAddress': {
            'name': req.Purchaser.Shippingaddress.Name,
            'surname': req.Purchaser.Shippingaddress.SurName,
            'address': req.Purchaser.Shippingaddress.Address,
            'zipcode': req.Purchaser.Shippingaddress.ZipCode,
            'city': req.Purchaser.Shippingaddress.CityCode,
            'country': req.Purchaser.Shippingaddress.CountryCode,
            'phoneNumber': req.Purchaser.Shippingaddress.PhoneNumber
          }
        },

      }
    ))
  end
end

# Bu sınıf 3D secure olmadan ödeme kısmında müşteri bilgisinin alanlarını temsil eder.
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

# Bu sınıf 3D secure olmadan ödeme kısmında müşteri adres bilgisinin alanlarını temsil eder.

class Purchaseraddress
  attr_accessor :Name
  attr_accessor :SurName
  attr_accessor :Address
  attr_accessor :ZipCode
  attr_accessor :CityCode
  attr_accessor :IdentityNumber
  attr_accessor :CountryCode
  attr_accessor :TaxNumber
  attr_accessor :TaxOffice
  attr_accessor :CompanyName
  attr_accessor :PhoneNumber
end

# Bu sınıf 3D secure olmadan ödeme kısmında ürün bilgisinin alanlarını temsil eder.

class Product
  attr_accessor :Code
  attr_accessor :Title
  attr_accessor :Quantity
  attr_accessor :Price
end
