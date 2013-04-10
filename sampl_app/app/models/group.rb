class Group < ActiveRecord::Base
  attr_accessible :name, :id
	has_many :user
	has_many :schedule
end
