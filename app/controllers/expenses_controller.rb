class ExpensesController < ApplicationController
  def index
    @tab = :expenses
    @type = Type.all
    @category = Category.all
    @dates = []
    
    Expense.all.each {|exp| @dates << Date.new(exp.date.year, exp.date.month, 1)}
    @months = @dates.uniq.sort.reverse
    
    if params[:month] == ""
      firstmonth_range = @months.last
      lastmonth_range = @months.first
      @currentmonth = "All Months"
    elsif !params[:month].present?
      firstmonth_range = Date.today
      lastmonth_range = Date.today
      @currentmonth = Date.today.strftime("%B %Y")
    elsif params[:month].present? && params[:month] != ""
      dateparams = params[:month].split("-")
      month = Date.new(dateparams[0].to_i, dateparams[1].to_i, 1)
      firstmonth_range = month
      lastmonth_range = month
      @currentmonth = month.strftime("%B %Y")
    end
    
    @expenses = Expense.where("category_id LIKE ? AND type_id LIKE ? AND date >= ? AND date <= ?", "%#{params[:category]}%", "%#{params[:type]}%", "#{firstmonth_range.at_beginning_of_month}", "#{lastmonth_range.at_end_of_month}").order("date DESC")
    @total = @expenses.sum(:amount)
  end

  def new
    @expense = Expense.new
  end
  
  def create
    @expense = Expense.create(expense_params)
    # binding.pry
    # respond_to do |format|
    #   format.html { redirect_to expenses_path }
    # end
  end
  
  def destroy
    @successdeleted = "The #{Type.find(Expense.find(params[:id]).type_id).name} #{Expense.find(params[:id]).concept} for $#{Expense.find(params[:id]).amount} on #{Expense.find(params[:id]).date} was destroyed successfully!"
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
