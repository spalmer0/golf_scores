class ParsedPage
  attr_reader :unparsed_page, :data_source

  def initialize(unparsed_page, data_source)
    @unparsed_page = unparsed_page
    @data_source = data_source
  end

  def parsed_page
    @parsed_page ||= Nokogiri::HTML(unparsed_page)
  end
end
