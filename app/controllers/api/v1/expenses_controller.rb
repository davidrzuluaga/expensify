class Api::V1::ExpensesController < ApplicationController
    def index
      @expenses = Expense.all
      render json: @expenses
    end

    def create
      @expense = Expense.create(expense_params)   
      if @expense.save
        render json: @expense
      else
        render json: { errors: @expense.errors }, status: 422
      end
    end

private

    def expense_params
        params.require(:expense).permit(:date, :concept, :amount, :category_id, :type_id)
    end

end
