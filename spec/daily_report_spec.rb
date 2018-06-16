require 'spec_helper'
require_relative '../daily_report'

RSpec.describe DailyReport do  

  it 'sends an email after creating a csv report' do 
    csv_formatter = CSVFormatter.new
    daily_report = DailyReport.new(formatter: csv_formatter) 
    expect(EmailService).to receive(:send_email)
    daily_report.call
  end 

  it 'sends an email after creating a html report' do 
    html_formatter = HTMLFormatter.new
    daily_report = DailyReport.new(formatter: html_formatter)
    expect(EmailService).to receive(:send_email)
    daily_report.call
  end 
end 

# Train analogy: I can't tell you after the fact whether the train has arrived
# If you don't say what you expect before the method is called then you can't test the method
