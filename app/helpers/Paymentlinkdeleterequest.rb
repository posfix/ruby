class Paymentlinkdeleterequest
    # Ödeme linki silme için gerekli olan servis girdi parametrelerini temsil eder.
    attr_accessor :clientIp
    attr_accessor :linkId

    def execute(req, settings)
        settings.transactionDate = Core::Helper.GetTransactionDateString
        settings.HashString =
            settings.PrivateKey + req.clientIp + settings.transactionDate
        return(
            JSON.parse(
                Core::HttpClient.post(
                    settings.BaseUrl + '/corporate/merchant/linkpayment/delete',
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
