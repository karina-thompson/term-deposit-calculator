# frozen_string_literal: true

require 'bigdecimal'

class Calculator
  MONTHLY = 'monthly'
  QUARTERLY = 'quarterly'
  ANNUALLY = 'annually'
  AT_MATURITY = 'at maturity'
  VALID_INTEREST_PAID_FREQUENCIES = [MONTHLY, QUARTERLY, ANNUALLY, AT_MATURITY].freeze
  MONTHS = 'months'
  YEARS = 'years'
  VALID_INVESTMENT_TERM_UNITS = [MONTHS, YEARS].freeze
  TIMES_INTEREST_PAID_PER_YEAR = { MONTHLY => 12, QUARTERLY => 4, ANNUALLY => 1 }.freeze

  def initialize(start_deposit, interest_rate, investment_term_unit, investment_term_number, interest_paid_frequency)
    @start_deposit = BigDecimal(start_deposit.tr(',', ''))
    @interest_rate = BigDecimal(interest_rate.tr('%', ''))
    @investment_term_unit = investment_term_unit
    @investment_term_number = BigDecimal(investment_term_number)
    @interest_paid_frequency = interest_paid_frequency
  end

  def calculate_investment_term_in_years
    @investment_term_unit == YEARS ? @investment_term_number : @investment_term_number / 12
  end

  def calculate_at_maturity_final_balance(term_in_years)
    interest = @start_deposit * (@interest_rate / 100) * term_in_years
    (@start_deposit + interest).round
  end

  def calculate_compound_interest_final_balance(term_in_years)
    rate_decimal = @interest_rate / 100
    times_interest_paid_per_year = TIMES_INTEREST_PAID_PER_YEAR[@interest_paid_frequency]
    final_balance =
      @start_deposit *
      (1 + rate_decimal / times_interest_paid_per_year)**(times_interest_paid_per_year * term_in_years)
    final_balance.round
  end

  def calculate_final_balance
    term_in_years = calculate_investment_term_in_years

    return calculate_at_maturity_final_balance(term_in_years) if @interest_paid_frequency == AT_MATURITY

    calculate_compound_interest_final_balance(term_in_years)
  end
end
