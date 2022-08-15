Rails.application.routes.draw do
  resources :tracks, only: [:index] do
    collection do
      get :total_tracks
    end
    member do
      get :points
    end
  end
end
