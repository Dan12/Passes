Rails.application.routes.draw do
  root 'application#home'
  
  #users
  #create
  get '/users/login_page' => 'user#login_page'
  get '/users/login' => 'user#login'
  get '/users/logout' => 'user#logout'
  get '/users/signup' => 'user#signup_page'
  get '/users/create' => 'user#signup'
  
  #view
  get '/users/view/:id' => 'user#view'
  
  #edit
  get '/users/edit/:id' => 'user#edit_page'
  get '/users/update/:id' => 'user#update'
  
  get '/users/change_usertype' => 'user#changeStatus'
  
  #destroy
  #post request, check that request came from users edit page
  
  
end
