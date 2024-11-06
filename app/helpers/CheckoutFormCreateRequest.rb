class CheckoutFormCreateRequest
  # Checkout form oluşturma servis girdi parametrelerini temsil eder.
  attr_accessor :ThreeD
  attr_accessor :Amount
  attr_accessor :OrderId
  attr_accessor :VendorId
  attr_accessor :AllowedInstallments
  attr_accessor :CallbackUrl
  attr_accessor :Purchaser
  attr_accessor :Products
  attr_accessor :CustField1
  attr_accessor :Echo
  attr_accessor :Mode
  attr_accessor :Token

  #   *	Checkout form oluşturma için gerekli olan servis isteğini temsil eder.
  #   *	req Ödeme Onayı sağlamak için gerekli olan girdilerin olduğu sınıfı temsil eder.
  #   *	settings Kullanıcıya özel olarak belirlenen ayarları temsil eder.

  def execute(req, settings)
    settings.transactionDate = Core::Helper.GetTransactionDateString
    settings.HashString =
      settings.PrivateKey + settings.Mode +
        req.Purchaser.Name + req.Purchaser.SurName + req.Purchaser.Email +
        settings.transactionDate
    req.Token = Core::Helper.CreateToken(settings.PublicKey, settings.HashString)

    return(
      JSON.parse(Core::HttpClient.post(
        settings.BaseUrl + 'rest/checkoutForm/create',
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
        'threed': req.ThreeD,
        'amount': req.Amount,
        'orderId': req.OrderId,
        'vendorId': req.VendorId,
        'allowedInstallments': req.AllowedInstallments,
        'callbackUrl': req.CallbackUrl,
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
        'echo': '',
        'mode': settings.Mode,
      }
    ))
  end
end

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

class Product
  attr_accessor :Code
  attr_accessor :Title
  attr_accessor :Quantity
  attr_accessor :Price
end
