require 'csv'
require_relative 'email_service'

class DailyReport
  attr_reader :type

  def initialize(type)
    @type = type 
  end 

  def call
    data = get_data
    write_csv(data) if @type == :csv  
    write_html(data) if @type == :html
    send_email
  end 

  private

  def send_email(from:"reports@mycompany.co.uk", to:"boss@mycompany.co.uk")
    EmailService.send_email(from: from,to: to, body: "Hi boss, the report is ready")
  end  

  def write 
    
  end 

  def write_csv(data)
    CSV.open("./output/report.csv",  "w") do |csv| 
      csv << ["user_email", "registration_date", "account_type"]
      data.each do |entry| 
        csv << entry
      end 
    end 
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