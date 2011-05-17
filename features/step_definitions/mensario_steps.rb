Given /^the license, username and password in file "(.*)"$/ do |file|
  # Load config data from files
  file = File.expand_path('../../', __FILE__) + '/' + file
  @data = YAML.load(open(file))

  @message = Mensario::Mensario.new do |c|
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

Given /^the phone number in the file "([^"]*)"$/ do |file|
  # Load config data from files
  file = File.expand_path('../../', __FILE__) + '/' + file
  @phone = YAML.load(open(file))[:recipient]
end

Given /^the prefix "([^"]*)"$/ do |arg|
  @prefix = arg
end

Given /^the text body$/ do
  @body = 'Probando, probando'
end

When /^I do the send_message call$/ do
  @message.send_message(@prefix, @phone, @body)
end

Then /^the API should give us the request id$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the API should give us the quantity remaining$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^the request id$/ do
  pending # express the regexp above with the code you wish you had
end

When /^I do the request_query call$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the API should give us the status code of the request$/ do
  pending # express the regexp above with the code you wish you had
end

Given /^a wrong request id$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the status code should be "([^"]*)"$/ do |arg1|
  pending # express the regexp above with the code you wish you had
end

Then /^the API should give us the type and quantity of the license$/ do
  pending # express the regexp above with the code you wish you had
end
