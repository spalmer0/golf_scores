require 'rails_helper'

RSpec.describe DataScraperWorker, type: :worker do
  describe '#perform' do

    subject(:worker) { DataScraperWorker.new }

    it 'calls #scrape_data_from_all_tournaments on DataScraper' do
      allow(Scraper).to receive(:scrape_data_from_all_tournaments)

      worker.perform

      expect(Scraper).to have_received(:scrape_data_from_all_tournaments)
    end
  end
end

#I don't know how any of this stuff works, but I am testing out making changes and pushing to GitHub.  Meow.