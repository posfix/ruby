class HomeController < ApplicationController
    require_dependency 'app/helpers/PreAuthRequest.rb'
    def index
        if request.post?
            req = Threedpaymentrequest.new
            req.OrderId = SecureRandom.uuid
            req.Amount = params[:amount]
            req.CardOwnerName = params[:nameSurname]
            req.CardNumber = params[:cardNumber]
            req.CardExpireMonth = params[:month]
            req.CardExpireYear = params[:year]
            req.Installment = params[:installment]
            req.Cvc = params[:cvc]
            req.UserId = ''
            req.CardId = ''

            req.Purchaser = Purchaser.new
            req.Purchaser.Name = 'Ahmet'
            req.Purchaser.SurName = 'Veli'
            req.Purchaser.BirthDate = '1986-07-11'
            req.Purchaser.Email = 'ahmet@veli.com'
            req.Purchaser.GsmPhone = '5881231212'
            req.Purchaser.IdentityNumber = '12345678901'
            req.Purchaser.ClientIp = '127.0.0.1'

            @returnData = req.execute(req, @@settings) #3D secure ödeme servisinin başladığı kısımdır.
            render inline: @returnData
        end
    end

    def preAuth
        if request.post?
            req = PreAuthRequest.new

            req.OrderId = SecureRandom.uuid
            req.Echo = 'Echo'
            req.Mode = @@settings.Mode
            req.Amount = params[:amount]
            req.CardOwnerName = params[:nameSurname]
            req.CardNumber = params[:cardNumber]
            req.CardExpireMonth = params[:month]
            req.CardExpireYear = params[:year]
            req.Installment = params[:installment]
            req.Cvc = params[:cvc]
            req.ThreeD = 'false'
            req.UserId = ''
            req.CardId = ''

            #region Sipariş veren bilgileri
            req.Purchaser = Purchaser.new
            req.Purchaser.Name = 'Ahmet'
            req.Purchaser.SurName = 'Veli'
            req.Purchaser.BirthDate = '1986-07-11'
            req.Purchaser.Email = 'ahmet@veli.com'
            req.Purchaser.GsmPhone = '5881231212'
            req.Purchaser.IdentityNumber = '1234567890'
            req.Purchaser.ClientIp = '127.0.0.1'

            #endregion

            #region Fatura bilgileri
            req.Purchaser.Invoiceaddress = Purchaseraddress.new
            req.Purchaser.Invoiceaddress.Name = 'Ahmet'
            req.Purchaser.Invoiceaddress.SurName = 'Veli'
            req.Purchaser.Invoiceaddress.Address =
              'Mevlüt Pehlivan Mah. PosFix Plaza Şişli'
            req.Purchaser.Invoiceaddress.ZipCode = '34782'
            req.Purchaser.Invoiceaddress.CityCode = '34'
            req.Purchaser.Invoiceaddress.IdentityNumber = '1234567890'
            req.Purchaser.Invoiceaddress.CountryCode = 'TR'
            req.Purchaser.Invoiceaddress.TaxNumber = '123456'
            req.Purchaser.Invoiceaddress.TaxOffice = 'Kozyatağı'
            req.Purchaser.Invoiceaddress.CompanyName = 'PosFix'
            req.Purchaser.Invoiceaddress.PhoneNumber = '2122222222'

            #endregion

            #region Kargo Adresi bilgileri
            req.Purchaser.Shippingaddress = Purchaseraddress.new
            req.Purchaser.Shippingaddress.Name = 'Ahmet'
            req.Purchaser.Shippingaddress.SurName = 'Veli'
            req.Purchaser.Shippingaddress.Address =
              'Mevlüt Pehlivan Mah. PosFix Plaza Şişli'
            req.Purchaser.Shippingaddress.ZipCode = '34782'
            req.Purchaser.Shippingaddress.CityCode = '34'
            req.Purchaser.Shippingaddress.IdentityNumber = '1234567890'
            req.Purchaser.Shippingaddress.CountryCode = 'TR'
            req.Purchaser.Shippingaddress.PhoneNumber = '2122222222'

            #endregion

            #region Ürün bilgileri
            req.Products = Array.new
            p = Product.new
            p.Title = 'Telefon'
            p.Code = 'TLF0001'
            p.Price = '5000'
            p.Quantity = 1
            req.Products << p

            p = Product.new
            p.Title = 'Bilgisayar'
            p.Code = 'BLG0001'
            p.Price = '5000'
            p.Quantity = 1
            req.Products << p

            #endregion

            @returnData = req.execute(req, @@settings) #3D secure olmadan ödeme servisinin başladığı kısımdır.
        else

        end
    end

    def nonThreeDPayment
        if request.post?
            req = Nonthreedpaymentrequest.new

            req.OrderId = SecureRandom.uuid
            req.Echo = 'Echo'
            req.Mode = @@settings.Mode
            req.Amount = params[:amount]
            req.CardOwnerName = params[:nameSurname]
            req.CardNumber = params[:cardNumber]
            req.CardExpireMonth = params[:month]
            req.CardExpireYear = params[:year]
            req.Installment = params[:installment]
            req.Cvc = params[:cvc]
            req.ThreeD = 'false'
            req.UserId = ''
            req.CardId = ''

            #region Sipariş veren bilgileri
            req.Purchaser = Purchaser.new
            req.Purchaser.Name = 'Ahmet'
            req.Purchaser.SurName = 'Veli'
            req.Purchaser.BirthDate = '1986-07-11'
            req.Purchaser.Email = 'ahmet@veli.com'
            req.Purchaser.GsmPhone = '5881231212'
            req.Purchaser.IdentityNumber = '1234567890'
            req.Purchaser.ClientIp = '127.0.0.1'

            #endregion

            #region Fatura bilgileri
            req.Purchaser.Invoiceaddress = Purchaseraddress.new
            req.Purchaser.Invoiceaddress.Name = 'Ahmet'
            req.Purchaser.Invoiceaddress.SurName = 'Veli'
            req.Purchaser.Invoiceaddress.Address =
                'Mevlüt Pehlivan Mah. PosFix Plaza Şişli'
            req.Purchaser.Invoiceaddress.ZipCode = '34782'
            req.Purchaser.Invoiceaddress.CityCode = '34'
            req.Purchaser.Invoiceaddress.IdentityNumber = '1234567890'
            req.Purchaser.Invoiceaddress.CountryCode = 'TR'
            req.Purchaser.Invoiceaddress.TaxNumber = '123456'
            req.Purchaser.Invoiceaddress.TaxOffice = 'Kozyatağı'
            req.Purchaser.Invoiceaddress.CompanyName = 'PosFix'
            req.Purchaser.Invoiceaddress.PhoneNumber = '2122222222'

            #endregion

            #region Kargo Adresi bilgileri
            req.Purchaser.Shippingaddress = Purchaseraddress.new
            req.Purchaser.Shippingaddress.Name = 'Ahmet'
            req.Purchaser.Shippingaddress.SurName = 'Veli'
            req.Purchaser.Shippingaddress.Address =
                'Mevlüt Pehlivan Mah. PosFix Plaza Şişli'
            req.Purchaser.Shippingaddress.ZipCode = '34782'
            req.Purchaser.Shippingaddress.CityCode = '34'
            req.Purchaser.Shippingaddress.IdentityNumber = '1234567890'
            req.Purchaser.Shippingaddress.CountryCode = 'TR'
            req.Purchaser.Shippingaddress.PhoneNumber = '2122222222'

            #endregion

            #region Ürün bilgileri
            req.Products = Array.new
            p = Product.new
            p.Title = 'Telefon'
            p.Code = 'TLF0001'
            p.Price = '5000'
            p.Quantity = 1
            req.Products << p

            p = Product.new
            p.Title = 'Bilgisayar'
            p.Code = 'BLG0001'
            p.Price = '5000'
            p.Quantity = 1
            req.Products << p

            #endregion

            @returnData = req.execute(req, @@settings) #3D secure olmadan ödeme servisinin başladığı kısımdır.
        else

        end
    end

    def paymentLinkCreate
        if request.post?
            req = Paymentlinkcreaterequest.new
            req.clientIp = '127.0.0.1'
            req.name = params[:name]
            req.surname = params[:surname]
            req.tcCertificate = params[:tcCertificate]
            req.taxNumber = params[:taxNumber]
            req.email = params[:email]
            req.gsm = params[:gsm]
            req.amount = params[:amount]
            req.threeD = params[:threeD]
            req.expireDate =
                params[:expireDateYear] + '-' + params[:expireDateMonth] + '-' +
                    params[:expireDateDay] + ' 00:00:00'
            req.sendEmail = params[:sendEmail]
            req.mode = @@settings.Mode
            req.commissionType = params[:commissionType]

            @returnData = req.execute(req, @@settings) #Ödeme linki oluşturma api çağırısının yapıldığı kısımdır.
        else

        end
    end

    def paymentLinkDelete
        if request.post?
            req = Paymentlinkdeleterequest.new
            req.clientIp = '127.0.0.1'
            req.linkId = params[:linkId]

            @returnData = req.execute(req, @@settings) #Ödeme linki silme api çağırısının yapıldığı kısımdır.
        else

        end
    end

    def paymentLinkInquiry
        if request.post?
            req = Paymentlinkinquiryrequest.new
            req.clientIp = '127.0.0.1'
            req.email = params[:email]
            req.gsm = params[:gsm]
            if !params[:linkId].blank?
                req.linkId = params[:linkId]
            end
            req.linkState = params[:linkState]
            req.startDate = nil
            req.endDate = nil
            if !params[:startYear].blank? && !params[:startMonth].blank? && !params[:startDay].blank? && !params[:endYear].blank? && !params[:endMonth].blank? && !params[:endDay].blank?
                req.startDate =
                    params[:startYear] + '-' + params[:startMonth] + '-' +
                        params[:startDay] + ' 00:00:00'
                req.endDate =
                    params[:endYear] + '-' + params[:endMonth] + '-' +
                        params[:endDay] + ' 00:00:00'
            end
            req.pageSize = params[:pageSize]
            req.pageIndex = params[:pageIndex]

            @returnData = req.execute(req, @@settings) #Ödeme linki sorgulama api çağırısının yapıldığı kısımdır.
        else

        end
    end

    def paymentRefundInquiry
        if request.post?
            req = Paymentrefundinquiryrequest.new
            req.clientIp = '127.0.0.1'
            req.orderId = params[:orderId]
            req.amount = params[:amount]

            @returnData = req.execute(req, @@settings) #İade sorgulama api çağırısının yapıldığı kısımdır.
        else

        end
    end

    def paymentRefund
        if request.post?
            req = Paymentrefundrequest.new
            req.clientIp = '127.0.0.1'
            req.orderId = params[:orderId]
            req.refundHash = params[:refundHash]
            req.amount = params[:amount]

            @returnData = req.execute(req, @@settings) #İade sorgulama api çağırısının yapıldığı kısımdır.
        else

        end
    end

    def paymentInquiryWithTime
        if request.post?
            req = Paymentinquirywithtimerequest.new
            req.startDate =
                params[:startYear] + '-' + params[:startMonth] + '-' +
                    params[:startDay] + ' 00:00:00'
            req.endDate =
                params[:endYear] + '-' + params[:endMonth] + '-' +
                    params[:endDay] + ' 00:00:00'
            req.mode = @@settings.Mode
            req.echo = ''

            @returnData = req.execute(req, @@settings) #Ödeme sorgulama api çağırısının yapıldığı kısımdır.
        else

        end
    end

    def bininqury
        if request.post?
            req = Binnumberrequest.new
            req.binNumber = params[:binNumber]
            req.amount = params[:amount]
            req.threeD = params[:threeD]
            @returnData = req.execute(req, @@settings) #Bin sorgulama api çağırısının yapıldığı kısımdır.
        else

        end
    end

    def bininquryv4
        if request.post?
            req = Binnumberv4request.new
            req.binNumber = params[:binNumber]
            req.amount = params[:amount]
            req.threeD = params[:threeD]
            @returnData = req.execute(req, @@settings) #Bin sorgulama api çağırısının yapıldığı kısımdır.
        else

        end
    end

    def addCardToWallet
        if request.post?
            req = Bankcardcreaterequest.new
            req.userId = params[:userId]
            req.cardOwnerName = params[:nameSurname]
            req.cardNumber = params[:cardNumber]
            req.cardAlias = params[:cardAlias]
            req.cardExpireMonth = params[:month]
            req.cardExpireYear = params[:year]
            req.clientIp = '127.0.0.1'
            @returnData = req.execute(req, @@settings) #Cüzdana kart ekleme api çağırısının yapıldığı kısımdır.
        else

        end
    end

    def getCardFromWallet
        if request.post?
            req = Bankcardinquiryrequest.new
            req.userId = params[:userId]
            req.cardId = params[:cardId]
            req.clientIp = '127.0.0.1'
            @returnData = req.execute(req, @@settings) #Cüzdanda bulunan kartları getirmek için yapılan api çağırısını temsil etmektedir.
        else

        end
    end

    def deleteCardFromWallet
        if request.post?
            req = Bankcarddeleterequest.new
            req.userId = params[:userId]
            req.cardId = params[:cardId]
            req.clientIp = '127.0.0.1'
            @returnData = req.execute(req, @@settings) #Cüzdanda bulunan kartı silmek için yapılan api çağırısını temsil etmektedir.
        else

        end
    end

    def paymentInquiry
        if request.post?
            req = Paymentinquiryrequest.new
            req.orderId = params[:orderId]
            @returnData = req.execute(req, @@settings) #Ödeme sorgulama servisi api çağrısının yapıldığı kısımdır.
        else

        end
    end

    def nonThreeDPaymentWithWallet
        if request.post?
            req = Nonthreedpaymentrequest.new

            req.OrderId = SecureRandom.uuid
            req.Echo = 'Echo'
            req.Mode = @@settings.Mode
            req.Amount = '10000' # 100 tL
            req.CardOwnerName = ''
            req.CardNumber = ''
            req.CardExpireMonth = ''
            req.CardExpireYear = ''
            req.Installment = ''
            req.Cvc = ''
            req.ThreeD = 'false'
            req.UserId = params[:userId]
            req.CardId = params[:cardId]

            #region Sipariş veren bilgileri
            req.Purchaser = Purchaser.new
            req.Purchaser.Name = 'Ahmet'
            req.Purchaser.SurName = 'Veli'
            req.Purchaser.BirthDate = '1986-07-11'
            req.Purchaser.Email = 'ahmet@veli.com'
            req.Purchaser.GsmPhone = '5881231212'
            req.Purchaser.IdentityNumber = '1234567890'
            req.Purchaser.ClientIp = '127.0.0.1'

            #endregion

            #region Fatura bilgileri

            req.Purchaser.Invoiceaddress = Purchaseraddress.new
            req.Purchaser.Invoiceaddress.Name = 'Ahmet'
            req.Purchaser.Invoiceaddress.SurName = 'Veli'
            req.Purchaser.Invoiceaddress.Address =
                'Mevlüt Pehlivan Mah. PosFix Plaza Şişli'
            req.Purchaser.Invoiceaddress.ZipCode = '34782'
            req.Purchaser.Invoiceaddress.CityCode = '34'
            req.Purchaser.Invoiceaddress.IdentityNumber = '1234567890'
            req.Purchaser.Invoiceaddress.CountryCode = 'TR'
            req.Purchaser.Invoiceaddress.TaxNumber = '123456'
            req.Purchaser.Invoiceaddress.TaxOffice = 'Kozyatağı'
            req.Purchaser.Invoiceaddress.CompanyName = 'PosFix'
            req.Purchaser.Invoiceaddress.PhoneNumber = '2122222222'

            #endregion

            #region Kargo Adresi bilgileri
            req.Purchaser.Shippingaddress = Purchaseraddress.new
            req.Purchaser.Shippingaddress.Name = 'Ahmet'
            req.Purchaser.Shippingaddress.SurName = 'Veli'
            req.Purchaser.Shippingaddress.Address =
                'Mevlüt Pehlivan Mah. PosFix Plaza Şişli'
            req.Purchaser.Shippingaddress.ZipCode = '34782'
            req.Purchaser.Shippingaddress.CityCode = '34'
            req.Purchaser.Shippingaddress.IdentityNumber = '1234567890'
            req.Purchaser.Shippingaddress.CountryCode = 'TR'
            req.Purchaser.Shippingaddress.PhoneNumber = '2122222222'

            #endregion

            #region Ürün bilgileri
            req.Products = Array.new
            p = Product.new
            p.Title = 'Telefon'
            p.Code = 'TLF0001'
            p.Price = '5000'
            p.Quantity = 1
            req.Products << p

            p = Product.new
            p.Title = 'Bilgisayar'
            p.Code = 'BLG0001'
            p.Price = '5000'
            p.Quantity = 1
            req.Products << p

            #endregion

            @returnData = req.execute(req, @@settings) #Cüzdandaki kart ile ödeme yapma api çağrısının yapıldığı kısımdır.
        else

        end
    end
end
