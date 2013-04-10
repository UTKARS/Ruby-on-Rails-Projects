#encoding: utf-8
class SchedulesController < ApplicationController
  def create
    @schedule = Schedule.new(params[:schedule])
    if @schedule.valid?
      flash[:success] = "File upload"
      self.process_file(@schedule)
#      redirect_to @schedule
    else
      @title = "Create"
      render 'new'
    end
  end
  def process_file(model)
    require 'rubygems'
    require 'roo'
    name =  model.myfile.original_filename
    directory = "public/data"
    path = File.join(directory, name)
    FileUtils.cp model.myfile.tempfile.path, path
    s=Roo::Excel.new(path)

    s.default_sheet = s.sheets.first
    3.upto(4) do |col|
      group = s.cell(3, col)
      group_id = Group.where(:name => group)
	puts group_id.inspect
      if group_id.empty?
        t = Group.new
        t.name = group
        t.save
        group_id = t.id      
 #      else 
#		group_id=group_id.id	
	end
 debugger
      sched = Schedule.where(:year => model.year, :semester => model.semester, :group_id => group_id)
      if sched.empty?
	sc = Schedule.new
	sc.year = model.year
	sc.semester = model.semester
	sc.group_id=group_id
	sc.save
	sched = sc.id
      end			
    end
  end
end

