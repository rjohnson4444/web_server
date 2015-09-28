require 'sinatra/base'

class HttpYeahYouKnowMe < Sinatra::Base
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
