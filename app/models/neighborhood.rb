class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings
  has_many :reservations, :through => :listings 

def neighborhood_openings(start_date, end_date)
    time_range = start_date .. end_date
    ids=Listing.select('listings.id').distinct.joins( :reservations, :neighborhood).where.not(reservations:{ checkin: time_range ,checkout: time_range })

    Listing.all.map { |l| l if ! ids.detect{|id| id==l.id}  }
  end
def self.highest_ratio_res_to_listings

    Neighborhood.all.max_by do |n|
   	  listing_count=n.listings.count
   	  reservation_count=n.reservations.count
   	  listing_count>0 ? reservation_count/listing_count : 0


   end
			
end	


def self.most_res
    Neighborhood.all.max_by do |n|
       n.reservations.count
    end

end	
end
