# frozen_string_literal: true

require 'optparse'
require './handle_csv'

def handle_command
  command = ARGV[0]

  case command
  when 'add'
    expenses = load_expenses

    if expenses.empty?
      new_expense_id = 1
      expenses = []
    else
      new_expense_id = [expenses_length, expenses.map { |expense| expense['id'] }.max.to_i + 1].max # NOTE: To avoid duplicate ids
    end

    description = ''
    amount = 0.0

    OptionParser.new do |opts|
      opts.on('--description=DESCRIPTION', String, 'Description of the expense') do |desc|
        description = desc
      end

      opts.on('--amount=AMOUNT', Float, 'Amount of the expense') do |amt|
        amount = amt
      end
    end.parse!

    date = Date.today

    expenses << { 'id' => new_expense_id, 'date' => date, 'description' => description, 'amount' => amount }
    save_expenses(expenses)

    puts "Expense with id #{new_expense_id} added"

  when 'list'
    expenses = load_expenses

    expenses.each do |expense|
      p "ID: #{expense['id']}, Date: #{expense['date']}, Description: #{expense['description']}, Amount: #{expense['amount']}"
    end
  when 'summary'
  when 'delete'
  end
end
