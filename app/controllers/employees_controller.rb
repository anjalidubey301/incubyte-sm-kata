class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :update, :destroy, :salary]

  def create
    employee = Employee.new(employee_params)

    if employee.save
      render json: employee, status: :created
    else
      render json: { errors: employee.errors }, status: :unprocessable_entity
    end
  end

  def index
    employees = Employee.all
    render json: employees, status: :ok
  end

  def show
    render json: @employee, status: :ok
  end

  def update
    if @employee.update(employee_params)
      render json: @employee, status: :ok
    else
      render json: { errors: @employee.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @employee.destroy
    head :no_content
  end

  def salary
    render json: SalaryCalculator.call(@employee), status: :ok
  end

  private

  def set_employee
    @employee = Employee.find_by(id: params[:id])
    render json: { error: "Employee not found" }, status: :not_found if @employee.nil?
  end

  def employee_params
    params.require(:employee).permit(:full_name, :job_title, :country, :salary)
  end
end