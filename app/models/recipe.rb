class Recipe < ActiveRecord::Base
    belongs_to :user

    def url
        puts "/recipes/#{self.id}"
    end
    
end
