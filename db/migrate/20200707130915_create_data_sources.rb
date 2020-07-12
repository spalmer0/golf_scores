class CreateDataSources < ActiveRecord::Migration[6.0]
  def change
    create_table :data_sources do |t|
      t.integer :source
      t.string :stat
      t.integer :year
      t.string :url
      t.string :table_location
      t.string :golfer_column_name
      t.string :source_column_names, array: true, default: []
      t.string :destination_column_names, array: true, default: []
      t.string :data_types, array: true, default: []

      t.timestamps
    end
  end
end
