# app/models/user.rb
class User < Owner
  validates :email, presence: true, uniqueness: true
end
