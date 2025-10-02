Rails.application.routes.draw do
  root "home#index"
  resources :home, only: [ :index, :new ]
  get "about/index"
  resources :record_titles do
    member do
      get :confirm_destroy
    end
  end
  resources :records do
    member do
      get :confirm_destroy
    end
  end
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  # devise_scope :user do
  #   delete "sign_out", to: "devise/sessions#destroy", as: :destroy_user_session
  # end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # letter_opener_webの設定
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
