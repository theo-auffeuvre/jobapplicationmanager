class CompaniesController < ApplicationController

  def search_company
    require 'uri'
    require 'net/http'

    @input = params[:search]

    uri = URI("https://autocomplete.clearbit.com/v1/companies/suggest?query=#{@input}")

    req = Net::HTTP::Get.new(uri)
    req['Authorization'] = "Bearer #{ENV['CLEARBIT_API_KEY']}"
    req['Content-Type'] = 'application/json'

    @companies = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(req)
    end

    respond_to do |format|
      format.json { render json: @companies.body }
    end
  end
end
