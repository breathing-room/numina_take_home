module TracksControllerConcern
  extend ActiveSupport::Concern

  def data_url
    "https://numina-take-home-interview.s3.us-east-2.amazonaws.com/data.csv"
  end
end
