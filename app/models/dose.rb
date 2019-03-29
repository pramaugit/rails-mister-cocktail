class Dose < ApplicationRecord
  belongs_to :cocktail
  belongs_to :ingredients
  validates :description, presence: true, allow_blank: false
end
