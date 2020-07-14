class DataSource < ApplicationRecord
  DISTANCE = "distance"
  FLOAT = "float"
  INTEGER = "integer"
  MONEY = "money"
  PERCENT = "percent"
  RANK = "rank"
  STRING = "string"
  VALID_DATA_TYPES = [
    DISTANCE,
    FLOAT,
    INTEGER,
    MONEY,
    PERCENT,
    RANK,
    STRING,
  ]

  validates :source, presence: true
  validates :stat, presence: true
  validates :year, presence: true
  validates :url, presence: true, uniqueness: true
  validates :table_location, presence: true
  validates :golfer_column_name, presence: true
  validates :source_column_names, presence: true
  validates :destination_column_names, presence: true
  validate :valid_data_types
  validate :corresponding_columns_and_types

  enum source: {
    pga: 0,
    rotogrinders: 1,
  }

  private

  def valid_data_types
    unless data_types.all? { |type| VALID_DATA_TYPES.include?(type )}
      errors.add(:data_types, "must include one or more of the following: #{VALID_DATA_TYPES.join(", ")}")
    end
  end

  def corresponding_columns_and_types
    unless source_column_names&.length == destination_column_names&.length && source_column_names&.length == data_types&.length
      errors.add(:base, "corresponding values must be provided for source_column_names, destination_column_names, and data_types")
    end
  end
end
