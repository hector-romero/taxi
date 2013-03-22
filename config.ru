map '/' do
  require './app'
  run Sinatra::Application
end

map '/js' do
  require 'sprockets'
  require 'yui/compressor'
  require 'sass'
  require 'coffee-script'
  require 'eco'
  env = Sprockets::Environment.new
  env.append_path 'app/js'
  #env.append_path 'app/css'
  #env.append_path 'app/resources'

  #if production?
  #  # Compress ALL the assets in production.
  #  env.js_compressor = YUI::JavaScriptCompressor.new
  #  #env.css_compressor = YUI::CssCompressor.new
  #end

  run env
end
map '/css' do
  require 'sprockets'
  require 'yui/compressor'
  require 'sass'
  require 'coffee-script'
  require 'eco'
  env = Sprockets::Environment.new
  #env.append_path 'app/js'
  env.append_path 'app/css'
  #env.append_path 'app/resources'

  #if production?
  #  # Compress ALL the assets in production.
  #  env.js_compressor = YUI::JavaScriptCompressor.new
  #  #env.css_compressor = YUI::CssCompressor.new
  #end

  run env
end
map '/img' do
  require 'sprockets'
  require 'yui/compressor'
  require 'sass'
  require 'coffee-script'
  require 'eco'
  env = Sprockets::Environment.new
  #env.append_path 'app/js'
  #env.append_path 'app/css'
  env.append_path 'app/resources'

  #if production?
  #  # Compress ALL the assets in production.
  #  env.js_compressor = YUI::JavaScriptCompressor.new
  #  #env.css_compressor = YUI::CssCompressor.new
  #end

  run env
end

map '/assets' do
  require 'sprockets'
  require 'yui/compressor'
  require 'sass'
  require 'coffee-script'
  require 'eco'
  env = Sprockets::Environment.new
  env.append_path 'app/js'
  env.append_path 'app/css'
  env.append_path 'app/resources'

  #if production?
  #  # Compress ALL the assets in production.
  #  env.js_compressor = YUI::JavaScriptCompressor.new
  #  #env.css_compressor = YUI::CssCompressor.new
  #end

  run env
end
