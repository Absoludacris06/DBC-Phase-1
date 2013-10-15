# Run this script with ARGV inputs.

require_relative 'List.rb'

todo_list = List.new('todo.csv')
ListIO.input_parser(todo_list, ARGV)
ListIO.csv_save('todo.csv', todo_list.tasks)
