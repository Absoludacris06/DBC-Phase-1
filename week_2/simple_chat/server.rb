# Chat server code goes here

require 'socket'

server = TCPServer.new 7777

puts "Starting server..."

clients = []

loop do
  Thread.start(server.accept) do |client|
    clients << client
    username = client.gets.chomp
    puts "#{username} joined at #{Time.now}."
    client.puts "Welcome! There are #{clients.length} people in the room."
    client.puts "Say something or type 'quit':"
    message = ""
    loop do
      message = client.gets.chomp
      puts "[#{username}]: " + message
      break if message == "quit"
      clients.each { |individual_client| individual_client.puts "[#{username}]: " + message unless individual_client == client }
    end
    clients.delete(client)
    client.close
    clients.each { |individual_client| individual_client.puts "#{username} has left the building. #{clients.length} people in room." }
    puts "#{username} has left the building at #{Time.now}."
  end
end
