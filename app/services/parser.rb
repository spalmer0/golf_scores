class Parser
  def self.parse_table(data_source, unparsed_page)
    new(data_source, unparsed_page).parse_table
  end

  def initialize(data_source, unparsed_page)
    @data_source = data_source
    @unparsed_page = unparsed_page
  end

  def parse_table
    data
  end

  private

  attr_reader :data_source, :unparsed_page

  def parsed_page
    @parsed_page ||= Nokogiri::HTML(unparsed_page)
  end

  def table
    @table ||= parsed_page.css(data_source.table_location)
  end

  def headers
    @headers ||= table.css('th').map do |th|
      th.text
        .gsub("\u00A0", " ")
        .split("\n")
        .map(&:strip)
        .join()
        .downcase
    end
  end

  def table_rows
    @table_rows ||= table.css('tbody').css('tr')
  end

  def data
    @data ||= table_rows.map do |tr|
      row_data = tr.css('td').map { |td| td.text.gsub("\t", "").strip }

      next if !name_index

      base = { name: row_data[name_index] }

      data_source.destination_column_names.each_with_index do |destination, index|
        data_type = data_source.data_types[index]
        stat = data_source.source_column_names[index]
        stat_index = headers.index(stat)

        next if !stat_index || !Golfer.column_names.include?(destination)

        base[destination.to_sym] = Formatter.format(row_data[stat_index], data_type)
      end

      base
    end.compact
  end

  def name_index
    @name_index ||= headers.index(data_source.golfer_column_name)
  end
end
