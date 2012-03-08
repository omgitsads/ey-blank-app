require 'tempfile'

ASSET_CHECK = <<-STR
require 'digest/sha1'
# Require the rails stack
Dir.chdir "#{c.release_path}" do
  require '#{c.release_path}/config/environment'

  module Digest
    class SHA1
      def self.file(filename)
        hasher = self.new
        open(filename, "r") do |io|
          hasher.update(io.readpartial(1024)) while (!io.eof)
        end
        hasher
      end
    end
  end

  CHECKSUM_MANIFEST = "#{c.shared_path}/config/asset-checksum.yml"

  changed = false
  current_assets = File.exists?(CHECKSUM_MANIFEST) ? YAML.load_file(CHECKSUM_MANIFEST) : {}

  files = Dir[*Rails.application.config.assets.paths.map {|dir| dir + "/**/*"}]

  assets = files.inject({}) do |checksums, f|
    checksums[f] = Digest::SHA1.file(f).hexdigest
    checksums
  end

  changed = true unless current_assets.diff(assets).empty?

  File.open(CHECKSUM_MANIFEST, "w") do |f|
    f.write(assets.to_yaml)
  end

  if changed
    exit 1
  else
    exit 0
  end
end
STR

def compile_assets
  roles :app_master, :app, :solo do
    if assets_changed?
      info "~> Assets changed. Compiling"
      run "cd #{c.release_path} && PATH=#{c.binstubs_path}:$PATH #{c.framework_envs} RAILS_GROUPS=assets rake assets:changed assets:precompile:primary"
    else
      info "~> Assets haven't changed. Skipping compilation."
    end
  end
end

def assets_changed?
  file = Tempfile.new('asset-changed')
  file.write(ASSET_CHECK)
  file.close

  info "~> Wrote #{file.path}"

  begin
    run "ruby #{file.path}"
    return false
  rescue EY::Serverside::RemoteFailure
    return true
  end
end
