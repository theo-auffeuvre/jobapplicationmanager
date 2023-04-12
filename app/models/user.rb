class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :jobs
  has_many :contacts
  has_many :documents

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true
end
