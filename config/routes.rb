Rails.application.routes.draw do

  scope module: :public do
    root to: "homes#top"
    get "/about" => "homes#about"

    resources :items,only:[:index,:show]
    # id付

    resources :cart_items,only:[:index,:create,:destroy,:update]
    delete "/cart_items" => "cart_items#all_destroy", as: :cart_items_all_destroy

    resources :orders,only:[:new,:create,:index,:show]

    post "/orders/check" =>"orders#check"

    get "/orders/finish" => "orders#finish"

    resource :customers,only:[:edit,:update]
    get "/customers/my_page" => "customers#show"
    get "/customers/quit" => "customers#quit"
    patch "/customers/withdraw" => "customers#withdraw"

    resources :addresses,only:[:new,:create,:destroy,:edit,:update]

  end

  namespace :admin do
    root to: "homes#top"

    resources :items,only:[:index,:new,:create,:show,:edit,:update]

    resources :genres,only:[:index,:create,:edit,:update]

    resources :customers,only:[:index,:show,:edit,:update]


    resources :orders,only:[:index,:show,:update]


    resources :order_details,only:[:update]

  end


  devise_for :admin, skip: [:registrations, :passwords],controllers: {
    sessions:      'admin/sessions',
    # registrations: 'admin/registrations'
  }
  devise_for :customers,skip:[:passwords],controllers: {
    sessions:      'public/sessions',
    registrations: 'public/registrations'
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
