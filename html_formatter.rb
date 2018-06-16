class HTMLFormatter
  def write_report(data)
    File.open("./output/report.html", "w") do |file| 
      file.write("<html>
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
  </tr>\n") 
          data.each do |row| 
            file.write("<tr>")
            row.each do |entry|
              file.write("<td>" + entry + "</td>")
            end 
            file.write("</tr>\n")
          end
          
          file.write("</table>
  </body>
</html>") 
    end 
  end  

end 