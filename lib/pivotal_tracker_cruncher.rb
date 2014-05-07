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

  def list_unstarted_stories(project_id)
    conn = Faraday.new(:url => 'https://www.pivotaltracker.com') do |faraday|
      faraday.request :url_encoded # form-encode POST params
      faraday.response :logger # log requests to STDOUT
      faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
    end
    response = conn.get do |req|
      req.url "/services/v5/projects/#{project_id}/stories?&with_state=unstarted"
      req.headers['X-TrackerToken'] = @token
    end
    story_data = JSON.parse(response.body)
    story_data.each do |story|
      puts story['name']
    end
  end

  def list_details_of_story(project_id, story_id)
    conn = Faraday.new(:url => 'https://www.pivotaltracker.com') do |faraday|
      faraday.request :url_encoded # form-encode POST params
      faraday.response :logger # log requests to STDOUT
      faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
    end
    response = conn.get do |req|
      req.url "/services/v5/projects/#{project_id}/stories/#{story_id}"
      req.headers['X-TrackerToken'] = @token
    end
    story = JSON.parse(response.body)
    story.each_pair do |type, detail|
      puts "#{type}: #{detail}"
    end
  end

end
