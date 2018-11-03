class Relationship < ApplicationRecord

  attr_accessor :invitation_code

  belongs_to :user
  belongs_to :family

end
