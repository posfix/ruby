class Paymentlinkinquiryrequest
    # Ödeme linki sorgulama için gerekli olan servis girdi parametrelerini temsil eder.
    attr_accessor :clientIp
    attr_accessor :email
    attr_accessor :gsm
    attr_accessor :linkId
    attr_accessor :linkState
    attr_accessor :startDate
    attr_accessor :endDate
    attr_accessor :pageSize
    attr_accessor :pageIndex

    def execute(req, settings)
        settings.transactionDate = Core::Helper.GetTransactionDateString
        settings.HashString =
            settings.PrivateKey + req.clientIp + settings.transactionDate
        return(
            JSON.parse(
                Core::HttpClient.post(
                    settings.BaseUrl + '/corporate/merchant/linkpayment/list',
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
