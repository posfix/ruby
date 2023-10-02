class Paymentlinkcreaterequest
    # Ödeme linki oluşturma için gerekli olan servis girdi parametrelerini temsil eder.
    attr_accessor :clientIp
    attr_accessor :name
    attr_accessor :surname
    attr_accessor :tcCertificate
    attr_accessor :taxNumber
    attr_accessor :email
    attr_accessor :gsm
    attr_accessor :amount
    attr_accessor :threeD
    attr_accessor :expireDate
    attr_accessor :sendEmail
    attr_accessor :mode
    attr_accessor :commissionType

    def execute(req, settings)
        settings.transactionDate = Core::Helper.GetTransactionDateString
        settings.HashString =
            settings.PrivateKey + req.name + req.surname + req.email +
                req.amount + req.clientIp + settings.transactionDate
        return(
            JSON.parse(
                Core::HttpClient.post(
                    settings.BaseUrl + '/corporate/merchant/linkpayment/create',
                    Core::Helper.GetHttpHeaders(
                        settings,
                        Core::Helper::Application_json,
                    ),
                    req.to_json,
                ),
            )
        )
    end
end
