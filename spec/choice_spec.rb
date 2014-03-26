require 'spec_helper'

describe Choice do
  it {should belong_to :question}
  it {should have_many :responses}

  describe 'number_of_responses' do
    it 'should return an integer representing the number of responses corresponding to this choice' do
      test_choice = Choice.create(:description => 'this is the first choice', :question_id => 5)
      test_response = Response.create(:choice_id => test_choice.id)
      test_response2 = Response.create(:choice_id => test_choice.id + 1)
      test_choice.number_of_responses.should eq 1
    end
  end

  describe 'percentage_of_question' do
    it 'should return a number between 0 and 100' do
      test_question = Question.new(:description => 'this is the questions')
      test_choice = test_question.choices.new(:description => 'this is the first choice')
      test_choice2 = test_question.choices.new(:description => 'this is the second choice')
      test_question.save
      test_response = Response.create(:choice_id => test_choice.id)
      test_response2 = Response.create(:choice_id => test_choice2.id)
      test_choice.percentage_of_question.should eq 50
    end
    it 'returns an error if there are no responses to the question yet' do
      test_question = Question.new(:description => 'this is the questions')
      test_choice = test_question.choices.new(:description => 'this is the first choice')
      test_choice2 = test_question.choices.new(:description => 'this is the second choice')
      test_question.save
      test_choice.percentage_of_question.should eq false
    end
  end
end
