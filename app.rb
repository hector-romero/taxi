require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' # if development?
require 'sprockets'


options '/*' do
  200
end

get '/' do
  erb :index
end

##############################################
get '/readme' do
  markdown_text = File.new(settings.root + '/README.md').read
  markdown markdown_text
end

get '/changelog' do
  markdown_text = File.new(settings.root + '/changelog.md').read
  markdown markdown_text
end
