class Schedule < ActiveRecord::Base
  attr_accessor :myfile
  attr_accessible :semester, :year, :myfile, :group_id
  validates :myfile, :presence =>  {:accept=>''}
#  validates_acceptance_of :myfile
  validates :semester, :year, :presence =>  true

  belongs_to :group
  has_many :lessons

end
