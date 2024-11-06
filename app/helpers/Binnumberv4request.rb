class Binnumberv4request
    #Bin Sorgulama servisleri içerisinde kullanılacak olan bin numarasını temsil eder.
    attr_accessor :binNumber
    attr_accessor :amount
    attr_accessor :threeD

    #Türkiye genelinde tanımlı olan tüm yerli kartlara ait BIN numaraları için sorgulama yapılmasına izin veren servisi temsil eder.
    def execute(req, settings)
        settings.transactionDate = Core::Helper.GetTransactionDateString
        settings.HashString =
            settings.PrivateKey + req.binNumber + settings.transactionDate
        return(
            JSON.parse(
                Core::HttpClient.post(
                    settings.BaseUrl + '/rest/payment/bin/lookup/v4',
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
