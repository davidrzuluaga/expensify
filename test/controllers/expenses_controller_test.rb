require 'test_helper'

class ExpensesControllerTest < ActionDispatch::IntegrationTest
  test "should show expenses index" do
    get expenses_url
    assert_response :success
  end

  # test "should create a expense" do
  #   assert_difference('Expense.count') do
  #     post expenses_path, params: { expense: { date: "2018-01-01", concept: "Example", amount: 1, category_id: Category.all.sample.id, type_id: Type.all.sample.id } }
  #   end

  #   assert_redirected_to expenses_url
  # end

  # test "should destroy a expense" do
  #   @expense = Expense.last
  #   assert_difference('Expense.count', -1) do
  #     delete expense_path(@expense)
  #   end

  #   assert_redirected_to expenses_url
  # end
  
end
