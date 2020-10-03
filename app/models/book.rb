class Book < ApplicationRecord
  mount_uploader :picture, PictureUploader

  def user
    return User.find_by(id: self.user_id)
  end
  
end
