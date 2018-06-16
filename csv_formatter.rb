class CSVFormatter 

  def write_report(data)
    CSV.open("./output/report.csv",  "w") do |csv| 
      csv << ["user_email", "registration_date", "account_type"]
      data.each do |row| 
        csv << row
      end 
    end 
  end 

end 