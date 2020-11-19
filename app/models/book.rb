class Book < ApplicationRecord
  mount_uploader :picture, PictureUploader
  belongs_to :user
  include Commentable
end
