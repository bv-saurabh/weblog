class AdminUser < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, 
		:recoverable, :rememberable, :validatable, :omniauthable

	with_options presence: true do
		validates :email
		validates :provider
		validates :uid, uniqueness: { scope: :provider }
	end

	def password_required?
		return false if provider.present?
		super
	end

	def self.from_omniauth(auth)
		admin_user = where(email: auth.info.email).first || where(auth.slice(:provider, :uid).to_h).first || new
		admin_user.update_attributes({ provider: auth.provider, uid: auth.uid, email: auth.info.email })
		admin_user
	end
end
