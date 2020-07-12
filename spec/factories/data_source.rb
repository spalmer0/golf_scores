FactoryBot.define do
  factory :data_source do
    source { :pga }
    stat { 'Approach from 150-175 (RGH)' }
    year { 2020 }
    sequence :url do |n|
      "https://www.pgatour.com/stats/stat.#{n}.html"
    end
    table_location { 'table#statsTable' }
    golfer_column_name { 'player name' }
    data_types { ['distance'] }
    source_column_names { ['avg'] }
    destination_column_names { ['approach_150_175_rgh_2020'] }
  end

  trait :pga do
    source { :pga }
    stat { 'Putting from 3' }
    year { 2020 }
    url { 'https://www.pgatour.com/stats/stat.341.html' }
    table_location { 'table#statsTable' }
    golfer_column_name { 'player name' }
    data_types { ['percent'] }
    source_column_names { ['% made'] }
    destination_column_names { ['putting_3_2020'] }
  end

  trait :rotogrinders do
    source { :rotogrinders }
    stat { 'Odds, Salary' }
    year { 2020 }
    url { 'https://rotogrinders.com/articles/pga-dfs-first-look-travelers-championship-3356387' }
    table_location { 'table.data-table' }
    golfer_column_name { 'golfer' }
    data_types { ['money', 'integer', 'string'] }
    source_column_names { ['dk', 'odds', 'cuts'] }
    destination_column_names { ['salary', 'odds', 'cuts'] }
  end
end
