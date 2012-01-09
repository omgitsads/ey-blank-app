Blank::Application.routes.draw do
  match '/test', :to => "NginxLocationTest#show"
end
