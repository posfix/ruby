class Paymentinquirywithtimerequest
    # Tarihe göre ödeme sorugulama servisi için gerekli olan servis girdi parametrelerini temsil eder.
    attr_accessor :mode
    attr_accessor :startDate
    attr_accessor :endDate
    attr_accessor :echo

    def execute(req, settings)
        settings.transactionDate = Core::Helper.GetTransactionDateString
        settings.HashString =
            settings.PrivateKey + settings.Mode + settings.transactionDate

        return(
            JSON.parse(
                Core::HttpClient.post(
                    settings.BaseUrl + '/rest/payment/search',
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
