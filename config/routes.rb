Rails.application.routes.draw do
  resources :tracks, only: [] do
    collection do
      get :total_tracks
    end
  end
end
