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

  belongs_to :founder

  has_many :relationships
  has_many :users, through: :relationships

end
