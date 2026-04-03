class SalaryCalculator
  def self.call(employee)
    deduction =
      case employee.country
      when "India" then employee.salary * 0.10
      when "United States" then employee.salary * 0.12
      else 0
      end

    {
      gross: employee.salary,
      deduction: deduction,
      net: employee.salary - deduction
    }
  end
end