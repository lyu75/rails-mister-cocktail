class Dose < ApplicationRecord
  belongs_to :cocktail
  belongs_to :ingredient

  validates :description, presence: true
  validates :cocktail, :ingredient, presence: true

  validates :cocktail, uniqueness: { scope: :ingredient }
  validates :ingredient, uniqueness: { scope: :cocktail }
end
