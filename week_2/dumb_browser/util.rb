require 'uri'
require 'net/http'
require 'nokogiri'

class Page

  attr_reader :title, :links, :content

  def initialize(address)
    @url = URI.parse(address)
    @http = fetch!
    @html = Nokogiri::HTML.parse(@http.body)
    @title = PageParser.title(@html)
    @links = PageParser.links(@html)
    @content = PageParser.content(@html)
  end
  
  def fetch!
    Net::HTTP.get_response(@url)
  end

  def url
    @url.to_s
  end

end

class PageParser

  def self.title(html)
    html.search('head > title').map { |tag| tag.inner_text }.first
  end
  
  def self.links(html)
    html.search('a').map { |tag| tag['href'] }
  end

  def self.content(html)
    html.search('p').map { |tag| tag.inner_text }
  end

end