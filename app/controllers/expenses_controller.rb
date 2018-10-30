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

  def new
    @expense = Expense.new
  end
  
  def create
    @expense = Expense.create(expense_params)
    respond_to do |format|
      format.html { redirect_to expenses_path }
    end
  end
  
  def destroy
    @expense = Expense.destroy(params[:id])
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def update
    @expense = Expense.update(params[:id], expense_params)
  end
  
private

  def expense_params
    params.require(:expense).permit(:date, :concept, :amount, :category_id, :type_id)
  end
end
