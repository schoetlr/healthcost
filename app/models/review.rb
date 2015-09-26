class Review < ActiveRecord::Base
	belongs_to :procedure
	belongs_to :provider
end
