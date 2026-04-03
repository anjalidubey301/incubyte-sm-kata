require 'rails_helper'

RSpec.describe "Salaries", type: :request do
  describe "GET /employees/:id/salary" do
    let(:base_attributes) do
      {
        full_name: "A",
        job_title: "Dev",
        salary: 1000
      }
    end

    def get_salary(employee)
      get "/employees/#{employee.id}/salary"
      JSON.parse(response.body)
    end

    context "when country is India" do
      it "calculates salary with 10% deduction" do
        emp = Employee.create!(base_attributes.merge(country: "India"))

        json = get_salary(emp)

        expect(response).to have_http_status(:ok)
        expect(json["gross"]).to eq(1000)
        expect(json["deduction"]).to eq(100)
        expect(json["net"]).to eq(900)
      end
    end

    context "when country is United States" do
      it "calculates salary with 12% deduction" do
        emp = Employee.create!(base_attributes.merge(country: "United States"))

        json = get_salary(emp)

        expect(json["net"]).to eq(880)
      end
    end

    context "when country is other" do
      it "returns full salary without deduction" do
        emp = Employee.create!(base_attributes.merge(country: "UK"))

        json = get_salary(emp)

        expect(json["net"]).to eq(1000)
      end
    end
  end
end