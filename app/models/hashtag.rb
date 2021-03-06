class Hashtag < ApplicationRecord
  TAG_REGEX = /#[[:word:]-]+/

  has_many :hashtag_questions, dependent: :destroy
  has_many :questions, through: :hashtag_questions

  scope :with_questions, -> { joins(:questions).distinct }
  scope :sorted, -> { order(:text) }

  validates :text, presence: true, uniqueness: true

  before_validation :downcase_letters!

  private

  def downcase_letters!
    text&.downcase!
  end
end
