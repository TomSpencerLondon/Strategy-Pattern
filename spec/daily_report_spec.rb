require 'spec_helper'
require_relative '../daily_report'

RSpec.describe DailyReport do 
  after do 
    File.delete('./output/report.csv')
  end 

  it 'is going to produce a CSV file' do 
    expect(File.exist?('./output/report.csv')).to eq(false)
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

  it 'sends an email after creating the csv' do  
    expect(EmailService).to receive(:send_email)
    subject.call
  end 

end 

# Train analogy: I can't tell you after the fact whether the train has arrived
# If you don't say what you expect before the method is called then you can't test the method
