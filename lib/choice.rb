class Choice <ActiveRecord::Base
  belongs_to (:question)
  has_many :responses
  has_many :survey_takers,  :through=> :responses
end
