Rails.application.routes.draw do
  post '/scores' => 'scores#create'
end
