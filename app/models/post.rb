class Post < ActiveRecord::Base
  belongs_to :user

  acts_as_taggable

  validates :user_id, uniqueness: { scope: [:date], message: "already posted today" }
  validates :user_id, uniqueness: { scope: [:title], message: "already submitted update" }
  validates :title, presence:true
  validates :body, presence:true
end
