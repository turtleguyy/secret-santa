class Member < ApplicationRecord

  attr_accessor :invitation_code

  belongs_to :user, optional: true
  belongs_to :member, optional: true
  belongs_to :family

  def assignment
    member
  end

  def display_name
    if user
      user.display_name
    else
      name
    end
  end

end
