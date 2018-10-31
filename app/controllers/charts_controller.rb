class ChartsController < ApplicationController
    def type
      @type = []
      Type.all.each do |ty|
        @type <<  {name: ty.name, data: Expense.where("date >= ? AND date <= ? AND type_id = #{ty.id}", Date.today.at_beginning_of_month, Date.today).group_by_day_of_month(:date).sum(:amount) }
      end
      render json: @type
    end
  
    def category
      @category = []
      Category.all.each do |cat|
        @category << ["#{cat.name}", Expense.where("date >= ? AND date <= ? AND category_id = #{cat.id}", Date.today.at_beginning_of_month, Date.today).sum(:amount) ]
      end
      render json: @category
    end

    def accumulated  
      lastmonthexpaccumulated = {}
      lastmonthallexp = 0
      eachdaylastmonthexp = Expense.where("date >= ? AND date <= ?", Date.today.at_beginning_of_month.last_month, Date.today.at_end_of_month.last_month).group_by_day_of_month(:date).sum(:amount)
      eachdaylastmonthexp.each do |day, exp|
        lastmonthallexp += exp
        lastmonthexpaccumulated[day] = lastmonthallexp
      end

      thismonthexpaccumulated = {}
      thismonthallexp = 0
      eachdaythismonthexp = Expense.where("date >= ? AND date <= ?", Date.today.at_beginning_of_month, Date.today).group_by_day_of_month(:date).sum(:amount)
      eachdaythismonthexp.each do |day, exp|
        thismonthallexp += exp
        thismonthexpaccumulated[day] = thismonthallexp
      end
      
       @twomonthsaccumulated = [{name: "This Month", data: thismonthexpaccumulated}, {name: "Last Month", data:lastmonthexpaccumulated}]

       render json: @twomonthsaccumulated
    end

  end