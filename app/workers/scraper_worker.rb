class ScraperWorker < ApplicationWorker
  def perform
    Scraper.scrape_2020
  end
end
