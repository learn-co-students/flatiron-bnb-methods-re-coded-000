class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"
  validates :rating ,presence: true
  validates :description ,presence: true
  validates :reservation , presence: true
  validate  :reservation_accepted , :checked_out
  private


  def reservation_accepted
    if reservation.try(:status) != "accepted"
      errors.add(:reservation,"Reservation must be accepted!")
    end
  end
  def checked_out
    if reservation && reservation.checkout > Date.today
      errors.add(:reservation,"You must checkout first!")
    end
  end

end
