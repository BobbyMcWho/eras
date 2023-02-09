Rails.application.routes.draw do
  mount Eras::Engine => "/eras"
  get 'raise', to: 'application#raise_error'
  get 'report_message', to: 'application#report_message'
end
