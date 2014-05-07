require 'faraday'
require 'json'

class PivotalTrackerCruncher

  def initialize(token)
    @token = token
  end

  def list_projects
    conn = Faraday.new(:url => 'https://www.pivotaltracker.com') do |faraday|
      faraday.request :url_encoded # form-encode POST params
      faraday.response :logger # log requests to STDOUT
      faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
    end
    response = conn.get do |req|
      req.url '/services/v5/projects'
      req.headers['X-TrackerToken'] = @token
    end

    project_data = JSON.parse(response.body)
    project_data.each do |project|
      puts project['name']
    end

  end

end
