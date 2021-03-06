# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates :title, :user, presence: true

  has_many(
    :post_subs,
    dependent: :destroy
  )

  has_many(
    :subs,
    through: :post_subs,
    source: :sub
  )

  belongs_to(
    :user
  )

  has_many(
    :comments
  )

end
