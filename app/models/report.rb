class Report < ApplicationRecord
    belongs_to :user
    attr_readonly :user_id
end
