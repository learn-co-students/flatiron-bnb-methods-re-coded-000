class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"
  validates_presence_of :rating ,:description ,:reservation
  validate :is_done?


  private


  def is_done?

       errors.add(:reservation, "Reservation is under proccessing...") if reservation && reservation.checkout > Date.today

  end
end
