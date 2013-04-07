#encoding: utf-8
 class MicropostsController < ApplicationController
  before_filter :authenticate
  before_filter :current_user, :only => [:create, :destroy]
  before_filter :admin_user,   :only => :destroy
  
 def create
    @micropost  = current_user.microposts.build(params[:micropost])
    if @micropost.save
      flash[:success] = "Сообщение отправлено!"
      redirect_to root_path
    else
      render 'pages/home'
    end
  end

  def destroy
	@micropost= Micropost.find(params[:id])
	@micropost.destroy
        flash[:success] = "Сообщение удалено!."
    redirect_to root_path
  end
private

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end

