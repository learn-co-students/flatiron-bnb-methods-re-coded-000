class City < ActiveRecord::Base
	extend ActiveSupport::Concern
   has_many :neighborhoods
   has_many :listings, :through => :neighborhoods
   has_many :reservations, :through => :listings

  def city_openings(start_date, end_date)
    time_range = start_date .. end_date
    ids=Listing.select('listings.id').distinct.joins( :reservations, :neighborhood).where('neighborhoods.city_id = ?',id).where.not(reservations:{ checkin: time_range },reservations:{ checkout: time_range })


    Listing.all.map { |l| l if ! ids.detect{|id| id==l.id}  }
  end


  def self.highest_ratio_res_to_listings
      City.all.max_by do |city|
      reservations_ = city.reservations.count 
      city_listings = city.listings.count 
      reservations_.to_f/city_listings
    end
  end
  def self.most_res
     City.all.max_by do |city|
      city.reservations.count
     end 
  	
  end

end
