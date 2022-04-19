class ExportList < ApplicationRecord
  has_many :powders
  validates :powder_id, uniqueness: true
  validates :powder_id, :export_qty, presence: true
end
