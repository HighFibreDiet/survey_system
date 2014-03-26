require 'active_record'
require './lib/survey'
require './lib/question'
require './lib/choice'
# require './lib/survey_taker'
require './lib/response'


database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configuration)

def welcome
  puts "Welcome to the survey list!"
  menu
end

def menu
  system('clear')
  choice = nil
  until choice == 'e'
    puts "Press 'd' to enter designer menu"
    puts "Press 't' to enter survey taker menu "
    puts "Press 'e' to exit."
    choice = gets.chomp
    case choice
    when 'd'
      designer_menu
    when 't'
      taker_menu
    when 'e'
      puts "Good-bye!"
    else
      puts "Sorry, that wasn't a valid option."
    end
  end
end


def designer_menu
  system('clear')
  user_choice = nil
  until user_choice == 'm'
  puts "Press 'n' to create a new survey"
  puts "Press 'l' to list all of your surveys"
  puts "Press 'q' to list surveys with questions"
  puts "Press 'r' to view survey results"
  puts "Press 'm' to return to the main menu"
  user_choice = gets.chomp
    case user_choice
    when 'n'
      add_survey
    when 'q'
      list_surveys_questions
    when 'l'
      list_surveys
    when 'r'
      survey_results
    when 'm'
      puts "Thanks!"
    else
      puts "That was not a valid choice, please choose again"
    end
  end

end

def add_survey
  puts "Enter the name of your new survey"
  survey_name = gets.chomp
  new_survey = Survey.create(:name => survey_name)

  no_more_questions = false
  until no_more_questions
    puts "Enter a question for your survey, or press 'e' if you have no more questions."
    question_description = gets.chomp
    case question_description
    when 'e'
      no_more_questions = true
    else
      new_question = Question.new(:description => question_description, :survey_id => new_survey.id)
      no_more_choices = false
      until no_more_choices
        puts "Enter an answer choice for this questions, or press 'e' if you are done adding choices."
        answer_choice = gets.chomp
        case answer_choice
        when 'e'
          no_more_choices = true
        else
          new_choice = new_question.choices.new(:description => answer_choice)
        end
      end
      if new_question.save == true
        new_survey.save
        puts "The question #{new_question.description} was created with #{new_question.choices.length} choices"
      else
        puts "Your question must have choices. Please try again. "
      end
    end
  end
  puts "Your survey, #{new_survey.name} was successfully created with #{new_survey.questions.length} questions."
end

def list_surveys_questions
  puts 'Here is a list of your current surveys:'
  Survey.all.each do |survey|
    puts "#{survey.id}) #{survey.name} "
  end

  puts 'Secect the number of the survey to see the questions:'
  survey_choice = gets.chomp.to_i
  survey_questions = Survey.find_by(:id => survey_choice)
  survey_questions.questions.each_with_index do |question, index|
    puts "#{index+1}) #{question.description}"
    question.choices.each_with_index do |choice, choice_index|
      puts "\t#{choice_index + 1}. #{choice.description}"
    end
  end
end

def list_surveys
  puts 'Here is a list of your current surveys:'
  Survey.all.each do |survey|
    puts "#{survey.id}) #{survey.name} "
  end
end

def taker_menu
  puts 'Please choose the number of the survey you would like to take?'
  list_surveys
  survey_choice = gets.chomp.to_i
  selected_survey = Survey.find_by(:id=> survey_choice)

  # current_survey_taker = Survey_taker.create(:survey_id => selected_survey.id)

  puts "The #{selected_survey.name} survey begins now!"
  puts "After each question is displayed, enter the number of your chosen response.\n"

  selected_survey.questions.each_with_index do |current_question, index|
    puts "#{index + 1}. #{current_question.description}"
    current_question.choices.each_with_index do |choice, choice_index|
      puts "\t#{choice_index + 1}. #{choice.description}"
    end
    answer_choice = gets.chomp.to_i
    choice_id = current_question.choices[answer_choice - 1].id
    response = Response.create(:choice_id => choice_id)
    puts "Hit enter to move on to the next question."
    gets
  end
  puts "Press 'a' to take another survey, or hit enter to return to the main menu"
  user_choice = gets.chomp
  if user_choice == 'a'
    taker_menu
  end
end

def survey_results
  list_surveys
  puts "Chose the number of the survey you would like to view:"
  survey_choice = gets.chomp
  selected_survey = Survey.find_by(:id=> survey_choice)
  if selected_survey.responses.length == 0
    puts "You may only view results for surveys that have responses"
  else
    selected_survey.questions.each do |question|
      puts "Question: #{question.description}"
      question.choices.each do |choice|
        puts "\t #{choice.description}       \t  = #{choice.percentage_of_question}% and with \t #{choice.number_of_responses} responses."
      end
    end
  end
end

welcome









