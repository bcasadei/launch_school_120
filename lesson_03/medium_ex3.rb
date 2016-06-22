# 3. In the last question Alyssa showed Alan this code which keeps track of items for a shopping cart application:

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end
# Alan noticed that this will fail when update_quantity is called. 
# Since quantity is an instance variable, it must be accessed with 
# the @quantity notation when setting it. 
# One way to fix this to change attr_reader to attr_accessor.
# Is there anything wrong with fixing it this way?
# A: It grants read and write access to methods outside of the object. 
# Using @quantity only gives write access to the update_quantity method.