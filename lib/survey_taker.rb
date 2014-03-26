class Survey_taker<ActiveRecord::Base
  has_many :choices, :through => :responses
  has_many :responses
end
