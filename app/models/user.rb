# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord

  has_many :members, dependent: :destroy
  has_many :families, through: :members

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, authentication_keys: [:username]

  validates :username, presence: true, uniqueness: true

  def display_name
    if name
      name
    # elsif members.count > 0
    #   members.first.name
    else
      username
    end
  end

  def is_member_of(family)
    members.where(family: family).count > 0
  end

end
