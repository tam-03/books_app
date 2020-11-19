class Report < ApplicationRecord
  include Commentable
  belongs_to :user
  validates :title, :body, :user_id, presence: true
end
