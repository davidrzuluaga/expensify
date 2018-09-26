class ExpensesController < ApplicationController
  def index
    @tab = :expenses
    @type = Type.all
    @category = Category.all
    @dates = []
    @currentmonth = ""

    Expense.all.each {|exp| @dates << Date.new(exp.date.year, exp.date.month, 1)}
    @months = @dates.uniq.sort
    
    if params[:month].present?
      dateparams = params[:month].split(",")
      month = Date.new(dateparams[0].to_i, dateparams[1].to_i, dateparams[2].to_i)
      @currentmonth = month
    else
      month = @months.first
    end
    
    if params[:category].present? || params[:type].present? || params[:month].present?
      @expenses = Expense.where("category_id LIKE ? AND type_id LIKE ? AND date >= ? AND date <= ?", "%#{params[:category]}%", "%#{params[:type]}%", "#{month.at_beginning_of_month}", "#{params[:month].present? ? month.at_end_of_month : Date.today.at_end_of_month}").order("date DESC")
    else
      @expenses = Expense.where("date >= ? AND date <= ?", Date.today.at_beginning_of_month, Date.today.at_end_of_month).order("date DESC")
      @currentmonth = Date.today
    end 
    
    @total = @expenses.sum(:amount)
  end
end
