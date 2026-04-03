require 'rails_helper'

RSpec.describe "Employees", type: :request do

  describe "POST /employees" do
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
    it "creates employee" do
      post "/employees", params: employee_params
      expect(response).to have_http_status(:created)
    end
  end
end
