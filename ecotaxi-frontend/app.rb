require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' # if development?
require 'sprockets'
require 'yaml'
require 'json'

MOCK_TRIPS_COUNT = 7

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


get '/mock_api/trips', :provides => :json do
  api_data[:trips][0][:id] = rand()
  {:trips => api_data[:trips]}.to_json
end

##############################################
helpers do
 ##################
  # REST API helpers
  #

  def api_data
    @api_data ||= generate_api_data
  end

  def generate_api_data
    data = YAML.load File.read('mock_data.yml')

    users             = data[:users]
    places            = data[:places]
    timers            = data[:timers]

    rnd = Random.new 4321 #To get every time the same random numbers, so the data will remain the same.

    # Generate trips
    data[:trips] = (1..MOCK_TRIPS_COUNT).collect do |id|
      trip = {}
      trip[:id]             = id.to_s
      user = users.sample random: rnd
      trip[:passenger]      = user[:name] #users.sample random: rnd
      trip[:phone]          = user[:phone]
      from_to               = places.sample 2, random: rnd
      trip[:from]           = from_to[0]
      trip[:to]             = from_to[1]
      trip[:timer]          = timers.sample random: rnd #timers[id % timers.size]
      trip
    end

    data
  end







end

