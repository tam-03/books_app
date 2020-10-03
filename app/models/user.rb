class User < ApplicationRecord

  def book
    return Book.where(user_id: self.id)
  end

  validates :name, presence: true
  validates :profile, length: { maximum: 200 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end