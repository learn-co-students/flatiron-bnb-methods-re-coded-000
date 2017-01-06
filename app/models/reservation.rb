class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review
  validates :checkin, presence: true
  validates :checkout , presence: true
  validate  :guest_and_host_not_the_same , :available , :checkin_before_checkout

  def duration
    (checkout-checkin).to_i
  end
  def total_price
    listing.price*duration
  end
  private
  def guest_and_host_not_the_same
    if guest_id==listing.host_id
     errors.add(:guest_id, "You can't book your own apartment.")
    end
  end
  def available
    Reservation.where(listing_id: listing_id).where.not(id:id).each do |res|
      booked_dates=res.checkin..res.checkout
      if booked_dates === checkin || booked_dates === checkout
        errors.add(:guest_id, "Sorry, this place isn't available during your requested dates.")
      end
    end
  end
  def checkin_before_checkout
    if checkin && checkout && checkin >=checkout
      errors.add(:guest_id, "Your check-out date needs to be after your check-in.")

    end
  end

end
