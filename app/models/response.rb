class Response < ApplicationRecord
  validates :user_id, :answer_choice_id, presence: true
  validate :respondent_has_not_answered
  belongs_to(
    :respondent,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  belongs_to(
    :answer_choice,
    class_name: 'AnswerChoice',
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  has_one :question, through: :answer_choice, source: :question
  
  def sibling_responses
    self.question.responses.where.not(id: self.id )
  end

  def respondent_already_answered?
    self.sibling_responses.where(user_id: self.user_id).count >= 1
  end

  private 
  
  def respondent_has_not_answered
    if respondent_already_answered?
      errors[:user_id] << "has already responded to this poll."
    end
  end
end
