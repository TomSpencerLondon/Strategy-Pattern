require 'spec_helper'
require_relative '../daily_report'
require_relative '../html_formatter'

RSpec.describe "HTML Formatter" do 

  after do 
    File.delete('./output/report.html')
  end 

  subject do 
    html_formatter = HTMLFormatter.new
    DailyReport.new(formatter: html_formatter) 
  end 

  it 'is going to produce an HTML file' do 
    # expect(File.exist?('./output/report.html')).to eq(false)
    subject.call
    expect(File.exist?('./output/report.html')).to eq(true)
  end 

  it 'is going to have two entries' do 
    subject.call
    File.open("./output/report.html") do |file|
      contents = file.read
      expect(contents).to eq("<html>
<body>
<table>
  <tr>
    <th>
      user_email
    </th>
    <th>
      registration_date
    </th>
    <th>
      account_type
    </th>
  </tr>
<tr><td>tomspencer_uk@yahoo.co.uk</td><td>4/6/18</td><td>gold</td></tr>
<tr><td>johnspencer_uk@yahoo.co.uk</td><td>5/6/18</td><td>basic</td></tr>
</table>
  </body>
</html>")
      end 
  end  

  it 'sends an email after creating the html' do  
    expect(EmailService).to receive(:send_email)
    subject.call
  end 

end 

# Train analogy: I can't tell you after the fact whether the train has arrived
# If you don't say what you expect before the method is called then you can't test the method
