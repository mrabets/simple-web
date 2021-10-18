require 'rubygems'
require 'sinatra'
require 'json'

FILE_NAME = 'data.json'.freeze

before do
  File.open(FILE_NAME, 'w') unless File.file? FILE_NAME
end

get '/get/:key' do
  data = File.read(FILE_NAME)
  JSON.parse(data)[params[:key]]
end

post '/set' do
  if File.zero?(FILE_NAME)
    data = params.to_json
  else
    json = File.read(FILE_NAME)
    data = JSON.pretty_generate(JSON.parse(json).merge(params))
  end
  File.write(FILE_NAME, data)

  status 204
end
