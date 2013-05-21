class Employee
  attr_accessor :name, :title, :salary, :boss
  def initialize(name)
    @name = name
    @boss = []
  end

  # def sub_employee_salary(employee)
  #   visited = []
  #   sub_employees = self.employees # get all employees for current
  #   while sub_employees # while we have employees still
  #     employee = sub_employees.pop # grab one employee
  #     employees += employee.employees # add her employees to stack
  # end

  def calculate_bonus(multiplier = 1)
    raise "Please set salary for #{self.name}" if salary.nil?
    case self.class.is_a?
    when Employee
      puts "or here"
      bonus = salary * multiplier
    when Manager
      puts "I'm here :)"
      self.employees.map do |employee|
        employee.salary #+ employee.calculate_bonus
      end.inject(&:+)
    end
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
end

sean = Manager.new('Sean')
olena = Manager.new('Olena')
fred = Employee.new("Fred")

sean.add_employee(olena)
sean.add_employee(fred)
olena.add_employee(fred)
fred.salary = 10000
olena.salary = 10000
sean.salary = 20000

p sean.calculate_bonus(1)
# sean.employees.each { |emp| p emp.name }
#
# puts "olena's empl"
# olena.employees.each { |emp| p emp.name }
# p "'fred's bosses"
# fred.boss.each { |boss| p boss.name }




