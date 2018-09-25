class ExpensesController < ApplicationController
  def index
    @tab = :expenses
    @type = Type.all
    @category = Category.all
    @expense = Expense.all
  end
end
