require 'sinatra'
require 'koala'
require 'dotenv'
Dotenv.load

get '/' do
  access_token = ENV["ACCESS_TOKEN"]
  graph = Koala::Facebook::API.new(access_token)
  posts = graph.get_connection("CrossFitELEKTROMOC", "posts")
  wod_posts = posts.select { |post| post["message"].to_s.strip.match /^WOD\s?#/ }
  wod_post = wod_posts.first
  wod_text = wod_post["message"]
  wod_text.gsub!(/#(\w+)/, "")
  wod_text.squeeze!("\n").strip!
  page_id, item_id = wod_post["id"].split("_")
  posted_at = Time.parse(wod_post["created_time"])

  returned = "
#{wod_text}

posted at: #{posted_at.to_s}
link: https://www.facebook.com/#{page_id}/posts/#{item_id}"

end
