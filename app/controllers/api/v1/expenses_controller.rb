class Api::V1::ExpensesController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_expense, only: [:show, :update, :destroy]

  def index
    dates = []
    Expense.all.each {|exp| dates << Date.new(exp.date.year, exp.date.month, 1)}
    months = dates.uniq.sort.reverse
    
    if params[:month].present? && params[:month] != ""
      dateparams = params[:month].split("-")
      month = Date.new(dateparams[0].to_i, dateparams[1].to_i, 1)
      firstmonth_range = month
      lastmonth_range = month
    else 
      firstmonth_range = months.last
      lastmonth_range = months.first
    end
    
    @expenses = Expense.where("category_id LIKE ? AND type_id LIKE ? AND date >= ? AND date <= ?", "%#{params[:category]}%", "%#{params[:type]}%", "#{firstmonth_range.at_beginning_of_month}", "#{lastmonth_range.at_end_of_month}").order("date DESC")
    
    render json: @expenses
  end

  def show
    render json: @expense
  end

  def create
    @expense = Expense.create(expense_params)   
    if @expense.save
      render json: @expense
    else
      render json: { errors: @expense.errors }, status: 422
    end
  end

  def update
    @expense = Expense.find(params[:id])
    if @expense.update(expense_params)
      render json: @expense
    else
      render json: { errors: @expense.errors }, status: 422
    end
  end

  def destroy
    @expense.destroy
    
    head :no_content
  end
  
  
  private
  
    def set_expense
      @expense = Expense.find(params[:id])    
    end

    def expense_params
        params.require(:expense).permit(:date, :concept, :amount, :category_id, :type_id)
    end

end
