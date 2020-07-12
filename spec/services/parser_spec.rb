require 'rails_helper'

RSpec.describe Parser, type: :service do
  describe '#parse_table' do
    unparsed_page = File.read('spec/fixtures/limited_data/rotogrinders.html')
    let(:service) { Parser.new(data_source, unparsed_page) }

    describe 'when the column_name attributes are correct' do
      let(:data_source) do
        create(:data_source,
          table_location: 'table.data-table',
          golfer_column_name: 'golfer',
          data_types: ['money', 'integer'],
          source_column_names: ['dk', 'odds'],
          destination_column_names: ['salary', 'odds'],
        )
      end

      it 'returns an array of objects with the golfer name and the desired attribute' do
        data = service.parse_table

        expect(data.first).to eq({ name: "Rory McIlroy", salary: 11200, odds: 10 })
      end
    end

    describe 'when the golfer_column_name is wrong' do
      let(:data_source) do
        create(:data_source,
          table_location: 'table.data-table',
          golfer_column_name: 'foobar',
          data_types: ['money', 'integer'],
          source_column_names: ['dk', 'odds'],
          destination_column_names: ['salary', 'odds'],
        )
      end

      it 'returns an empty array' do
        expect(service.parse_table).to eq([])
      end
    end

    describe "when the source_column_names can't be found" do
      let(:data_source) do
        create(:data_source,
          table_location: 'table.data-table',
          golfer_column_name: 'golfer',
          data_types: ['money', 'integer'],
          source_column_names: ['this is not the right column name', 'odds'],
          destination_column_names: ['salary', 'odds'],
        )
      end

      it 'returns an array of objects with the golfer name and the attributes that could be found' do
        data = service.parse_table

        expect(data.first).to eq({ name: "Rory McIlroy", odds: 10 })
      end
    end

    describe 'when the destination_column_names cant be found' do
      let(:data_source) do
        create(:data_source,
          table_location: 'table.data-table',
          golfer_column_name: 'golfer',
          data_types: ['money', 'integer'],
          source_column_names: ['dk', 'odds'],
          destination_column_names: ['this is not the right column name', 'odds'],
        )
      end

      it 'returns an array of objects with the golfer name annd any correct destination_column_names' do
        data = service.parse_table

        expect(data.first).to eq({ name: "Rory McIlroy", odds: 10 })
      end
    end

    describe 'when the table location is wrong' do
      let(:data_source) do
        create(:data_source,
          table_location: 'this is garbage',
          golfer_column_name: 'golfer',
          data_types: ['money', 'integer'],
          source_column_names: ['dk', 'odds'],
          destination_column_names: ['salary', 'odds'],
        )
      end

      it 'returns an empty array' do
        expect(service.parse_table).to eq([])
      end
    end
  end
end
