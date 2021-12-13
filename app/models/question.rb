class Question < ApplicationRecord

  belongs_to :user
  belongs_to :author,
             class_name: 'User',
             optional: true

  has_many :hashtag_questions, dependent: :destroy
  has_many :hashtags, through: :hashtag_questions

  validates :text, presence: true, length: { maximum: 255 }

  after_save_commit :delete_hashtag
  after_save_commit :create_hashtag

  def create_hashtag
    find_hashtags.map do |t|
      # находим хештег в БД или создаем новый
      tag = Hashtag.find_or_create_by(text: t.downcase.delete('#'))
      # связываем хештег с вопросом
      hashtags << tag
    end
  end

  def delete_hashtag
    # ищем по запросу все хештеги, у которых нет связей с вопросами и удаляем их
    Hashtag.left_joins(:hashtag_questions).
      where(hashtag_questions: { hashtag_id: nil }).destroy_all
  end

  private

  # метод для поиска хештегов в тексте вопроса и его ответе
  def find_hashtags
    "#{text} #{answer}".downcase.scan(Hashtag::TAG_REGEX).uniq
  end
end
