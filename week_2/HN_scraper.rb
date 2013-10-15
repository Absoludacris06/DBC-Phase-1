# Hacker News scraper using Nokogiri.  Reads in url from ARGV.

require 'Nokogiri'
require 'open-uri'
 
class Post
 
  attr_reader :comments, :title, :url, :points, :item_id
 
  def initialize(title = "", url = "", points = "", item_id = "")
    @title = title
    @url = url
    @points = points
    @item_id = item_id
    @comments = []
  end
 
  def add_comment(comment)
    @comments << comment
  end
 
end
 
class Comment
 
  attr_reader :username, :content
 
  def initialize(comment_arguments)
    @username = comment_arguments[0]
    @content = comment_arguments[1]
  end
 
end
 
html_file_from_net = open(ARGV.first)
 
doc = Nokogiri::HTML.parse(html_file_from_net)
 
title = doc.search('.title > a:first-child').map { |tag| tag.inner_text}.first
url = doc.search('.title > a:first-child').map { |tag| tag['href']}.first
points = doc.search('.subtext > span:first-child').map { |tag| tag.inner_text}.first
item_id_undone = doc.search('.subtext > a:nth-child(3)').map { |tag| tag['href']}.first
 
item_id = item_id_undone.match(/\d+/).to_s
 
site = Post.new(title, url, points, item_id)
 
content_arr = doc.search('.comment').map { |font| font.inner_text}   
username_arr = doc.search('.comhead > a:first-child').map { |tag| tag.inner_text}
comment_args = username_arr.zip(content_arr)
 
comment_args.each do |comment_arguments|
  site.add_comment(Comment.new(comment_arguments))
end
 
p "Post title: #{site.title}"
p "Number of comments: #{site.comments.count}"
p "Post points: #{site.points}"
p "Post URL: #{site.url}"
p "Post item ID: #{site.item_id}"