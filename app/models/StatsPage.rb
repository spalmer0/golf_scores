class StatsPage < ParsedPage
  PLAYER_NAME = 'player name'.freeze
  RANK_COLUMN = 'rank this week'.freeze
  TABLE_LOCATION = 'table#statsTable'.freeze

  def data
    @data ||= rows.map.with_index do |tr, index|
      row_data = tr.css('td').map { |td| td.text.gsub("\t", "").strip }

      {
        name: row_data[name_index],
        rank: row_data[rank_index].delete('^0-9').to_i,
        stat: row_data[stat_index],
      }
    end.compact
  end

  private

  def headers
    @headers ||= table.css('th').map do |th|
      th.text
        .gsub("\u00A0", " ")
        .split("\n")
        .map(&:strip)
        .join(" ")
        .strip
        .downcase
    end
  end

  def table
    @table ||= parsed_page.css(TABLE_LOCATION)
  end

  def rows
    @rows ||= table.css('tbody').css('tr')
  end

  def name_index
    @name_index ||= headers.index(PLAYER_NAME)
  end

  def rank_index
    @rank_index ||= headers.index(RANK_COLUMN)
  end

  def stat_index
    @stat_index ||= headers.index(data_source.stat_column_name)
  end
end
