# == Schema Information
#
# Table name: families
#
#  id         :integer          not null, primary key
#  name       :string
#  founder_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Family < ApplicationRecord

  attr_accessor :member, :invitation_code

  belongs_to :user

  has_many :members, dependent: :destroy
  has_many :users, through: :members

  validates :name, presence: true

  def assignment_for(user)
    members.find_by(user: user).assignment
  end

  def has_members?
    members.count > 0
  end

  def unassigned_members
    member_ids = members.all.pluck :member_id
    members.where.not id: member_ids
  end

  def unclaimed_members
    members.where user_id: nil
  end

end
