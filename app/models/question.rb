class Question < ApplicationRecord
  has_many :hashtaggables, dependent: :destroy
  has_many :hashtags, through: :hashtaggables

  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  #начиная с 5 рельс связь belongs_to добавляет validates :user, presence: true автоматически
  validates :text, presence: true
  validates :text, length: { maximum: 255 }
  after_save :create_hashtags

  private

  def create_hashtags
    self.hashtags =
      "#{answer} #{text}".
        downcase.
        scan(Hashtag::REGEXP_H).
        uniq.
        map { |tag| Hashtag.find_or_create_by(name: tag.delete('#')) }
  end
end
