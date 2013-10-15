# More advanced implementation of OOP.  Got a bit carried away with features and
# didn't complete all functionality.  Could add more to UI class and further divide
# responsibilities of AuthenticationSystem class.

class Hospital
	attr_reader :location, :name, :number_of_employees, :number_of_patients

	def initialize(location, name)
		@location = location
		@name = name
		@patient_capacity = 0
		@employee_list = []
		@patient_list = []
	end

	def add_employee(first_name, last_name, position)
		title_class_name = convert_to_constant(position)
		if Employee.descendants.include?(title_class_name)
			new_employee = title_class_name.new(first_name, last_name) 
		else
			new_employee = Employee.new(first_name, last_name, position.downcase.capitalize)
		end
		@employee_list << new_employee
		p "Added new employee: #{last_name}, #{first_name}"
	end

	def remove_employee(name)
		return unless valid_employee?(name)
		deleted_employee = @employee_list.delete { |employee| employee.last_name == name}

		@employee_list.each do |employee|
			if employee.last_name == name
				@employee_list.delete(employee)
				p "#{employee.position} #{employee.first_name} #{employee.last_name} has been removed."
				return
			end
		end
	end

	def add_patient(first_name, last_name, reason)
		@patient_list << Patient.new(first_name, last_name, reason)
		p "Added new patient: #{last_name}, #{first_name}"
	end

	def remove_patient(id_number)
		return unless valid_patient?(id_number)
		@patient_list.each do |patient|
			if patient.id == id_number
				@patient_list.delete(patient)
				p "Patient #{patient.last_name}, #{patient.first_name} has been removed."
				return
			end
		end
	end

	def show_patient_list
		@patient_list.each do |patient|
			p "Patient ID #{patient.id}: #{patient.last_name}, #{patient.first_name}"
		end
	end

	def show_employee_list
		@employee_list.each do |employee|
			p "#{employee.position} #{employee.first_name} #{employee.last_name}"
		end
	end

	def find_patient(id_number)
		return nil unless valid_patient?(id_number)
		target = nil
		@patient_list.each do |patient|
			if patient.id == id_number
				patient.show_info
				return patient
			end
		end
	end

	def find_employee(name)
		return nil unless valid_employee?(name)
		@employee_list.each do |employee|
			if employee.last_name == name
				employee.show_info
				return employee
			end
		end
	end

	def change_patient_status(id_number)
		return unless valid_patient?(id_number)
		@patient_list.each do |patient|
			if patient.id == id_number
				patient.mark_as_treated
			end
		end
	end

	def valid_patient?(id_number)
		valid = false
		@patient_list.each do |patient|
			if patient.id == id_number
				valid = true
			end
		end
		p "Invalid patient." unless valid
		valid
	end

	def valid_employee?(name)
		valid = false
		@employee_list.each do |employee|
			if employee.last_name == name
				valid = true
			end
		end
		p "Invalid employee." unless valid
		valid
	end

	private

	def convert_to_constant(position)
		Object.const_get(position.downcase.capitalize)
	end

end

class Patient
	attr_reader :first_name, :last_name, :reason, :treated, :id

	@@historic_count = 0
	
	def initialize(first_name, last_name, reason)
		@first_name = first_name
		@last_name = last_name
		@reason = reason
		@treated = false
		@@historic_count += 1
		@id = @@historic_count.to_s
	end

	def mark_as_treated
		@treated = true
		p "Patient #{first_name} #{last_name} is now marked as treated."
	end

	def show_info
		p "Patient name: #{@first_name} #{@last_name}"
		p "ID: #{@id}"
		p "Reason for visit: #{reason}"
		p "Treated?: #{@treated}"
	end

end

class Employee
	attr_reader :first_name, :last_name, :position

	def initialize(first_name, last_name, position = 'Employee')
		@first_name = first_name
		@last_name = last_name
		@position = position
	end

	def show_info
		p "Employee name: #{@first_name} #{@last_name}"
		p "Position: #{@position}"
	end

	def self.descendants
		ObjectSpace.each_object(Class).select { |klass| klass < self }
	end

end

