class Choice <ActiveRecord::Base
  belongs_to (:question)
  has_many :responses

  def number_of_responses
    responses.length
  end
end
