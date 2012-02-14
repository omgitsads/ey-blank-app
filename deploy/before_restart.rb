if %w(staging integration).include?(environment)
  on_app_servers do
    info "cd #{current_path} && bundle exec rake cache:clear:all"
  end
end
