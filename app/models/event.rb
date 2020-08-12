class Event < ApplicationRecord
  belongs_to :administrator, class_name: :User, foreign_key: :administrator_id
  has_many :attendances, dependent: :destroy
  has_many :attendees, through: :attendances

  validate :start_date_is_future
  validate :duration_is_multiple_of_5

  validates :title, length: { in: 5..140 }
  validates :description, length: { in: 20..1000 }
  validates :price, inclusion: 1..1000
  validates :location, length: { minimum: 2 }

  def end_date
    start_date + duration.minutes
  end

  private

  def start_date_is_future
    errors.add(:start_date, 'La date doit être dans le futur') unless start_date && Time.now < start_date
  end

  def duration_is_multiple_of_5
    errors.add(:duration, 'La durée doit être un multpipe de 5') unless duration && duration > 0 && duration % 5 == 0
  end
end
