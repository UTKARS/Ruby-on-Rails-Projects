#encoding: utf-8
class Lesson < ActiveRecord::Base
  attr_accessible :day, :name, :number, :room
  validates :name, :length => { :minimum => 1 }
	belongs_to :schedule

#  default_scope :order => 'number ASC'

  def getDayName()
    dayOfWeek = {"1"=>"Понедельник",2=>"Вторник",3=>"Среда",4=>"Четверг",5=>"Пятница",6=>"Суббота"}
    dayOfWeek[day]
  end
end
