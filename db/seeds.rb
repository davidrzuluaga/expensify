Category.create(name: "Restaurants")
Category.create(name: "Grocery")
Category.create(name: "Car")
Category.create(name: "Services")
Category.create(name: "Home")
Category.create(name: "Education")
Category.create(name: "Fun")
Category.create(name: "Travel")
Type.create(name: "Purchase")
Type.create(name: "Withdrawal")
Type.create(name: "Transfer")
Type.create(name: "Payment")
60.times {Expense.create(date: Faker::Date.between(12.months.ago, Date.today.at_end_of_month), concept: Faker::Restaurant.name, amount: Faker::Commerce.price, category: Category.find_by(name:"Restaurants"), type: Type.find_by(name:"Purchase"))}
24.times {Expense.create(date: Faker::Date.between(12.months.ago, Date.today.at_end_of_month), concept: Faker::Food.ingredient, amount: Faker::Commerce.price, category: Category.find_by(name:"Grocery"), type: Type.find_by(name:"Purchase"))}
15.times {Expense.create(date: Faker::Date.between(12.months.ago, Date.today.at_end_of_month), concept: Faker::Commerce.material, amount: Faker::Commerce.price, category: Category.find_by(name:"Car"), type: Type.find_by(name:"Purchase"))}
40.times {Expense.create(date: Faker::Date.between(12.months.ago, Date.today.at_end_of_month), concept: Faker::Company.profession, amount: Faker::Commerce.price, category: Category.find_by(name:"Service"), type: Type.find_by(name:"Payment"))}
15.times {Expense.create(date: Faker::Date.between(12.months.ago, Date.today.at_end_of_month), concept: Faker::Construction.subcontract_category, amount: Faker::Commerce.price, category: Category.find_by(name:"Home"), type: Type.find_by(name:"Payment"))}
5.times {Expense.create(date: Faker::Date.between(12.months.ago, Date.today.at_end_of_month), concept: Faker::Educator.degree, amount: Faker::Commerce.price, category: Category.find_by(name:"Education"), type: Type.find_by(name:"Payment"))}
40.times {Expense.create(date: Faker::Date.between(12.months.ago, Date.today.at_end_of_month), concept: Faker::App.name, amount: Faker::Commerce.price, category: Category.find_by(name:"Fun"), type: Type.find_by(name:"Purchase"))}
5.times {Expense.create(date: Faker::Date.between(12.months.ago, Date.today.at_end_of_month), concept: Faker::Coffee.origin, amount: Faker::Commerce.price, category: Category.find_by(name:"Travel"), type: Type.find_by(name:"Payment"))}
40.times {Expense.create(date: Faker::Date.between(12.months.ago, Date.today.at_end_of_month), concept: "From #{Faker::Address.community} ATM", amount: Faker::Commerce.price, category: Category.all.sample, type: Type.find_by(name:"Withdrawal"))}
20.times {Expense.create(date: Faker::Date.between(12.months.ago, Date.today.at_end_of_month), concept: "To: #{Faker::Name.name} - Bank Account: #{Faker::Bank.account_number}", amount: Faker::Commerce.price, category: Category.all.sample, type: Type.find_by(name:"Transfer"))}