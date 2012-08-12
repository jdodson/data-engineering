LivingSocial::Application.routes.draw do
  resources :data_parser, :only => [ :new, :create, :index ]

  root :to => 'data_parser#index'
end
