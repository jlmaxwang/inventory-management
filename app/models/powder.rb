class Powder < ApplicationRecord
  validates :name, :pin_yin, :location, presence: true
  include PgSearch::Model
  pg_search_scope :search_by_name_and_pin_yin_and_location,
    against: [ :name, :pin_yin, :location ],
    using: {
      trigram: {},
      tsearch: { prefix: true, any_word: true }
    }

  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      powder = find_by_name(row['name']) || new
      powder.attributes = row.to_hash
      powder.qty_onhand += powder.qty_import
      powder.save
    end
  end

  def self.open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.xls' then Roo::Excel.new(file.path)
    when '.xlsx' then Roo::Excelx.new(file.path)
    else raise "未知格式: #{file.original_filename}，需要.xls或.xlsx"
    end
  end
end
