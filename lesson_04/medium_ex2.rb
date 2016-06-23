# 2. Alyssa created the following code to keep track of items 
# for a shopping cart application she's writing:

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    @quantity = updated_count if updated_count >= 0 # use @quantity instead of quamtity
  end
end

invoice1 = InvoiceEntry.new("mittens", 3)
p invoice1.quantity # => 3
invoice1.update_quantity(1)
p invoice1.quantity # => 1

# Alan looked at the code and spotted a mistake. 
# "This will fail when update_quantity is called", he says.
# Can you spot the mistake and how to address it?

# A: There is only a attr_reader for quantity. 
# You need to either set a attr_accessor or use @quantity.