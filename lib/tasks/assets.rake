require 'digest/sha1'

class Hasher
  def initialize(filepath)
    @filename = filepath
  end

  # Compute checksum
  def checksum
    hasher = Digest::SHA1.new

    open(@filename, "r") do |io|
      counter = 0
      while (!io.eof)
        hasher.update(io.readpartial(1024))
      end
    end

    return hasher.hexdigest
  end
end

CHECKSUM_MANIFEST = Rails.root+".asset-checksum.yml"

desc "Have the assets changed since last check"
task "assets:changed" => :environment do
  changed = false
  existing_assets = File.exists?(CHECKSUM_MANIFEST) ? YAML.load_file(CHECKSUM_MANIFEST) : {}

  files = Rails.application.config.assets.paths.map {|dir| Dir[dir+"/**/*"]}.flatten

  checksums = files.inject({}) do |checksums, f|
    hasher = Hasher.new(f)
    checksums[f] = hasher.checksum
    checksums
  end

  changed = !existing_assets.diff(checksums).empty?

  File.open(CHECKSUM_MANIFEST, "w") do |f|
    f.write(checksums.to_yaml)
  end

  exit 0 unless changed
end
