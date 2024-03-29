api_spike
=========

Class assignment May 05

Your assignment is to write two scripts, one for each API, that uses the Faraday gem (https://github.com/lostisland/faraday) to make API requests using the following APIs. If you have other APIs, please feel free to use them.

Please push all work to a new repository called ‘api_spike’. Include a Gemfile in your project. Include your Github URL on this document: 
https://github.com/gSchool/march2014ProjectUrls/blob/master/apiSpike.md

http://openweathermap.org/API

1. Display the current weather for a city of your choice
2. Get the 7 day forecast for a city of your choosing.

https://www.pivotaltracker.com/help/api (requires use of HTTP header for authentication https://www.pivotaltracker.com/help/api#Authenticating_Using_API_Tokens)

1. List all of your projects (https://www.pivotaltracker.com/help/api/rest/v5#Projects)
2. List the stories in a project (https://www.pivotaltracker.com/help/api/rest/v5#Stories)
3. Show the details of a specific story (https://www.pivotaltracker.com/help/api/rest/v5#Story)

++++++++++++++

# Let's get these guys working!

## Weather Cruncher

* fork, clone, bundle install
* in terminal:

    $ irb
    > require '<path of weather_cruncher.rb>'
    > weather = WeatherCruncher.new
    > weather.current_weather(Denver)

Displays current weather conditions in Denver.

    > weather.forcast_7_day(Denver)

Displays 7 day forecast for Denver.

## Pivotal Tracker Cruncher

* fork, clone, bundle install (unless you already did for the Weather Cruncher)
* in terminal:

    $ irb
    > require '<path of pivotal_tracker_cruncher.rb>'
    > ptc = PivotalTrackerCruncher.new('<api token>')
    > ptc.list_projects
    > ptc.list_unstarted_stories(<project number>)
    > ptc.list_details_of_story(<project number>, <story number>)

### Oh Hey! Remember that you totally SHOULD NOT push your api token! Maybe save that in a .env file that is added to your .gitignore file.

* Check out that .env.example file... copy that to a .env file, add your api token for Pivotal Tracker, and create a .gitignore file with the contents being:

    .env

Hooray! Secret token safe, and working code.
