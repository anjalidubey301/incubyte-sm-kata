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
    it "returns all employees" do
      Employee.create!(employee_params[:employee])
      get "/employees"
      expect(response).to have_http_status(:ok)
    end
  end
end
