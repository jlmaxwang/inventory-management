class ExportList < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :powders
end
