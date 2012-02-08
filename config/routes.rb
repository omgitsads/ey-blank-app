Blank::Application.routes.draw do
  match '/test', :to => "NginxLocationTest#show"
  match '/insecure', :to => "Sqlmap#index"
end
