# Really basic terminal web browser using Nokogiri.

require 'net/http'
require 'nokogiri'

require_relative 'util'

module PageDisplay

  def display(page)
    puts "Title: #{page.title}"
    puts "Page URL: #{page.url}"
    puts "Number of links: #{page.links.count}"
    puts "Content: "
    page.content.each { |para| puts para.to_s }
    puts "Links:"
    page.links.each { |link| puts link.to_s }
  end

  def user_input
    puts "Enter a web address or enter a command (type HELP for more options or enter nothing to quit): "
    gets.chomp
  end

  def show_options
    puts "Type BACK for previous page."
    puts "Type REFRESH to update current page."
  end

end

class Browser

  include PageDisplay

  def initialize
    @url = ''
  end

  def run!
    puts "Welcome to the worst browser ever!"
    while true
      input = user_input
      break if input == ''
      @url = parse_input(input)
      current_page = Page.new(@url)
      display(current_page)
    end
  end

  def parse_input(input)
    case input.downcase
    when 'help'
      show_options
      return parse_input(user_input)
    when 'back'
      puts "That feature doesn't exist yet."
      return @url
    when 'refresh'
      return @url
    else
      return input
    end
  end

end

Browser.new.run!
