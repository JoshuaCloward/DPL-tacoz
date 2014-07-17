class MenuItem < ActiveRecord::Base
  include PgSearch

   multisearchable against: [:name, :description]
     #, :ingredient_names]

   pg_search_scope :search, against: [:name, :description], associated_against: {
     ingredients: [:name]
 }
  mount_uploader :picture, MenuItemPictureUploader
  has_many :ingredients

  # we need this for nested forms. This saves ingredients when we save a menu item
  accepts_nested_attributes_for :ingredients, allow_destroy: true, reject_if: :has_blank_attributes

  after_initialize do
    if ingredients.empty?
      ingredients.build
    end
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def self.vegetarian
    where(vegetarian: true)
  end

  def has_blank_attributes(ingredient_attrs)
    ingredient_attrs['name'].blank?
  end

  def ingredient_names
    Ingredient.pluck(name)
  end

end