class Doctor < Employee

	def initialize(first_name, last_name)
		super
		@position = 'Doctor'
	end

end

class Nurse < Employee

	def initialize(first_name, last_name)
		super
		@position = 'Nurse'
	end

end

class Receptionist < Employee

	def initialize(first_name, last_name)
		super
		@position	= 'Receptionist'
	end

end

class Janitor < Employee

	def initialize(first_name, last_name)
		super
		@position = 'Janitor'
	end

end

class Administrator < Employee

	def initialize(first_name, last_name)
		super
		@position = 'Administrator'
	end

end

module UI 

	def show_menu
			puts "What would you like to do? (INPUT)"
			puts "-add employee (ADD EMP)"
			puts "-remove employee (REMOVE EMP)"
			puts "-add patient (ADD PAT)"
			puts "-remove patient (REMOVE PAT)"
			puts "-view employee list (EMP LIST)"
			puts "-view patient list (PAT LIST)"
			puts "-view employee record (VIEW EMP)"
			puts "-view patient record (VIEW PAT)"
			puts "-mark patient as treated (PAT TREAT)"
			puts "-quit (QUIT)"
	end

end

class AuthenticationSystem
 
	include UI

	def add_hospital(hospital)
		@hospital = hospital
	end

	def access_portal
		puts "Welcome to #{@hospital.name} AuthSys! Please enter your last name: "
		last_name = gets.chomp
		if @hospital.valid_employee?(last_name)
			user = @hospital.find_employee(last_name)
			# TODO: add security clearance integer for each class
			case user.position.downcase
			when "administrator"
				admin_access(user)
			when "doctor"
				# TODO: add doctor_access(accessor)
			when "nurse"
				# TODO: add nurse_access(accessor)
			when "janitor"
				# TODO: add janitor_access(accessor)
			else
				puts "#{user.position.downcase.capitalize} does not have access to the system."
			end
		else
			puts "INVALID LOGIN"
		end
	end

	def admin_access(accessor)
		puts "Welcome #{accessor.position} #{accessor.last_name}."
		quit = false
		until quit
			self.show_menu
			# TODO: add other options & case statement on selection
			input = gets.chomp
			case input.downcase
			when "add emp"
				add_emp
			when "remove emp"
				remove_emp
			when "add pat"
				add_pat
			when "remove pat"
				remove_pat
			when "emp list"
				emp_list
			when "pat list"
				pat_list
			when "view emp"
				view_emp
			when "view pat"
				view_pat
			when "pat treat"
				pat_treat
			when "quit"
				quit = true
				puts "Goodbye!"
			else
				puts "INVALID CHOICE"
			end
		end
	end

	def add_emp
		p "Enter first name:"
		first_name = gets.chomp
		p "Enter last name:"
		last_name = gets.chomp
		p "Enter position:"
		position = gets.chomp
		@hospital.add_employee(first_name, last_name, position)
	end

	def remove_emp
		p "Enter last name of employee to remove:"
		last_name = gets.chomp
		@hospital.remove_employee(last_name)
	end

	def add_pat
		p "Enter first name:"
		first_name = gets.chomp
		p "Enter last name:"
		last_name = gets.chomp
		p "Enter reason for visit:"
		reason = gets.chomp
		@hospital.add_patient(first_name, last_name, reason)
	end

	def remove_pat
		p "Enter ID number of patient to remove:"
		id_number = gets.chomp
		@hospital.remove_patient(id_number)
	end

	def emp_list
		@hospital.show_employee_list
	end

	def pat_list
		@hospital.show_patient_list
	end

	def view_emp
		p "Enter last name of employee:"
		last_name = gets.chomp
		@hospital.find_employee(last_name)
	end

	def view_pat
		p "Enter patient ID number:"
		id_number = gets.chomp
		@hospital.find_patient(id_number)
	end

	def pat_treat
		p "Enter patient ID number of treated patient:"
		id_number = gets.chomp
		@hospital.change_patient_status(id_number)
	end

end

hospital = Hospital.new("SF", "SF General")
hospital.add_employee("This", "Guy", "Administrator")
the_system = AuthenticationSystem.new
the_system.add_hospital(hospital)
the_system.access_portal