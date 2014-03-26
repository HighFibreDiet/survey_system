class Question < ActiveRecord::Base

  I18n.enforce_available_locales = false

  belongs_to (:survey)
  has_many (:choices)
  has_many :responses, :through => :choices
  validates :choices, :presence => true
  validates :description, :presence => true
  def total_number_of_responses
    responses.length
  end

end
