class AddLastFetchedToDataSource < ActiveRecord::Migration[6.0]
  def change
    add_column :data_sources, :last_fetched, :datetime
  end
end
