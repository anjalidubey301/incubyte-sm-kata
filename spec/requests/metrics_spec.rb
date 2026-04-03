require 'rails_helper'

RSpec.describe "Metrics", type: :request do
   describe "GET /metrics/country" do
    it "returns min, max, avg salary for country" do
      Employee.create!(full_name: "A", job_title: "Dev", country: "India", salary: 100)
      Employee.create!(full_name: "B", job_title: "Dev", country: "India", salary: 200)

      get "/metrics/country?country=India"

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)

      expect(json["min"]).to eq(100)
      expect(json["max"]).to eq(200)
      expect(json["average"]).to eq(150.0)
    end
  end
end
