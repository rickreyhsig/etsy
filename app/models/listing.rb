class Listing < ActiveRecord::Base
  if Rails.env.production? # PROD; works with Dropbox
    has_attached_file :image, :styles => { :medium => "200x200>", :thumb => "100x100>" }, :default_url => "default.png",
    :storage => :dropbox,
    :dropbox_credentials => Rails.root.join("config/dropbox.yml"), 
    :path => ":style/:id_:filename"
  else                     # DEV and TEST
    has_attached_file :image, :styles => { :medium => "200x200>", :thumb => "100x100>" }, :default_url => "default.png"
  end
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :name, :description, :price, presence: true
  validates :price, numericality: {greater_than: 0}
  validates_attachment_presence :image
end
