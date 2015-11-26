# SlackWOD: display today's WOD using simple Slack command

This is a simple Ruby/Sinatra app that fetches posts from a facebook fanpage, chooses one of them (this implementation: latest one that begins with "WOD#" string, which is a format used by my box Crossfit Elektromoc on their fb) and returns the result.

## Configuration

This is a multi-step process, unfortunately. Clone the application repository. 

Let's start with the hardest part: Facebook tokens.

### Facebook

1. Create a new (web) app for Facebook at https://developers.facebook.com
2. Save App ID and App Secret somewhere safe.
3. Go to Graph API explorer at https://developers.facebook.com/tools/explorer/ , choose your app from "application" dropdown, generate new Access Token from "Get Token" dropdown (you don't need to give any permissions to your account).
4. You'll get a short-lived access token, valid for ~2 hours. It's possible to generate a long-lived access token valid for 60+ days, in order to do it stay in Graph API Explorer and GET a following URL (make sure it's all in one file):

    /oauth/access_token?
    grant_type=fb_exchange_token&           
    client_id={app-id}&
    client_secret={app-secret}&
    fb_exchange_token={short-lived-token} 

5. Save the long-lived access token in .env file in application directory


### Application

Run the application

    bundle install
    rackup

And go to http://localhost:9292/ to see if it successfully returns the latest relevant post from the fanpage.

Deploy it somewhere (it's ready to be deployed on Heroku) to have a public address.

### Slack

Add a new command-reaction, point to public address, enjoy.

## Author

Tomasz Stachewicz, 2015

## License

MIT
