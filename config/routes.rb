Rails.application.routes.draw do
    get 'home/index'
    get 'home/threeDPayment'
    get 'home/preAuth'
    get 'home/nonThreeDPayment'
    get 'home/postAuth'
    get 'home/threeDResultSuccess'
    get 'home/threeDResultFail'
    get 'home/bininqury'
    get 'home/bininquryv4'
    get 'home/addCardToWallet'
    get 'home/getCardFromWallet'
    get 'home/deleteCardFromWallet'
    get 'home/paymentInquiry'
    get 'home/nonThreeDPaymentWithWallet'
    get 'home/paymentLinkCreate'
    get 'home/paymentLinkDelete'
    get 'home/paymentLinkInquiry'
    get 'home/paymentInquiryWithTime'
    get 'home/paymentRefundInquiry'
    get 'home/paymentRefund'
    get 'home/checkoutFormCreate'

    post 'home/index'
    post 'home/preAuth'
    post 'home/threeDPayment'
    post 'home/postAuth'
    post 'home/nonThreeDPayment'
    post 'home/bininqury'
    post 'home/bininquryv4'
    post 'home/addCardToWallet'
    post 'home/getCardFromWallet'
    post 'home/deleteCardFromWallet'
    post 'home/paymentInquiry'
    post 'home/nonThreeDPaymentWithWallet'
    post 'home/threeDResultSuccess'
    post 'home/threeDResultFail'
    post 'home/paymentLinkCreate'
    post 'home/paymentLinkDelete'
    post 'home/paymentLinkInquiry'
    post 'home/paymentInquiryWithTime'
    post 'home/paymentRefundInquiry'
    post 'home/paymentRefund'
    post 'home/checkoutFormCreate'

    root 'home#index'
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
