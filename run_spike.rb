require 'dotenv'
Dotenv.load
require_relative 'lib/pivotal_tracker_cruncher'

ptc = PivotalTrackerCruncher.new(ENV['TOKEN'])
ptc.list_projects
ptc.list_unstarted_stories(1029432)
ptc.list_details_of_story(1029432, 70243804)
