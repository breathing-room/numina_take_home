require 'csv'

module Tracks
  class TotalTracksCount < SmartInit::Base
    initialize_with :tracks_data, :track_class, :start_at
    is_callable

    def call
      {
        unique_tracks_count: unique_track_ids.count
      }
    end

  private
    def filter_by_class
      filter_by_hour.select { |row| row['class'] == track_class }
    end

    def filter_by_hour
      CSV.parse(tracks_data.body, headers: true).select do |row|
        date_time_str = "#{row['date']}T#{row['time']}"
        time = Time.parse(date_time_str).to_i

        time >= start_at && time <= end_at
     end.to_a
    end

    def unique_track_ids
      filter_by_class.uniq { |row| row[0] }
    end

    def end_at
      start_at + 10800
    end
  end
end