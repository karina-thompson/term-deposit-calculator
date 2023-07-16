# frozen_string_literal: true

require '././lib/CLI'

describe CLI do
  let(:cli) { CLI.new }

  describe '#format_number_with_commas' do
    it 'formats a 3 digit number without commas' do
      expect(cli.format_number_with_commas('500')).to eq('500')
    end

    it 'formats a 4 digit number with a comma' do
      expect(cli.format_number_with_commas('5000')).to eq('5,000')
    end

    it 'formats a 7 digit number with commas' do
      expect(cli.format_number_with_commas('5000000')).to eq('5,000,000')
    end
  end

  describe '#validate_whole_number' do
    it 'returns true for a whole number' do
      expect(cli.validate_whole_number('5000')[0]).to eq(true)
    end

    it 'returns false for a decimal number' do
      expect(cli.validate_whole_number('1.5')[0]).to eq(false)
    end

    it 'returns false for a non numeric string' do
      expect(cli.validate_whole_number('cookie')[0]).to eq(false)
    end
  end

  describe '#validate_interest_rate' do
    it 'returns true for a whole number' do
      expect(cli.validate_interest_rate('5')[0]).to eq(true)
    end

    it 'returns true for a decimal number' do
      expect(cli.validate_interest_rate('1.5')[0]).to eq(true)
    end

    it 'returns true for a number with a % sign' do
      expect(cli.validate_interest_rate('1.5%')[0]).to eq(true)
    end

    it 'returns false for a non numeric string' do
      expect(cli.validate_interest_rate('donut')[0]).to eq(false)
    end
  end

  describe '#validate_investment_term_unit' do
    it 'returns true for lower case unit' do
      expect(cli.validate_investment_term_unit('years')[0]).to eq(true)
    end

    it 'returns true for capitalized unit' do
      expect(cli.validate_investment_term_unit('Months')[0]).to eq(true)
    end

    it 'returns false for a random string' do
      expect(cli.validate_investment_term_unit('hours')[0]).to eq(false)
    end
  end

  describe '#validate_interest_paid_frequency' do
    it 'returns true for lowercase frequency' do
      expect(cli.validate_interest_paid_frequency('annually')[0]).to eq(true)
    end

    it 'returns true for uppercase frequency' do
      expect(cli.validate_interest_paid_frequency('AT MATURITY')[0]).to eq(true)
    end

    it 'returns true for capitalised frequency' do
      expect(cli.validate_interest_paid_frequency('Monthly')[0]).to eq(true)
    end

    it 'returns false for a random string' do
      expect(cli.validate_interest_paid_frequency('hourly')[0]).to eq(false)
    end
  end
end
