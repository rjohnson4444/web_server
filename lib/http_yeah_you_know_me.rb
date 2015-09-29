require 'sinatra/base'
require 'socket'
require_relative '../examples/night_writer'


class HttpYeahYouKnowMe

  def initialize(port, app)
    @app = app
    @port = port
    @tcp_server = TCPServer.new(port).accept
  end

  def start
    client = @tcp_server
    env = {}
    line_one = client.gets.split(" ", 3)
    env["REQUEST_METHOD"] = line_one[0]
    env["PATH_INFO"] = line_one[1]
    env["VERSION"] = line_one[2]
    env['rack.input'] = StringIO.new()
    request = @app.call(env)

    client.print("HTTP/1.1 200 - OK")
    client.print("Location: http://localhost:9292/to_braille")
    client.print("Content-Type: text/html:charset=utf-8")
    client.print("Content-Length: 150")
    client.print("X-XXS-Protection: 1; mode=block")
    client.print("X-Content-Type-Options: nosniff")
    client.print("X-Frame-Options: SAMEORIGIN")
    client.print("\r\n")
    client.print("<form action='/to_braille' method='post'>\n")
    client.print("<input type='textarea' name='english-message'></input>\n")
    client.print("<input type='Submit'></input>\n")
    client.print("</form>\n")
    require "pry"
    binding.pry
  end

  def stop
    client = @tcp_server
    client.close_read
    client.close_write
  end
end
