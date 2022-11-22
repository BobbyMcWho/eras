Eras::Engine.routes.draw do
  root to: "errors#index"
  get "/errors", to: "errors#index"
  get "/errors/:id", to: "errors#show"
end
