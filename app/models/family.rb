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

  has_many :users
  belongs_to :founder

end
