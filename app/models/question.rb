class Question < ApplicationRecord
  validates :text, presence: true

  belongs_to(
    :poll,
    class_name: 'Poll',
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :answer_choices,
    class_name: 'AnswerChoice',
    foreign_key: :question_id,
    primary_key: :id
  )

  has_many :responses, through: :answer_choices, source: :responses

  def results
    results_ar = self.answer_choices.select("answer_text, COUNT(responses.id) AS response_count")
    .left_outer_joins(:responses)
    .group("answer_choices.id")

    results_ar.inject({}) do |results, record|
      results[record.answer_text] = record.response_count
      results
    end
  end
end
