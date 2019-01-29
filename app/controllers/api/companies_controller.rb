module Api
  class CompaniesController < ApplicationController
    # GET /companies
    def index
      render json: Company.all
    end

    # GET /companies/:id
    def show
      company = Company.find(params[:id])

      render json: company
    end

    # POST /companies
    def create
      company = Company.new(company_params)
      if company.save
        render json: company, status: :created
      else
        render json: { errors: company.errors }, status: :bad_request
      end
    end

    # DELETE /companies
    def destroy
      company = Company.find(params[:id])
      company.destroy
      head :no_content
    end

    # POST/companies
    def update
      company = Company.find(params[:id])
      if company.update(company_params)
        render json: company, status: :ok
      else
        render json: { errors: company.errors }, status: :bad_request
      end
    end

    private

    def company_params
      params.require(:company).permit(:name)
    end
  end
end
