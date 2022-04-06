class User < ApplicationRecord
    has_secure_password
    has_many:posts
	# Regex for email
	VALID_EMAIL_REGEX = /\^(.+)@(.+)$/.freeze
	# Verify that name, phone and address
	validates :name, presence: true, length: {  maximum: 25 }, format: { with: /\A[a-zA-Z ]+\z/, message: "Only allow letters"}
	validates :phone, format: {with: /[0-9]+/, message: "Only allow numbers"}
	validates :address, length: { maximum: 255}
	# Verify that email field is not blank and that it doesn't already exist in the db (prevents duplicates):
	validates :email, presence: true,  uniqueness: { case_sensitive: false }

    def self.checkForgetPassword(oldPass,newPass,confirmPass)
        if oldPass == ""
			return ["Old password cannot be blank!!!"]
        elsif newPass == ""
			return ["New password cannot be blank!!!"]
        elsif confirmPass == ""
			return ["Confirm password cannot be blank!!!"]
		elsif oldPass.length <3 || oldPass.length > 15
			return ["Old Password length must be greater than 3 and less than 15!!!"]
		elsif newPass.length <3 || newPass.length > 15
			return ["New Password length must be greater than 3 and less than 15!!!"]
		elsif confirmPass.length <3 || confirmPass.length > 15
			return ["Confirm Password length must be greater than 3 and less than 15!!!"]
        elsif newPass != confirmPass
			return ["New Password and Confirm Password are note same! Please try again!!!"]
        end
        return ""
    end
end

