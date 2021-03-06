class Project < ActiveRecord::Base

  mount_uploader :picture, PictureUploader   
  belongs_to :user
  belongs_to :category
  belongs_to :subcategory
  has_one :city
  has_many :comments
  has_many :pledges
  has_many :backers
  has_many :faqs
  validates :name, :description, :content, :goal, :video, :period, presence: true
  validates :goal, numericality: true
  validates_format_of :video, :with => /^(\/\/)?(www\.)?youtube.com\/embed\/([a-z0-9-]+)/i, :multiline => true, :message => "Invalid format"                           
end

