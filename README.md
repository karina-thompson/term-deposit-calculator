# Simple Term Deposit Calculator

## Instructions to run

- `brew install ruby` or use a ruby version manager such as `rbenv` or `rvm`
- `gem install bundler`
- `bundle`
- In the main folder, `ruby term_deposit_calculator.rb` to run the command line app
- To run tests, `bundle exec rspec`

## Inputs

This takes 5 inputs:

- Starting deposit amount (in whole $) - handles numbers with/without commas
- Interest rate (as a %) - handles a percent sign being included or not
- Investment term unit - either `months` or `years` - case insensitive
- Number of months/years
- How frequently interest will be paid - `monthly`, `quarterly`,`annually` or `at maturity` - case insensitive

## Output

This will output the final balance at the end of the investment term - to the nearest whole dollar amount
