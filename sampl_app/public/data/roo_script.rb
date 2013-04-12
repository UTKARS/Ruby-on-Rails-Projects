require 'rubygems'
require 'roo'
s = Roo::Excel.new("1it.xls")
s.default_sheet = s.sheets.first
#puts(s)

row = 3
column = 3

last_col = s.last_column + 1
#last_col = 4

celld = s.cell(row, column)
if celld.nil?
  row = row + 1
end

column.upto(last_col) do |col|
  group = s.cell(row, col)

  if (group != nil) 
    puts(group)
    puts("++++++++++++++++++++++")
    row += 2
    row.upto(s.last_row - 2) do |line|
      if(line == row)
        puts "monday\n"
      elsif(line == row + 6)
        puts "tuesday\n"
      elsif(line == row + 12)
        puts "wednesday\n"
      elsif(line == row + 18)
        puts "thursday\n"
      elsif(line == row + 24)
        puts "friday\n"
      elsif(line == row + 30)
        puts "saturday\n"
      end
      lesson = s.cell(line, col)
      cabinet=s.cell(line, col + 1)
      class_num = (line - row + 6) % 6 + 1
      puts "#{class_num}: #{lesson}: #{cabinet}"
    end
    row -= 2   
  end
end
