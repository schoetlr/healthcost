class Procedure < ActiveRecord::Base
	belongs_to :provider
	has_many :reviews, dependent: :destroy


  def self.with_code(code)
    where(:code => code).order("created_at DESC")
  end

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      all
    end
  end


end
