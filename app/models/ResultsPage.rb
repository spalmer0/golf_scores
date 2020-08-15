class ResultsPage < ParsedPage
  PLAYER_NAME = 'player'.freeze
  RESULTS_COLUMN = 'td.total-score'.freeze
  TABLE_LOCATION = 'table.table-styled'.freeze

  def data
    @data ||= rows.map.with_index do |tr, index|
      row_data = tr.css('td').map { |td| td.text.gsub("\t", "").strip }

      {
        name: row_data[name_index],
        rank: finish[index],
        stat: scores[index],
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

  def scores
    @scores ||= rows.map { |row| row.css(RESULTS_COLUMN).text }
  end

  def finish
    @finish ||= scores.map { |score| scores.index(score) + 1 }
  end
end
