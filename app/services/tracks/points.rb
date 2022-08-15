require 'csv'

module Tracks
  class Points < SmartInit::Base
    initialize_with :tracks_data, :track_id
    is_callable

    def call
      gather_track_points
    end

  private
    def gather_track_points
      points = []
      CSV.parse(tracks_data.body, headers: true).select do |row|
        points << JSON.parse(row['box']) if row['trackid'] == track_id
      end

      points
    end
  end
end