Rails.application.routes.draw do
  
  scope "api/v1" do
    resources :reports do
      get :results, on: :member
    end
  end
  
  get "/auth/:provider/callback" => "sessions#create"
  get "/signin" => "sessions#new", :as => :signin
  get "/signout" => "sessions#destroy", :as => :signout
  get "/auth/failure" => "sessions#failure"
  
  get "*path" => "reports#index"
  get "" => "reports#index", as: :root
  
end
