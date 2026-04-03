require 'rails_helper'

RSpec.describe "Metrics API", type: :request do
  let(:base_attributes) do
    {
      full_name: "Employee",
      job_title: "Dev",
      salary: 100
    }
  end

  def json_response
    JSON.parse(response.body)
  end

  describe "GET /metrics/country" do
    let!(:employee1) { Employee.create!(base_attributes.merge(country: "India", salary: 100)) }
    let!(:employee2) { Employee.create!(base_attributes.merge(country: "India", salary: 200)) }

    it "returns min, max, avg salary for country" do
      get "/metrics/country?country=India"

      expect(response).to have_http_status(:ok)
      expect(json_response["min"]).to eq(100)
      expect(json_response["max"]).to eq(200)
      expect(json_response["average"]).to eq(150.0)
    end
  end

  describe "GET /metrics/job_title" do
    let!(:employee1) { Employee.create!(base_attributes.merge(country: "India", salary: 100)) }
    let!(:employee2) { Employee.create!(base_attributes.merge(country: "US", salary: 300)) }

    it "returns average salary by job title" do
      get "/metrics/job_title?job_title=Dev"

      expect(response).to have_http_status(:ok)
      expect(json_response["average"]).to eq(200.0)
    end
  end
end