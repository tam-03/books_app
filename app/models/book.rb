class Book < ApplicationRecord
  mount_uploader :picture, PictureUploader

  def user
    User.find_by(id: user_id)
  end
end
