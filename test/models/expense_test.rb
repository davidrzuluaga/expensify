require 'test_helper'

class ExpenseTest < ActiveSupport::TestCase
  
  def setup
  end
  
  test "Expense shouldn't be created empty" do
    @expense = Expense.new
    assert_not @expense.save    
  end

  test "Expense amount should be a number" do
    @expense = Expense.new(date: "2018-01-01", concept: "Example", amount: "not-number", category: Category.all.sample, type: Type.all.sample)
    assert_not @expense.save    
  end

end

