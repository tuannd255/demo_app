class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	validates :name,  presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  	validates :email, presence: true, length: { maximum: 255 },
  					format: { with: VALID_EMAIL_REGEX },
  					uniqueness: { case_sensitive: false }
  	has_secure_password
  	validates :password, presence: true, length: { minimum: 6 }
  	enum gender: ['other', 'male', 'female', 'less', 'gay']
  	validates :birthday, presence: true
  	validate :check_birthday

  	private

  		def check_birthday
          if !self.birthday.nil?    
              if self.birthday > Time.now
                errors.add(:birtday, "Cannot be in the future")
              end
            end
        end
end
