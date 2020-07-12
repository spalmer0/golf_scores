require 'rails_helper'

RSpec.describe Formatter, type: :service do
  describe '#format' do
    it 'formats distances' do
      data = "16' 9\""
      data_type = "distance"

      expect(Formatter.format(data, data_type)).to eq 16.75
    end

    it 'formats percents' do
      data = "83.33"
      data_type = "percent"

      expect(Formatter.format(data, data_type)).to eq 0.8333
    end

    it 'formats money' do
      data = "$12,500"
      data_type = "money"

      expect(Formatter.format(data, data_type)).to eq 12500
    end

    it 'formats integers' do
      data = "10"
      data_type = "integer"

      expect(Formatter.format(data, data_type)).to eq 10
    end

    it 'formats floats' do
      data = "25.10"
      data_type = "float"

      expect(Formatter.format(data, data_type)).to eq 25.10
    end

    it 'formats strings' do
      data = "this is a string"
      data_type = "string"

      expect(Formatter.format(data, data_type)).to eq "this is a string"
    end
  end
end
