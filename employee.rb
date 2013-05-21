class Employee
  attr_accessor :name, :title, :salary, :boss
  def initialize(name)
    @name = name
    @boss = []
  end

  def calculate_bonus(multiplier = 1)
    raise "Please set salary for #{self.name}" if salary.nil?
    bonus = salary * multiplier
  rescue => e
    puts "#{e.message}"
    puts "There is no salary set for this employee..."
  end
end

class Manager < Employee
  attr_reader :employees

  def initialize(name)
    super(name)
    @employees = []
  end

  def add_employee(employee)
    @employees << employee unless employees.include?(employee)
    employee.boss << self
  end

  #private
  def all_sub_employees
    sub_employees_array = []
    stack = self.employees.dup
    until stack.empty?
      employee = stack.pop
      sub_employees_array << employee
      if employee.is_a? Manager
        stack += employee.employees
      end
    end
    sub_employees_array.uniq
  end

  public
  def calculate_bonus(multiplier = 1)
    self.all_sub_employees.map do |employee|
      employee.salary
    end.inject(&:+) * multiplier
  end
end

sean = Manager.new('Sean')
olena = Manager.new('Olena')
fred = Manager.new("Fred")
jane = Employee.new("Jane")

sean.add_employee(olena)
sean.add_employee(fred)
olena.add_employee(fred)
fred.add_employee(jane)

fred.salary = 1
olena.salary = 1000
sean.salary = 20000
jane.salary = 500_000_000

p sean.all_sub_employees.length
sean.all_sub_employees.each {|emp| p emp.name}

p sean.calculate_bonus(1)
# sean.employees.each { |emp| p emp.name }
#
# puts "olena's empl"
# olena.employees.each { |emp| p emp.name }
# p "'fred's bosses"
# fred.boss.each { |boss| p boss.name }




