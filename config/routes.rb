Blank::Application.routes.draw do
  match '/test', :to => "NginxLocationTest#show"
  match '/envvar', :to => "NginxLocationTest#envvars"
  match '/insecure', :to => "Sqlmap#index"
end
