Listnestedresources::Application.routes.draw do
  devise_for :users
  resources :todolists do
  	collection do
  		put :multiple_update
  		get :edit_multiple
  		get :list
  		get :search_form
  	end
	  resources :items do
  		collection do
  		  get :sort
  			get :edit_multiple_item
  			put :multiple_update_items
  			put :update_position
  		end
  	end
  end
  root :to => 'todolists#index'
end
