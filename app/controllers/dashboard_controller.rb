class DashboardController < ApplicationController
  def index
    @tab = :dashboard
    @todayexpenses = Expense.where("DATE(date) = ?", Date.today).sum(:amount)
    @yesterdayexpenses = Expense.where("DATE(date) = ?", Date.yesterday).sum(:amount)
    @thismonthexpenses = Expense.where("date >= ? AND date <= ?", Date.today.at_beginning_of_month, Date.today.at_end_of_month).sum(:amount)
    @lastmonthexpenses = Expense.where("date >= ? AND date <= ?", Date.today.at_beginning_of_month.last_month, Date.today.at_end_of_month.last_month).sum(:amount)
  
    @type = []
    Type.all.each do |ty|
      @type <<  {name: ty.name, data: Expense.where("date >= ? AND date <= ? AND type_id = #{ty.id}", Date.today.at_beginning_of_month, Date.today).group_by_day_of_month(:date).sum(:amount) }
    end

    @category = []
    Category.all.each do |cat|
      @category << ["#{cat.name}", Expense.where("date >= ? AND date <= ? AND category_id = #{cat.id}", Date.today.at_beginning_of_month, Date.today).sum(:amount) ]
    end
  end
end
