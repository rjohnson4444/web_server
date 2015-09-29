require 'socket'

class HttpYeahYouKnowMe

  def initialize(port, app)
    @app = app
    @port = port
    @tcp_server = TCPServer.new(port)
  end

  def start
    while !@tcp_server.closed?
      client = @tcp_server.accept
      parse(client)
    end
  end

  def parse(client)
    env = {}
    line_one = client.gets.split(" ")
    env["REQUEST_METHOD"] = line_one[0]
    env["PATH_INFO"] = line_one[1]
    env["VERSION"] = line_one[2]
    request = @app.call(env)

    client.print("HTTP/1.1 #{request[0]} - OK\r\n")
    request[1].each do |key, value|
      client.print("#{key}: #{value}\r\n")
    end
    client.print("\r\n")
    client.print(request[2][0])
    client.close
  end

  def stop
    @tcp_server.close_read
    @tcp_server.close_write
  end
end
