class Template < ApplicationRecord
  mount_uploader :file, ExcelUploader
  has_many :formulas
  accepts_nested_attributes_for :formulas
  validates :attachable_type, uniqueness: true, presence: true
end
