class ExpensesController < ApplicationController
  def index
    @tab = :expenses
    @type = Type.all
    @category = Category.all
    @dates = []
    
    # if params[:question].present?
    #   @questions = Question.where("title LIKE ? OR body LIKE ?", "%#{params[:question]}%", "%#{params[:question]}%")
    # else
    @expenses = Expense.order("date DESC")
    # end
    
    @expenses.each {|exp| @dates << Date.new(exp.date.year, exp.date.month, 1)}
    @months = @dates.uniq.sort
  end
end
