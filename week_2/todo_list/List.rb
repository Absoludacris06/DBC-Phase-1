# Basic ToDo list manager.

require 'csv'

class List

attr_reader :tasks

  def initialize(csv_filename)
    @tasks = []
    @csv_filename = csv_filename
    @tasks = ListIO.parse_csv(@csv_filename) 
  end

  def delete(int)
    @tasks.delete_at(int-1)
  end

  def add(task_object)
    @tasks << task_object
  end

  def mark_complete(int)
     @tasks[int-1].complete = true
  end

  def show
    ListDisplay.show(@tasks)
  end

end

class Task
  attr_accessor :complete
  attr_reader :task_content

  def initialize(string, complete_boolean = false)
    @task_content = string
    @complete = complete_boolean
  end
end

class ListDisplay

  def self.show(tasks)
    tasks.each_with_index do |task_object, index|
      puts "#{index+1}. #{task_object.task_content} [#{"X" if task_object.complete}]"
    end
    puts ""
  end

end

class ListIO

  def self.parse_csv(csv_file)
    tasks = []
    CSV.foreach(csv_file, headers: false) do |task_row|
      tasks << Task.new(task_row.first, str_to_bool(task_row[1])) # false is the default boolean value for "complete"
    end
    tasks
  end

  def self.csv_save(csv_filename, tasks)
    CSV.open(csv_filename, "w") do |csv_file|
      tasks.each do |task_object|
        csv_file << [task_object.task_content, task_object.complete.to_s]
      end
    end
  end

  def self.input_parser(list_object, input)
    case input.shift
    when 'show'
      list_object.show
    when 'add'
      list_object.add(Task.new(input.join(' ')))
    when 'delete'
      list_object.delete(input.first.to_i)
    when 'complete'
      list_object.mark_complete(input.first.to_i)
    else
      p "Invalid input"
    end
  end

  private

  def self.str_to_bool(word)
    if word == "true"
      return true
    else
      return false
    end
  end

end
