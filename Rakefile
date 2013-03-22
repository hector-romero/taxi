require 'rubygems'
require 'sprockets'
require 'yui/compressor'
require 'erb'
require 'fileutils'
require 'sass'
require 'redcarpet'

def build_assets output_dir
  # Configure Sprockets environment.
  env = Sprockets::Environment.new
  env.append_path 'app/js'
  env.append_path 'app/css'
  env.append_path 'app/resources'

  # Compress JavaScript and shorten local variable names (:munge option)
  env.js_compressor = YUI::JavaScriptCompressor.new :munge => true #, :line_break => 80

  # Compress CSS.
  # Note: This is a horrible monkey-patching. Ass YUI compressor is not working
  # with our CSS, we use the :style option of Sass. Unfortunately, it can be
  # passed in a nice way because the Sass::Engine is instantiated by
  # Sprockets::SassTemplate.
  options = Sass::Engine::DEFAULT_OPTIONS.merge(:style => :compressed)
  Sass::Engine.send(:remove_const, :DEFAULT_OPTIONS)
  Sass::Engine.const_set(:DEFAULT_OPTIONS, options)
  # TODO Remove the above ugly monkey-path and add the next line when this
  # pull-request is closed: https://github.com/sstephenson/ruby-yui-compressor/pull/25
  # (and the gems are updated)
  # env.css_compressor = YUI::CssCompressor.new

  assets     = %w(main.js main.css)
  assets_dir = File.join output_dir, 'assets'
  FileUtils.mkdir_p assets_dir

  assets.each do |asset|
    path = File.join(assets_dir, asset)
    puts "Building '#{path}'"
    File.write path, env[asset].to_s
  end

  puts 'Copying images'
  FileUtils.cp_r 'app/resources/.', assets_dir

end

def build_index output_dir
  # Generate index.html
  index_in = File.join 'views', 'index.erb'
  index_out = File.join output_dir, 'index.html'
  template = ERB.new File.read(index_in)

  puts "Building '#{index_out}'"

  # This variable is used in the binding passed to the template

  File.write index_out, template.result(binding)
end

def build_changelog output_dir
  require 'redcarpet'
  changelog_out = File.join output_dir, 'changelog.html'
  markdown_text = File.read('changelog.md')
  File.write changelog_out, Redcarpet.new(markdown_text).to_html

end

desc 'Builds the application to serve in a static web server.'
task :build, [:output_dir] do |task, args|
  output_dir = args[:output_dir] || 'build'
  puts "Building static application in '#{output_dir}'"

  FileUtils.rm_r output_dir, :force => true
  FileUtils.mkdir_p output_dir
  build_assets output_dir
  build_index output_dir
  build_changelog output_dir
end