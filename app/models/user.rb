class User < ApplicationRecord
    has_secure_password

    validates :username, presence: true, uniqueness: true, length: {minimum: 6, maximum: 24}
    validates :password, length: {minimum: 6, maximum: 24}
end