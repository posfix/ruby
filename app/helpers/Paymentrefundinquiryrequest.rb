class Paymentrefundinquiryrequest
    # İade sorgulama için gerekli olan servis girdi parametrelerini temsil eder.
    attr_accessor :clientIp
    attr_accessor :orderId
    attr_accessor :amount

    def execute(req, settings)
        settings.transactionDate = Core::Helper.GetTransactionDateString
        settings.HashString =
            settings.PrivateKey + req.orderId + req.clientIp +
                settings.transactionDate
        return(
            JSON.parse(
                Core::HttpClient.post(
                    settings.BaseUrl + '/corporate/payment/refund/inquiry',
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
