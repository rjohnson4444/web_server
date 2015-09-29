require 'sinatra/base'
require 'socket'


class HttpYeahYouKnowMe < Sinatra::Base
  attr_accessor :tcp_server
  def initialize(port, app = nil)
    @port = port
    @tcp_server = TCPServer.new(port).accept
  end

  def request
    client = @tcp_server
    env = {}
    line_one = client.gets.split(" ", 3)
    env["REQUEST_METHOD"] = line_one[0]
    env["PATH_INFO"] = line_one[1]
    env["VERSION"] = line_one[2]
    env['rack.input'] = StringIO.new()
    env
    require 'pry'; binding.pry
  end

end
