class Question < ActiveRecord::Base
  belongs_to (:survey)
  has_many (:choices)
  has_many :responses, :through => :choices

  def total_number_of_responses
    responses.length
  end

end
