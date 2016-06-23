# 6. If we have these two methods:

class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

# and

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end

# What is the difference in the way the code works?
# A: self.template and @template are both instance variables in the 
# create_template methods, but the show_template method in the first 
# example is accessing the attr_accessor and the show_template method
# in the second example is directly accessing the instance variable.

# While both options are technically fine, the general rule from the 
# Ruby style guide is to "Avoid self where not required."