set :output, '/usr/local/bin/scruffy/logs/cron.log'

every 30.minutes do
  command '/usr/local/bin/scruffy/scruffy.rb'
end
