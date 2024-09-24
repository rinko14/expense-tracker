# frozen_string_literal: true

require 'csv'

def save_expenses(expenses)
  headers = %w[id date description amount]

  CSV.open('expenses.csv', 'w', write_headers: true, headers: headers) do |csv|
    expenses.each do |expense|
      csv << [expense['id'], expense['date'], expense['description'], expense['amount']]
    end
  end
end

def load_expenses
  if File.exist?('expenses.csv')
    expenses = []
    CSV.foreach('expenses.csv', headers: true) do |row|
      expenses << row.to_h
    end
    expenses
  else
    []
  end
end

def expenses_length
  CSV.read('expenses.csv').length
end
