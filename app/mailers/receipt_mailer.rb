class ReceiptMailer < ApplicationMailer

  def receipt_email(order)
    @order = order
    @url  = '/orders/:order_id'
    mail(to: @order.email, subject: "Order Number #{@order.id}")
  end

end
