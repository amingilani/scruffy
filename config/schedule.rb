every 30.minutes do
  command '/usr/bin/some_great_command'
  runner 'MyModel.some_method'
  rake 'some:great:rake:task'
end
