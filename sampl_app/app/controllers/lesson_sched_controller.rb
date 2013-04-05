class LessonSchedController < ApplicationController
 def index
     render :file => 'app/views/lesson_sched/index.html.erb'
  end
  def uploadFile
    post = DataFile.save(params[:upload])
	uploaded_file = params[:file]
	file_content = uploaded_file.read
    render :text => "File has been uploaded successfully"
  end
end
