Given /^the license, username and password in file "(.*)"$/ do |file|
  # Load config data from files
  file = File.expand_path('../../', __FILE__) + '/' + file
  if File.exist? file
    @data = YAML.load_file(file)
  else
    @data = {:license => '', :username => '', :password => ''}
  end

  @message = Mensario::Mensario.new do |c|
    c.license = @data[:license]
    c.username = @data[:username]
    c.password = @data[:password]
  end
end

When /^I do the "(.*)" call$/ do |call|
  begin
    @result = @message.send(call.to_sym)
  rescue Mensario::MensarioException => e
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
  begin
    @result = @message.send_message(@prefix, @phone, @body)
  rescue Mensario::MensarioException => e
    @exception = e
  end
end

Then /^the API should give us the request id$/ do
  pending # express the regexp above with the code you wish you had
end

Then /^the API should give us the quantity remaining$/ do
  fail unless @result.class == Fixnum 
end

Given /^the request id in file "([^"]*)"$/ do |file|
  file = File.expand_path('../../', __FILE__) + '/' + file
  @request_id = YAML.load(open(file))[:request]
end

When /^I do the request_query call$/ do
  begin
    @result = @message.request_query(@request_id)
  rescue Mensario::MensarioException => e
    @exception = e
  end
end

Then /^the API should give us the status code of the request$/ do
  fail unless @result
end

Given /^a wrong request id$/ do
  @request_id = 4
end

Then /^the status code should be "([^"]*)"$/ do |status|
  fail unless @result.first['status'].first == status
end

Then /^the API should give us the type and quantity of the license$/ do
  fail unless @result.first['quantity']
  fail unless @result.first['type']
end

Given /^an extra license in file "([^"]*)"$/ do |file|
  file = File.expand_path('../../', __FILE__) + '/' + file
  @extra = YAML.load(open(file))
  @extra = [
    { 'number' => @extra[:license],
      'user' => @extra[:username],
      'pass' => @extra[:password]
    }
  ]
end

When /^I do the license_query call with parameters$/ do
  begin
    @result = @message.license_query(@extra)
  rescue Mensario::MensarioException => e
    @exception = e
  end
end

Then /^the response should be an Array with 2 or more fields$/ do
  fail unless @result.length > 1
end
