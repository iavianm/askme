class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author,
             class_name: 'User',
             optional: true

  has_many :hashtag_questions, dependent: :destroy
  has_many :hashtags, through: :hashtag_questions

  validates :text, presence: true, length: { maximum: 255 }

  after_save_commit :create_hashtags

  private

  def create_hashtags
    self.hashtags =
      find_hashtags.map do |t|
        # находим хештег в БД или создаем новый
        Hashtag.find_or_create_by(text: t.delete('#'))
      end
  end
  # метод для поиска хештегов в тексте вопроса и его ответе
  def find_hashtags
    "#{text} #{answer}".downcase.scan(Hashtag::TAG_REGEX).uniq
  end
end
