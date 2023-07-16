# frozen_string_literal: true

require '././lib/Calculator'

describe Calculator do
  let(:start_deposit) { '10000' }
  let(:interest_rate) { '1.10' }
  let(:investment_term_unit) { 'years' }
  let(:investment_term_number) { '3' }
  let(:interest_paid_frequency) { 'at maturity' }
  let(:calculator) do
    Calculator.new(start_deposit, interest_rate, investment_term_unit, investment_term_number, interest_paid_frequency)
  end

  describe '#calculate_final_balance' do
    it 'gives the expected result for the example inputs' do
      expect(calculator.calculate_final_balance).to eq(10_330)
    end

    context 'with an investment term of months' do
      let(:investment_term_unit) { 'months' }
      let(:investment_term_number) { '8' }

      it 'gives the correct result compared to the Bendigo Bank calculator' do
        expect(calculator.calculate_final_balance).to eq(10_073)
      end
    end

    context 'with interest paid monthly at 2.3%' do
      let(:interest_paid_frequency) { 'monthly' }
      let(:interest_rate) { '2.3' }

      it 'gives the correct result compared to the Bendigo Bank calculator' do
        expect(calculator.calculate_final_balance).to eq(10_714)
      end
    end

    context 'with interest paid annually at 3%' do
      let(:interest_paid_frequency) { 'annually' }
      let(:interest_rate) { '3' }

      it 'gives the correct result compared to the Bendigo Bank calculator' do
        expect(calculator.calculate_final_balance).to eq(10_927)
      end
    end

    context 'with interest paid quarterly over a term of 2 years' do
      let(:interest_paid_frequency) { 'quarterly' }
      let(:investment_term_number) { 2 }

      it 'gives the correct result compared to the Bendigo Bank calculator' do
        expect(calculator.calculate_final_balance).to eq(10_222)
      end
    end
  end
end
