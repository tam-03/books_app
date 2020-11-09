class Report < ApplicationRecord
  include Commentable
  validates :title, :body, :user_id, presence: true
  belongs_to :user
end
