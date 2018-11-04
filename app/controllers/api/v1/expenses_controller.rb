class Api::V1::ExpensesController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_expense, only: [:show, :update, :destroy]

  def index
    @expenses = Expense.all
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
