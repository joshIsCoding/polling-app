class Response < ApplicationRecord
  validates :user_id, :answer_choice_id, presence: true
  validate :respondent_has_not_answered, :respondent_is_not_poll_author
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
  has_one :poll, through: :question, source: :poll

  def sibling_responses
    self.question.responses.where.not(id: self.id )
  end

  def respondent_already_answered?
    self.sibling_responses.where(user_id: self.user_id).count >= 1
  end

  def respondent_is_author?
    self.user_id == self.poll.author_id
  end

  private 
  
  def respondent_has_not_answered
    if respondent_already_answered?
      errors[:user_id] << "has already responded to this poll."
    end
  end

  def respondent_is_not_poll_author
    if respondent_is_author?
      errors[:user_id] << "is the author of the poll and may not answer their own question."
    end
  end

end
