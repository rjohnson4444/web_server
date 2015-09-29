# Tell my computer that web requests to http://localhost:9292 should be sent to me
require 'socket'
require './lib/http_yeah_you_know_me'

port       = 9292
tcp_server = TCPServer.new(port)

# Wait for a request
client = tcp_server.accept

# Read the request
env = {}
line_one = client.gets.split(" ", 3)

env["REQUEST_METHOD"] = line_one[0]
env["PATH_INFO"] = line_one[1]
env["VERSION"] = line_one[2]
require "pry"
binding.pry
array = []
loop do
  line = client.gets.chomp.split(" ", 2)
  break if line == []
  array << line
end

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
