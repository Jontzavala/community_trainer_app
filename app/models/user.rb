class User < ActiveRecord::Base
    has_secure_password
    validates :password, presence:true, uniqueness: true
    validates :username, presence:true, uniqueness: true 
    validates :email, presence:true, uniqueness: true
    has_many :workouts 
end