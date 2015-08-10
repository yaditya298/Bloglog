class User < ActiveRecord::Base
	before_save { self.user_name = user_name.downcase }
	validates :user_name, presence: true, length: { maximum: 50 }, uniqueness: {case_sensitive: false}
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }
end
