def make_gems_available
  Dir.chdir(release_path) do
    require "rubygems"
    require "bundler"
    Bundler.setup(:deploy)
  end
end
