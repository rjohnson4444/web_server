# Tell my computer that web requests to http://localhost:9292 should be sent to me
require 'socket'

port       = 9293
tcp_server = TCPServer.new(port)

# Wait for a request
client = tcp_server.accept

# Read the request
line_one = client.gets.split(" ", 2)

array = []
loop do
  line = client.gets.chomp.split(" ", 2)
  break if line == []
  array << line
end
# require "pry"
# binding.pry
request = array.to_h
# LetsGoExploring.new.call(request)

braille = "hello"
file = File.read(input.html)
# Write the response
client.print("HTTP/1.1 302 Found\r\n")
client.print(Location: "http://localhost:9293/this/is/the/path\r\n")
client.print("Content-Type: text/html; charset=UTF-8\r\n")
client.print("Content-Length: 219\r\n")
client.print("\r\n")
client.print("<HTML><HEAD></HEAD><BODY><h1>#{file}</h1></BODY>\r\n")
client.close


# I'm done now, computer ^_^
tcp_server.close_read
tcp_server.close_write
