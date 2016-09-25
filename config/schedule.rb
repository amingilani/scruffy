set :output, '/usr/local/bin/scruffy/logs/cron.log'

every 30.minutes do
  command '/usr/local/bin/scruffy/scruffy.rb'
end

every 1.day do
  command '/usr/bin/git -C /home/gilani/scruffy/ pull'
end
