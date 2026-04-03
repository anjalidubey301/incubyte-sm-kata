require 'rails_helper'

RSpec.describe "Salaries", type: :request do
  describe "GET /employees/:id/salary" do
    it "calculates salary for India" do
      emp = Employee.create!(
        full_name: "A",
        job_title: "Dev",
        country: "India",
        salary: 1000
      )

      get "/employees/#{emp.id}/salary"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)

      expect(json["gross"]).to eq(1000)
      expect(json["deduction"]).to eq(100)
      expect(json["net"]).to eq(900)
    end
    
    it "calculates salary for United States" do
      emp = Employee.create!(
        full_name: "A",
        job_title: "Dev",
        country: "United States",
        salary: 1000
      )

      get "/employees/#{emp.id}/salary"

      json = JSON.parse(response.body)
      expect(json["net"]).to eq(880)
    end
  end
end
