Given /^the license, username and password in file "(.*)"$/ do |file|
  # Load config data from files
  file = File.expand_path('../../', __FILE__) + '/' + file
  @data = YAML.load(open(file))
end

When /^I do the synchronization petition$/ do
  @message = Mensario.new do |c|
    c.license = @data[:license]
    c.username = @data[:username]
    c.password = @data[:password]
  end

  @message.synchronize
end

Then /^the API should response with "([^"]*)" code$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Given /^a empty timezone$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the timestamp should be in "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Given /^a "([^"]*)" timezone$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end
