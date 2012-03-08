def compile_assets
  roles :app_master, :app, :solo do
    info "~> Compiling assets if changed"
    run "cd #{c.release_path} && PATH=#{c.binstubs_path}:$PATH #{c.framework_envs} RAILS_GROUPS=assets rake assets:changed assets:precompile:primary"
  end
end
