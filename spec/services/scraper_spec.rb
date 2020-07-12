require 'rails_helper'

RSpec.describe Scraper, type: :service do
  describe '#scrape_all' do
    rotogrinders_data = File.read('spec/fixtures/limited_data/rotogrinders.html')
    pga_data = File.read('spec/fixtures/limited_data/pga.html')

    before do
      create(:data_source, :rotogrinders)
      create(:data_source, :pga)
      allow(HTTParty).to receive(:get).and_return(rotogrinders_data, pga_data)
      allow_any_instance_of(Scraper).to receive(:sleep)
    end

    it 'creates a new golfer' do
      expect { Scraper.scrape_data([2020]) }.to change { Golfer.count }.from(0).to(10)
    end

    it 'creates a new golfer with the compiled data' do
      Scraper.scrape_data([2020])

      expect(Golfer.first).to have_attributes({
        name: 'Rory McIlroy',
        salary: 11200,
        putting_3_2020: 0.9906,
      })
    end
  end
end