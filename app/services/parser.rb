class Parser
  TOURNAMENT_DROPDOWN = '.statistics-details-select--tournament'.freeze

  def self.parse_table(unparsed_page, data_source)
    new(unparsed_page, data_source).parse_table
  end

  def self.parse_tournaments(unparsed_page)
    new(unparsed_page, nil).parse_tournaments
  end

  def initialize(unparsed_page, data_source)
    @unparsed_page = unparsed_page
    @data_source = data_source
  end

  def parse_table
    parsed_page.data
  end

  def parse_tournaments
    tournaments
  end

  private

  attr_reader :data_source, :unparsed_page

  def parsed_page
    @parsed_page ||= results? ? ResultsPage.new(unparsed_page) : StatsPage.new(unparsed_page, data_source)
  end

  def parsed_page
    @parsed_page ||= Nokogiri::HTML(unparsed_page)
  end

  def tournament_options
    @tournament_options ||= parsed_page.css(TOURNAMENT_DROPDOWN).css('option')
  end

  def tournaments
    @tournaments ||= tournament_options.map do |option|
      {
        pga_id: option.values[0],
        name: option.text,
      }
    end
  end

  def results?
    data_source.stat == "results"
  end
end
