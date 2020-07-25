class City < ActiveRecord::Base

  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods


  
  def city_openings(date_from,date_to)
    listings
  end
  def self.highest_ratio_res_to_listings
   city_ratio_list= {}
   self.all.each do |city|
     res =[]
     city.listings.each do |listing|
       res << listing.reservations.count
     end
     city_ratio_list[city.id]=res.sum/city.listings.count
   end
   city_ratio_list
    City.find_by_id(city_ratio_list.max_by{|k,v| v}[0])

  end
  def self.most_res
   city_ratio_list= {}
   self.all.each do |city|
     res =[]
     city.listings.each do |listing|
       res << listing.reservations.count
     end
     city_ratio_list[city.id]=res.max
   end
   city_ratio_list
    City.find_by_id(city_ratio_list.max_by{|k,v| v}[0])

  end
end
