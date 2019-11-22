class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :omniauthable, omniauth_providers: %i[facebook]

  validates :first_name, :last_name, :birthday, presence: true
  has_many :contributions, dependent: :destroy
  has_many :projects, -> { distinct }, through: :contributions
  has_many :counterparts, -> { distinct }, through: :contributions
  def self.from_omniauth(auth)
    User.new(
      email: auth.info.email,
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      birthday: Date.strptime(auth.extra.raw_info.birthday, '%m/%d/%Y'),
      nationality: 'FR',
      country_of_residence: 'FR',
      provider: auth.provider,
      uid: auth.uid
    )
  end
end
