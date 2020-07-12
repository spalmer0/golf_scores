require 'rails_helper'

RSpec.describe DataSource, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:source) }
    it { should validate_presence_of(:stat) }
    it { should validate_presence_of(:year) }
    it { should validate_presence_of(:url) }
    it { should validate_uniqueness_of(:url) }
    it { should validate_presence_of(:table_location) }
    it { should validate_presence_of(:golfer_column_name) }
    it { should validate_presence_of(:source_column_names) }
    it { should validate_presence_of(:destination_column_names) }

    describe '#valid_data_types' do
      it 'should only allow data types from VALID_DATA_TYPES' do
        data_source = build(:data_source, data_types: ["foo"])

        expect(data_source).not_to be_valid
      end
    end

    describe '#corresponding_columns_and_types' do
      it 'should require corresponding values for source/destination' do
        data_source = build(:data_source,
          source_column_names: ["1", "2"],
          destination_column_names: ["1"],
        )

        expect(data_source).not_to be_valid
      end

      it 'should require corresponding values for source/data_types' do
        data_source = build(:data_source,
          source_column_names: ["1", "2"],
          data_types: ["string"],
        )

        expect(data_source).not_to be_valid
      end

      it 'should require corresponding values for destination/data_types' do
        data_source = build(:data_source,
          destination_column_names: ["1", "2"],
          data_types: ["string"],
        )

        expect(data_source).not_to be_valid
      end
    end
  end
end
