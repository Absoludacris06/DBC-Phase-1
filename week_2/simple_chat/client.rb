# Chat client code goes here

require 'socket'

puts "Please enter your username:"
username = gets.chomp

s = TCPSocket.new 'dbc04.local', 7777
s.puts username

line = ""
input = ""

output_thread = Thread.new do
  while line = s.gets and input != "quit"
    puts line
  end
end

input_thread = Thread.new do
  while input != "quit"
    input = gets.chomp
    s.puts input
  end
end

s.flush

output_thread.join
input_thread.join

s.close
