class Provider < ActiveRecord::Base
	geocoded_by :address
	after_validation :geocode
	reverse_geocoded_by :latitude, :longitude, :address => :address
	after_validation :reverse_geocode

	has_many :procedures
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  def self.search(search)
  if search
    where('name LIKE ?', "%#{search}%")
  else
    all
  end
  end



end
 