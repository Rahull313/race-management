Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  root "races#index"
  resources :races do
    get "load_lanes", on: :collection
    resource :race_results, only: [ :new, :update ]
  end
  resources :students
end
