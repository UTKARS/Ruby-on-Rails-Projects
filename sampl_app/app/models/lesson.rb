class Lesson < ActiveRecord::Base
  attr_accessible :day, :name, :number, :room
	belongs_to :schedule 
end
