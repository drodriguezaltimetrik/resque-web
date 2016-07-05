# Match IDs with dots in them
id_pattern = /[^\/]+/

ResqueWeb::Engine.routes.draw do

  ResqueWeb::Plugins.plugins.each do |p|
    mount p::Engine => p.engine_path
  end

  resource  :overview,  :only => [:show], :controller => :overview
  resources :working,   :only => [:index]
  resources :queues,    :only => [:index,:show,:destroy], :constraints => {:id => id_pattern} do
    member do
      put 'clear' 
    end
  end
  resources :workers,   :only => [:index,:show], :constraints => {:id => id_pattern}
  resources :failures,  :only => [:show,:index,:destroy] do
    member do
      put 'retry'
    end
    collection do
      put 'retry_all'
      delete 'destroy_all'
    end
  end

  get '/stats' => "stats#index"

  %w(index resque redis keys).each do |action|
    get "/stats/#{action}",     :controller => :stats, :action => action
  end
  get '/stats/keys/:id', :controller => :stats, :constraints => {:id => id_pattern}, :action => :keys, :as => :statistic
  root :to => 'overview#show'
end
