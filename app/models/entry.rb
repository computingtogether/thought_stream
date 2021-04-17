class Entry < ApplicationRecord
  validates :thoughts, presence: true, length: { minimum: 2 }
end
