class Dog < ApplicationRecord
  include VersionApprover

  validates :name, presence: true
end
