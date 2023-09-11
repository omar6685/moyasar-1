class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :assign_default_role
  has_many :reports

  def assign_default_role
   self.add_role(:customer) if self.roles.blank?
  end
       
  def admin?
    has_role?(:admin)
  end
  
end
