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

require 'test_helper'

class FamilyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
