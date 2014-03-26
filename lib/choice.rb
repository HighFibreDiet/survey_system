class Choice <ActiveRecord::Base
  belongs_to (:question)
  has_many :responses

  def number_of_responses
    responses.length
  end

  def percentage_of_question
    result = nil
    thi s_choice = self.number_of_responses
    this_question = self.question.total_number_of_responses
    if this_question == 0
      result = false
    else
      result = (100 * (this_choice.to_f / this_question.to_f)).round(2)
    end
    result
  end

end
