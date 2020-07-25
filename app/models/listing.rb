class Listing < ActiveRecord::Base
  belongs_to :neighborhood , required: true
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations

  validates :address , presence: true
  validates :listing_type , presence: true
  validates :title , presence: true
  validates :description , presence: true
  validates :price , presence: true
  after_save :set_host_status_as_host
  before_destroy :unset_host_status_as_host


 def average_review_rating
   reviews.average(:rating)
 end
  private
  def set_host_status_as_host

     unless host.host?
       host.update(host: true)
     end
   end
   def unset_host_status_as_host
      if Listing.where(host: host).where.not(id: id).empty?
        host.update(host: false)
      end
    end
end
