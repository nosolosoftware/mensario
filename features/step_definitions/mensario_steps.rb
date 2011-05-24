Given /^the license number, username and password in the profile "(.*)"$/ do |profile|
  Mensario.config(:profile => profile.to_sym)
end

Given /^the id "([^"]*)"$/ do |id|
  @message_id = id
end

When /^I do the "(.*)" call$/ do |call|
  begin
    @result = Mensario.send(call.to_sym)
  rescue MensarioException => e
    @exception = e
  end
end

Then /^the API should response with "(.*)" code$/ do |code|
  fail unless @message.status == code

  if @message.status != Mensario::Status::OK
    fail unless @exception.status == @message.status
  end
end

Given /^a empty timezone$/ do
  @message.timezone = ''
end

Then /^the timestamp should be correct$/ do
  # create time in specified zone
  tz = TZInfo::Timezone.get(@message.timezone != '' ? @message.timezone : 'UTC' )
  # Parse the response time
  time = @message.response['timestamp'].first.match(/^\d{8}(\d{2})/)[1].to_i
  # Validate
  fail unless (tz.now.hour.to_i - time).abs < 1800
end

Given /^a "(.*)" timezone$/ do |timezone|
  @message.timezone = timezone
end

When /^I do the send_message call$/ do
  begin
    @result = @message.send_message(@prefix, @phone, @body)
  rescue Mensario::MensarioException => e
    @exception = e
  end
end

When /^I do the status call$/ do
  begin
    @result = Mensario::status(@message_id)
  rescue
    @exception = e
  end
end

When /^I do the destroy call$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the API should give us the request id$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the API should give us the balance remaining$/ do
  fail unless @result > 0
end

Given /^the request id in file "([^"]*)"$/ do |file|
  file = File.expand_path('../../', __FILE__) + '/' + file
  @request_id = YAML.load(open(file))[:request]
end

Then /^the API should give us the status code "([^"]*)"$/ do |code|
  fail unless @result == code
end

Then /^the API should tell us that the message is cancelled$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the API should tell us that the message can't be cancelled$/ do
  pending # express the regexp above with the code you wish you had
end
