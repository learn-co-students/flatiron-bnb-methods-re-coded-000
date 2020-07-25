class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings
  has_many :reservations , through: :listings

def neighborhood_openings(start_date,end_date)
  listings
end
def self.highest_ratio_res_to_listings
  ratio_list= {}
  self.all.each do |neighborhood|
    res =[]
    neighborhood.listings.each do |listing|
      res << listing.reservations.count
    end
    if neighborhood.listings.count!=0
    ratio_list[neighborhood.id]=res.sum/neighborhood.listings.count
  else
    ratio_list[neighborhood.id]=0
  end
  end
   Neighborhood.find_by_id(ratio_list.max_by{|k,v| v}[0])
end

def self.most_res
 ratio_list= {}
 self.all.each do |neighborhood|
   res =[]
   neighborhood.listings.each do |listing|
     res << listing.reservations.count
   end
   if res.max
   ratio_list[neighborhood.id]=res.max
   end
 end
  Neighborhood.find_by_id(ratio_list.max_by{|k,v| v}[0])

end

end
