require "rails_helper"

describe Tracks::TotalTracksCount do
  subject { described_class }

  let(:headers) { "trackid,date,time,class,box,bottom_center,geo_bottom_center" }
  let(:classes) {
    %w[ pedestrian bicycle moped wheelchair scooter hoverboard ]
  }
  let(:row_data) do
    [0,1,2,3,4,5].map do |i|
      "#{i}, #{Time.zone.today}, #{Time.zone.now}, #{classes[i]}, [#{i},#{i},#{i},#{i}], [#{i*2},#{i*5}], [#{i*3},#{i*6}]"
    end
  end
  let(:mocked_data_response) {
    {
      body: row_data.unshift(headers)
    }
  }
  let(:track_class) { "pedestrian" }
  let(:start_at) {
    Time.parse("#{Time.zone.today}T#{Time.zone.now}")
  }

  describe "#call" do
    it "returns a number representing the unique track IDs found for a given class in a specified hour range" do
      expect(subject.call(
        tracks_data: mocked_data_response,
        track_class: track_class,
        start_at: start_at
      )).to eq(1)
    end
  end
end