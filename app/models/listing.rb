class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations
  validates_presence_of :address, :listing_type, :title, :description, :price, :neighborhood_id
  before_save :enable_host
  before_destroy :disable_host


def average_review_rating
	rating=0
	self.reviews.each { |review| rating += review.rating }
	rating.to_f/self.reviews.size
end

  private
  def enable_host
  	self.host.update(host: true) if ! self.host.host 
  		
    end
  def disable_host  
  	 self.host.update(host: false) if self.host.listings.count <= 1
    end
end
