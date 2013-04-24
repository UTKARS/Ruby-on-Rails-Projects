#encoding: utf-8
class SchedulesController < ApplicationController
def index
     @product = User.new
     render :file => 'app/views/lesson_sched/index2.html.erb'
  end
  def uploadFile
    #post = DataFile.save(params[:upload])
	uploaded_file = params[:file]
	file_content = uploaded_file.read
        
    render :text => "Данные успешно загружены! "
  end
#  def new
#    @schedule = User.new
#    @title = "Sign up"
#  end
  def create
    @schedule = Schedule.new(params[:schedule])
    if @schedule.valid?
      flash[:success] = "File upload"
      @result = self.process_file @schedule
#      redirect_to @schedule
      render 'success'
    else
      @title = "Create"
      render 'new'
    end
  end
  def show
    @schedule = Schedule.new(params[:schedule])
    @title = "Просмотр расписания"
    @groups = Group.where("1")
    if not @schedule.group_id.nil?
      @sch = Schedule.where("group_id = ?", @schedule.group_id).order("year ASC").first
    end
    render 'show'
  end

  def process_file(model)
    name =  model.myfile.original_filename
    directory = "public/data"
    path = File.join(directory, name)
    FileUtils.cp model.myfile.tempfile.path, path
    s = Roo::Excel.new(path)
    s.default_sheet = s.sheets.first

    row = 3
    column = 3

    last_col = s.last_column + 1

    celld = s.cell(row, column)
    if celld.nil?
      row = row + 1
    end
    result = []
    column.upto(last_col) do |col|
      group = s.cell(row, col)
      if (group != nil)
        result.push(group)
#        puts(group)
        group_t = Group.where(:name => group).first
        if group_t.blank?
          t = Group.new
          t.name = group
          t.save
          group_id = t.id
        else
          group_id = group_t['id']
        end

        schedules_t = Schedule.where("year = :year AND semester = :sem AND group_id = :group_id",
                                     {:year => model.year, :sem => model.semester, :group_id => group_id}).first
        if schedules_t.blank?
          t = Schedule.new
          t.year = model.year
          t.semester = model.semester
          t.group_id = group_id
          t.myfile = "z3z"
          t.save
          schedules_id = t.id
        else
          schedules_id = schedules_t['id']
        end
        row += 2
        row.upto(s.last_row - 2) do |line|
          if(line <= row+6)
#            puts "monday\n"
            day = 1
          elsif(line <= row + 12)
#            puts "tuesday\n"
            day = 2
          elsif(line <= row + 18)
#            puts "wednesday\n"
            day = 3
          elsif(line <= row + 24)
#            puts "thursday\n"
            day = 4
          elsif(line <= row + 30)
#            puts "friday\n"
            day = 5
          elsif(line <= row + 36)
#            puts "saturday\n"
            day = 6
          else
            day = 0
          end
          lesson = s.cell(line, col)
          cabinet= s.cell(line, col + 1)
          class_num = (line - row + 6) % 6 + 1
#          debugger
          lesson_db = Lesson.new
          lesson_db.name = lesson
          lesson_db.number = class_num
          lesson_db.room = cabinet
          lesson_db.day = day
          lesson_db.schedule_id = schedules_id
          lesson_db.save
          puts "#{class_num}: #{lesson}: #{cabinet}"
        end
        row -= 2
      end
    end
    result
  end
end
