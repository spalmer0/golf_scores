class Formatter
  NON_DIGITS = /\D/

  def self.format(data, data_type)
    new(data, data_type).format
  end

  def initialize(data, data_type)
    @data = data
    @data_type = data_type
  end

  def format
    send("format_#{data_type}")
  end

  private

  attr_reader :data, :data_type

  def format_percent
    (data.to_f / 100).round(4)
  end

  def format_distance
    distances = data.split.map { |x| x[/\d+/] }

    feet = distances[0].to_i
    inches = distances[1].to_f

    portion_of_foot = (inches / 12).round(3)

    feet + portion_of_foot
  end

  def format_float
    data.to_f
  end

  def format_money
    data.gsub(NON_DIGITS, "").to_i
  end

  def format_integer
    data.to_i
  end

  def format_string
    data
  end
end
