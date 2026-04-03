require 'rails_helper'

RSpec.describe "Employees", type: :request do 
   let(:employee_params) do
    {
      employee: {
        full_name: "Anjali",
        job_title: "Developer",
        country: "India",
        salary: 50000
      }
    }
  end

  describe "POST /employees" do
    it "creates employee" do
      post "/employees", params: employee_params
      expect(response).to have_http_status(:created)
    end
  end

  describe "GET /employees" do
    let!(:employee) { Employee.create!(employee_params[:employee]) }

    it "returns all employees" do
      get "/employees"
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /employees/:id" do
    let!(:employee) { Employee.create!(employee_params[:employee]) }

    it "returns specific employee" do
      get "/employees/#{employee.id}"
      expect(response).to have_http_status(:ok)
    end
  end
  
  describe "PUT /employees/:id" do
    let!(:employee) { Employee.create!(employee_params[:employee]) }

    it "updates employee successfully" do
      put "/employees/#{employee.id}", params: { employee: { job_title: "Senior Dev" } }
      expect(response).to have_http_status(:ok)
    end

    it "returns unprocessable_entity for invalid data" do
      put "/employees/#{employee.id}", params: { employee: { full_name: nil } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
