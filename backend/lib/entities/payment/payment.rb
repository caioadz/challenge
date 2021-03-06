require 'observer'

class Payment
  include Observable

  attr_reader :authorization_number, :amount, :invoice, :order, :payment_method, :paid_at, :status

  def initialize(attributes = {})
    @authorization_number, @amount = attributes.values_at(:authorization_number, :amount)
    @invoice, @order = attributes.values_at(:invoice, :order)
    @payment_method = attributes.values_at(:payment_method)
    @status = :pending
  end

  def pay(paid_at = Time.now)
    order.set_payment(self)

    @amount = order.total_amount
    @authorization_number = Time.now.to_i
    @invoice = Invoice.new(order, order.customer)
    @paid_at = paid_at

    set_status(:complete)

    notify
  end

  def paid?
    !paid_at.nil?
  end

private

  def notify()
    changed
    notify_observers(self)
  end

  def set_status(status)
    @status = status
  end
end