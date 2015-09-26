class Procedure < ActiveRecord::Base
	belongs_to :provider
	has_many :reviews, dependent: :destroy




def self.search(search)
  if search
    where('name LIKE ?', "%#{search}%")
  else
    all
  end
end


end
