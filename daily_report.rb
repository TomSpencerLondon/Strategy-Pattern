require 'csv'
require_relative 'email_service'
require_relative 'csv_formatter'
require_relative 'html_formatter'

class DailyReport
  attr_reader :formatter

  def initialize (formatter:)
    @formatter = formatter
  end 

  def call
    data = get_data
    write_report(data)
    send_email
  end 

  private

  def write_report(data)
    @formatter.write_report(data)
  end 

  def send_email(from:"reports@mycompany.co.uk", to:"boss@mycompany.co.uk")
    EmailService.send_email(from: from,to: to, body: "Hi boss, the report is ready")
  end 

  def get_data
    [["tomspencer_uk@yahoo.co.uk", "4/6/18", "gold"],
    ["johnspencer_uk@yahoo.co.uk", "5/6/18", "basic"]]
  end 

end 

#  email of each user, date on which they registered, account type (gold/basic)
# Refactoring Technique: extract method - get the data, write the csv, send the email 
# Initialize or call method two options for giving decision 
# DailyReport.new(type: :csv).call
# DailyReport.new.call(type: :csv)

# Instead of using an if statement we are using polymorphism. If we have a daily report the 
# daily report has sub classes and each subclass has variation on the original configuration. 
# For each of the configuration points we create different classes
# A different daily report method will be called as to whether it is a html or csv daily report. 
