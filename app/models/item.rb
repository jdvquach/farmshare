class Item < ApplicationRecord

belongs_to :category, optional:true
belongs_to :user, optional:true
validates :summary, presence: true

end
