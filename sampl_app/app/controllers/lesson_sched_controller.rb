#encoding: utf-8
 class LessonSchedController < ApplicationController
 def index
     @product = Schedule.new
     render :file => 'app/views/lesson_sched/index.html.erb'
  end
  def uploadFile
    #post = DataFile.save(params[:upload])
	uploaded_file = params[:file]
	file_content = uploaded_file.read
        
    render :text => "Данные успешно загружены! "
  end
def uploadShedule
	require 'rubygems'
	require 'roo'
	s=Roo::Excel.new("1it.xls")
	s.default_sheet = s.sheets.first
	3.upto(4) do |col|
	group = s.cell(3,col)
	group_id = Group.where(:name => group).first_or_create(:locked => false)
	
        #puts(group)
        if (group != nil) 

    5.upto(40) do |line|
      if(line==5)
        puts "monday\n"
      elsif(line==11)
        puts "tuesday\n"
      elsif(line == 17)
        puts "wednesday\n"
      elsif(line == 23)
        puts "thursday\n"
      elsif(line == 29)
        puts "friday\n"
      elsif(line == 35)
        puts "saturday\n"
      end
      lesson = s.cell(line,col)
      cabinet=s.cell(line,col+1)
      class_num = (line - 5 + 6) % 6 + 1
      puts "#{class_num}: #{lesson}: #{cabinet}"
    end
  end
end
end
end
