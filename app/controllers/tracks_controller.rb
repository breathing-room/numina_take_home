require 'rest_client'

class TracksController < ApplicationController
  include TracksControllerConcern

  before_action :tracks_data

  def total_tracks
    @class = params[:track_class]
    @start_at = params[:start_at]

    @total_tracks_by_class = Tracks::TotalTracksCount.(
      tracks_data: @tracks_data,
      track_class: @class,
      start_at: @start_at.to_i
    )
  end

  def points
    points = Tracks::Points.(
      tracks_data: @tracks_data,
      track_id: points_params
    )

    render json: (
      points
    )
  end

private

  def total_tracks_params
    params.require(%i[track_class start_at])
  end

  def points_params
    params.require(
      :id
    )
  end

  def tracks_data
    @tracks_data = RestClient.get data_url
  end
end
