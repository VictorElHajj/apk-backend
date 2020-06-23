# Loads config, initializes program and runs it.

require_relative '../lib/collector/collector.rb'
require_relative '../lib/collector/downloader.rb'
require_relative '../lib/collector/extractor.rb'
require_relative '../lib/collector/importer.rb'
require_relative '../lib/collector/writer.rb'
require 'JSON'

config_path =  File.expand_path('../../config/collector.json', __FILE__)
config = Hash.new do |hash, key|
    raise "Missing or invalid config #{key}"
end
config.merge!(JSON.parse(File.read(config_path)))

collector = Collector.new(
    Downloader.new(max_attempts: config['download_retries'], backoff: config['download_backoff']),
    Extractor.new,
    Importer.new,
    Writer.new(config['db_path']),
)
collector.run