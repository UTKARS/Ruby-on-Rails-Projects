class Group < ActiveRecord::Base
  attr_accessible :name
	has_many :user
	has_many :schedule
end
