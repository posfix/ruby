class PostAuthRequest
  attr_accessor :OrderId
  attr_accessor :Amount
  attr_accessor :ClientIp
  attr_accessor :Mode
  attr_accessor :Echo
  attr_accessor :Token

  def execute(req, settings)
    settings.transactionDate = Core::Helper.GetTransactionDateString
    settings.HashString =
      settings.PrivateKey + req.OrderId + req.Amount + settings.Mode +
        req.ClientIp + settings.transactionDate
    req.Token = Core::Helper.CreateToken(settings.PublicKey, settings.HashString)

    return(
      JSON.parse(Core::HttpClient.post(
        settings.BaseUrl + 'rest/payment/postauth',
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
        'orderId': req.OrderId,
        'amount': req.Amount,
        'clientIp': req.ClientIp,
        'echo': '',
        'mode': settings.Mode,
      }
    ))
  end
end
