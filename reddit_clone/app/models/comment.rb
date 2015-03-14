# == Schema Information
#
# Table name: comments
#
#  id                :integer          not null, primary key
#  content           :text             not null
#  user_id           :integer          not null
#  post_id           :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  parent_comment_id :integer
#

class Comment < ActiveRecord::Base
  validates :content, :user_id, :post_id, presence: true

  belongs_to(
    :author,
    class_name: 'User'
  )

  belongs_to(
    :post
  )

  belongs_to(
    :parent_comment,
    class_name: "Comment"
  )
  has_many(
    :child_comments,
    primary_key: :id,
    foreign_key: :parent_comment_id,
    class_name: "Comment"
  )

end
