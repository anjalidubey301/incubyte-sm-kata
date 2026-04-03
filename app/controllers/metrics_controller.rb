class MetricsController < ApplicationController
  def country
    employees = Employee.where(country: params[:country])

    render json: {
      min: employees.minimum(:salary),
      max: employees.maximum(:salary),
      average: employees.average(:salary).to_f
    }, status: :ok
  end
   
  def job_title
    employees = Employee.where(job_title: params[:job_title])

    render json: {
      average: employees.average(:salary).to_f
    }, status: :ok
  end
end