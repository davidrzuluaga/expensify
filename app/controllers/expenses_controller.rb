class ExpensesController < ApplicationController
  def index
    @tab = :expenses
    @type = Type.all
    @category = Category.all
    @dates = []
    @currentmonth = ""

    Expense.all.each {|exp| @dates << Date.new(exp.date.year, exp.date.month, 1)}
    @months = @dates.uniq.sort.reverse
    
    if params[:month] == ""
      month = @months.last
    elsif !params[:month].present?
      month = Date.today
      @currentmonth = month
    elsif params[:month].present? && params[:month] != ""
      dateparams = params[:month].split("-")
      month = Date.new(dateparams[0].to_i, dateparams[1].to_i, 1)
      @currentmonth = month
    end
    
    @expenses = Expense.where("category_id LIKE ? AND type_id LIKE ? AND date >= ? AND date <= ?", "%#{params[:category]}%", "%#{params[:type]}%", "#{month.at_beginning_of_month}", "#{params[:month] == "" ? Date.today.at_end_of_month : month.at_end_of_month}").order("date DESC")
    @total = @expenses.sum(:amount)
  end
end
