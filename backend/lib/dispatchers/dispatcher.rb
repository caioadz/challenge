# A dispatcher represents some processing that must be performed after the payment is complete.
# This could be sending an email, activating a membership or shipping off some products.
#
# Dispatchers are self-contained and must implement the whole business logic related to it.
#
# They can also overlap... we could have one dispatcher to trigger an email that sends a list with every product
# that was bought and another to send additional information for a specific type of product.
#
# Dispatchers must implement the method 'dispatch' that receives an Invoice.
#
# As a plus, this class could potentially summarise the result of all dispatchers fired so we can do something with it.

class Dispatcher
  attr_reader :dispatchers

  def initialize(payment)
    @dispatchers = []
    payment.add_observer(self, :dispatch_all)
  end

  def dispatch_all(payment)
    # Since the dispatchers are independent, we could fire this calls in paralel
    dispatchers.each { |dispatcher| 
      p "Calling: #{dispatcher.class}"
      dispatcher.dispatch(payment.invoice) 
    }
  end

  def add_dispatcher(dispatcher)
    @dispatchers << dispatcher
  end
end