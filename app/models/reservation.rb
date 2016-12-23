class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review
  validates_presence_of :checkin ,:checkout
  validate :taken?,:is_valid_date?
 def duration
    checkout && checkin ? checkout - checkin : nil
 end
 def total_price
 	listing.price * duration.to_i

 end
 private
 def is_valid_date?
      checkout && checkin && checkin < checkout ? true : errors.add(:guest_id, "checkout cannot be before checkin date.") 


  end
  def taken?
    pitch= listing.reservations.all? do |reservation|
      reservation.checkin >= checkout || reservation.checkout <= checkin if (checkin && checkout)
    end
     errors.add(:guest_id, "Date range not available, please try again.") if ! pitch
      pitch
   end
   def available
    Reservation.where(listing_id: listing.id).where.not(id: id).each do |r|
      booked_dates = r.checkin..r.checkout
      # if booked_dates === checkin || booked_dates === checkout
      #   errors.add(:guest_id, "Sorry, this place isn't available during your requested dates.")
      # end
    end
  end
end
