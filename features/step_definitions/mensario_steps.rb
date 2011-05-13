Given /^the license, username and password in file "(.*)"$/ do |file|
  # Load config data from files
  file = File.expand_path('../../', __FILE__) + '/' + file
  @data = YAML.load(open(file))

  @message = Mensario.new do |c|
    c.license = @data[:license]
    c.username = @data[:username]
    c.password = @data[:password]
  end
end

When /^I do the "(.*)" call$/ do |call|
  @message.send(call.to_sym)
end

Then /^the API should response with "(.*)" code$/ do |code|
  pending
end

Given /^a empty timezone$/ do
  @message.timezone = ''
end

Then /^the timestamp should be in GMT\+(\d+)$/ do |offset|
pending
end

Given /^a "(.*)" timezone$/ do |timezone|
  @message.timezone = timezone
end
