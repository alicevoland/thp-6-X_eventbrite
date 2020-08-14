class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Can be admin of events
  has_many :events, foreign_key: :administrator_id, dependent: :destroy
  # Can attend events
  has_many :attendances, foreign_key: :attendee_id, dependent: :destroy

  validates :first_name, length: { minimum: 2 }, allow_nil: true
  validates :last_name, length: { minimum: 2 }, allow_nil: true

  validates :description, length: { minimum: 10 }, allow_nil: true

  after_create :send_welcome_email

  def name
    first_name or 'Anonymous'
  end

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end
end
