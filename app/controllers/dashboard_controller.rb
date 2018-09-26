class DashboardController < ApplicationController
  def index
    @tab = :dashboard
    @todayexpenses = Expense.where("DATE(date) = ?", Date.today).sum(:amount)
    @yesterdayexpenses = Expense.where("DATE(date) = ?", Date.yesterday).sum(:amount)
    @thismonthexpenses = Expense.where("date >= ? AND date <= ?", Date.today.at_beginning_of_month, Date.today.at_end_of_month).sum(:amount)
    @lastmonthexpenses = Expense.where("date >= ? AND date <= ?", Date.today.at_beginning_of_month.last_month, Date.today.at_end_of_month.last_month).sum(:amount)
  end
end
