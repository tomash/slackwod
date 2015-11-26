require 'sinatra'
require 'koala'
require 'dotenv'
Dotenv.load

get '/' do
  access_token = ENV["ACCESS_TOKEN"]
  graph = Koala::Facebook::API.new(access_token)
  posts = graph.get_connection("CrossFitELEKTROMOC", "posts")
  wod_posts = posts.select { |post| post["message"].strip.match /^WOD#/ }
  latest_wod = wod_posts.first
  latest_wod["message"]
end
