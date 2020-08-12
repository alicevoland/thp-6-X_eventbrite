class Attendance < ApplicationRecord
  belongs_to :event
  belongs_to :attendee, class_name: :User, foreign_key: :attendee_id

  after_create :send_new_attendee_email

  def name
    "#{first_name} #{last_name}"
  end

  private

  def send_new_attendee_email
    UserMailer.new_attendee_email(self).deliver_now
  end
end
