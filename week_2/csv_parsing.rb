# Simple parsing program that reads and modifies a CSV file with user information.
# Allows adding of additional people through Person class.

require 'CSV'
require 'date'
 
class PersonParser
  attr_reader :people_array
 
  def initialize(pathname)
    @people_array = []
    @pathname = pathname
  end
 
  def generate_people
    CSV.foreach(@pathname) do |row|
      if row[0].to_i != 0
        @people_array << Person.new(row[0], row[1], row[2], row[3], row[4], DateTime.parse(row[5]))
      else
        @header = row
        p @header
      end
    end
    people_array
  end
 
  def add_person(first_name, last_name, email, phone)
    id = (@people_array.length + 1).to_s
    @people_array << Person.new(id, first_name, last_name, email, phone, DateTime.now)
  end
 
  def save
    CSV.open(@pathname, "wb") do |csv|
      csv << @header
      @people_array.each do |person|
        csv << person.return_person_info
      end
    end
  end
end
 
class Person
  def initialize(id, first_name, last_name, email, phone, created_at)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @email = email
    @phone = phone
    @created_at = created_at
  end
 
  def return_person_info
    [@id, @first_name, @last_name, @email, @phone, @created_at.to_s]
  end
end