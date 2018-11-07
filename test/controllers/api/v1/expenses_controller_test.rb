require 'test_helper'

class Api::V1::ExpensesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_expenses_url, as: :json
    assert_response :success
  end

  test "Create an expense in API" do
    assert_difference 'Expense.count' do
      post api_v1_expenses_url, params: { date: "2018-01-01", concept: "Example", amount: 1, category_id: Category.all.sample.id, type_id: Type.all.sample.id }, as: :json
    end

    assert_response 201
  end

  test "Delete an expense in API" do
    @expense = Expense.last
    assert_difference('Expense.count', -1) do
      delete api_v1_expense_url(@expense)
    end
    
    assert_response :no_content
  end
end
