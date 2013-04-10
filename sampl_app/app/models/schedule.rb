class Schedule < ActiveRecord::Base
  attr_accessor :myfile
  attr_accessible :semester, :year, :myfile
  validates :myfile, :presence =>  {:accept=>''}
#  validates_acceptance_of :myfile
  validates :semester, :year, :presence =>  true
end
