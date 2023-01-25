class User < ApplicationRecord
    has_secure_password

    validates :username, presence: true, uniqueness: true, length: {minimum: 6, maximum: 24}
    validates :password, length: {minimum: 6, maximum: 24}

    def appear
         self.online = true;
        self.save(validate: false)
    end

    def disappear
        self.online = false;
        self.save(validate: false)
    end
end