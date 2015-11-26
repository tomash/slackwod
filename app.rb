require 'sinatra'
require 'koala'
require 'dotenv'
Dotenv.load

get '/' do
  access_token = ENV["ACCESS_TOKEN"]
  graph = Koala::Facebook::API.new(access_token)
  posts = graph.get_connection("CrossFitELEKTROMOC", "posts")
  wod_posts = posts.select { |post| post["message"].strip.match /^WOD#/ }
  wod_post = wod_posts.first
  wod_text = wod_post["message"]
  wod_text.gsub!(/#(\w+)/, "")
  wod_text.squeeze!("\n").strip!
  page_id, item_id = wod_post["id"].split("_")

  returned = "
#{wod_text}

url: https://www.facebook.com/#{page_id}/posts/#{item_id}"

end
