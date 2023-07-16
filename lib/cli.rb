# frozen_string_literal: true

require_relative 'calculator'

class CLI
  def call
    puts 'Welcome to the Simple Term Deposit Calculator'
    start_deposit = prompt_and_validate_input('What is your starting deposit ($)?', :validate_whole_number)
    interest_rate = prompt_and_validate_input('What is the interest rate (%p.a.),?', :validate_interest_rate)
    investment_term_unit = prompt_and_validate_input('Are you investing for a period of months or years?',
                                                     :validate_investment_term_unit)
    investment_term_number = prompt_and_validate_input("How many #{investment_term_unit}?", :validate_whole_number)
    interest_paid_frequency = prompt_and_validate_input(
      'How frequently will interest be paid? Monthly, Quarterly, Annually or At Maturity?',
      :validate_interest_paid_frequency
    )
    final_balance = Calculator.new(start_deposit, interest_rate, investment_term_unit,
                                   investment_term_number, interest_paid_frequency).calculate_final_balance
    puts <<~TEXT

      Final balance: $#{format_number_with_commas(final_balance)}
      On a starting deposit of $#{format_number_with_commas(start_deposit.tr(',', ''))} with an interest rate of #{interest_rate.tr('%', '')}% p.a.#{' '}
      over a period of #{investment_term_number} #{investment_term_unit.downcase} with interest paid #{interest_paid_frequency.downcase}
    TEXT
  end

  def prompt_and_validate_input(question, validation_func)
    puts question
    input = gets.chomp
    valid, message = method(validation_func).call(input)
    until valid
      puts message
      input = gets.chomp
      valid, message = method(validation_func).call(input)
    end
    input
  end

  def format_number_with_commas(number)
    number.to_s.reverse.gsub(/...(?=.)/, '\&,').reverse
  end

  def validate_whole_number(number_str)
    [number_str.to_i.to_s == number_str, 'Please enter a whole number']
  end

  def validate_interest_rate(interest_rate)
    [interest_rate.to_f.positive? && interest_rate.to_f <= 100, 'Please enter a valid interest rate']
  end

  def validate_investment_term_unit(investment_term_unit)
    [Calculator::VALID_INVESTMENT_TERM_UNITS.include?(investment_term_unit.downcase),
     "Please enter one of: 'months' or 'years'"]
  end

  def validate_interest_paid_frequency(interest_paid_frequency)
    [Calculator::VALID_INTEREST_PAID_FREQUENCIES.include?(interest_paid_frequency.downcase),
     "Please enter one of: 'monthly', 'quarterly', 'annually' or 'at maturity'"]
  end
end
