# go to http://localhost:9292/to_braille

# require your code you used for NightWriter
# note that we are talking to it through a web interface instead of a command-line interface
# hope you wrote it well enough to support that ;)
require '../night-writer/lib/night_read'

# require a webserver named Sinatra
require 'sinatra/base'

class NightWriterServer < Sinatra::Base
  get '/to_braille' do
    "<form action='/to_braille' method='post'>
      <input type='textarea' name='english-message'></input>
      <input type='Submit'></input>
    </form>"
  end

  post '/to_braille' do
    message = params['english-message']
    braille = Night::Write.call(message) # <-- change this to look like your night writer code
    "<pre>#{braille}</pre>"
  end
end


# switch this to use your server
use_my_server = false

if use_my_server
  require_relative 'lib/http_yeah_you_know_me' # <-- probably right, but double check it
  server = HttpYeahYouKnowMe.new(9292, NightWriterServer)
  at_exit { server.stop }
  server.start
else
  NightWriterServer.set :port, 9292
  NightWriterServer.run!
end
