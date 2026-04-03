class MetricsController < ApplicationController
  def country
    employees = filtered_employees(:country)

    render json: salary_stats(employees), status: :ok
  end

  def job_title
    employees = filtered_employees(:job_title)

    render json: {
      average: average_salary(employees)
    }, status: :ok
  end

  private

  def filtered_employees(filter_key)
    Employee.where(filter_key => params[filter_key])
  end

  def salary_stats(employees)
    {
      min: employees.minimum(:salary),
      max: employees.maximum(:salary),
      average: average_salary(employees)
    }
  end

  def average_salary(employees)
    employees.average(:salary).to_f
  end
end