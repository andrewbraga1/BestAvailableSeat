Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'api/v1/track_best_seats', to:'api/v1/best_seat#index' 
end
