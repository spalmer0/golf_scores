require 'rails_helper'

RSpec.describe ScraperWorker, type: :worker do
  describe '#perform' do

    subject(:worker) { ScraperWorker.new }

    it 'calls #scrape_2020 on Scraper' do
      allow(Scraper).to receive(:scrape_2020)

      worker.perform

      expect(Scraper).to have_received(:scrape_2020)
    end
  end
end
