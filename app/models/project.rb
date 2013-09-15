class Project < ActiveRecord::Base
  belongs_to :user
  has_many :tickets, dependent: :destroy

  validates :name, presence: true
end
