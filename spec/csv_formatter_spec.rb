require 'spec_helper'
require_relative '../csv_formatter'
require_relative '../daily_report'

RSpec.describe "CSV Formatter" do 
  
after do 
  File.delete('./output/report.csv')
end 

subject do 
  csv_formatter = CSVFormatter.new
  DailyReport.new(formatter: csv_formatter) 
end 

it 'is going to produce a CSV file' do 
  # expect(File.exist?('./output/report.csv')).to eq(false)
  subject.call
  expect(File.exist?('./output/report.csv')).to eq(true)
end 

it 'is going to have two entries' do 
  subject.call
  arr_of_arrs = CSV.read("./output/report.csv")
  expect(arr_of_arrs[0]).to eq(["user_email", "registration_date", "account_type"])
  expect(arr_of_arrs[1]).to eq(["tomspencer_uk@yahoo.co.uk", "4/6/18", "gold"])
  expect(arr_of_arrs[2]).to eq(["johnspencer_uk@yahoo.co.uk", "5/6/18", "basic"])
end  

it 'sends an email after creating the file' do  
  expect(EmailService).to receive(:send_email)
  subject.call
end 
 

end 