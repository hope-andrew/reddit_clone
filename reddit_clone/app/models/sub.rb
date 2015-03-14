# == Schema Information
#
# Table name: subs
#
#  id           :integer          not null, primary key
#  title        :string           not null
#  description  :string           not null
#  moderator_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Sub < ActiveRecord::Base
  validates :title, :description, :moderator, presence: true

  has_many(
    :post_subs,
    dependent: :destroy
  )

  has_many(
    :posts,
    through: :post_subs,
    source: :post
  )

  belongs_to(:moderator, class_name: 'User')
end
