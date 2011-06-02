Given /^the license number, username and password in the profile "(.*)"$/ do |profile|
  Mensario.config(:profile => profile.to_sym)
end

Given /^the id "([^"]*)"$/ do |id|
  @id = id
end

Given /^"([^"]*)" as sender$/ do |sender|
  @sender = sender
end

Given /^"([^"]*)" as text$/ do |text|
  @text = text
end

Given /^(\d+) as prefix and "([^"]*)" phone in file "([^"]*)"$/ do |code, status, file|
  file = Dir.getwd + '/features/' + file
  @phone = YAML.load_file(file)[status.to_sym]
  @code = code
end

Given /^"([^"]*)" as timezone$/ do |timezone|
  @timezone = timezone
end

Given /^a send time$/ do
  @date = Time.new + 3600*24
end

Given /^a new message id$/ do
  params = {
      :sender => 'Calamar',
      :text => 'Yo tambien pienso que Bob Esponja es muy absorbente xD',
      :date => (Time.new + 3600*24),
      :code => 34,
      :phone => 685467890,
      :timezone => 'Europe/Madrid'
    }

    @id = Mensario::send_message(params)
end

When /^I do the "(.*)" call$/ do |call|
  begin
    @result = Mensario.send(call.to_sym)
  rescue MensarioException => e
    @exception = e
  end
end

When /^I do the status call$/ do
  begin
    @result = Mensario::status(@id)
  rescue MensarioException => e
    @exception = e
  end
end

When /^I do the balance call$/ do
  begin
    @result = Mensario::balance
  rescue MensarioException => e
    @exception = e
  end
end

When /^I do the destroy call$/ do
  begin
    # Create a sms to destroy
    

    @result = Mensario::destroy(@id)
  rescue MensarioException => e
    @exception = e
  end
end

When /^I do the send_message call$/ do
  begin
    params = {
      :sender => @sender,
      :text => @text,
      :date => @date,
      :code => @code,
      :phone => @phone,
      :timezone => @timezone
    }

    @result = Mensario::send_message(params)
    
    # Destroy sms after send (test purpose only)
    Mensario::destroy(@result)
  rescue MensarioException => e
    @exception = e
  end
end

Then /^the API should give us the balance remaining$/ do
  fail unless @result > 0
end

Then /^the API should give us the status code "([^"]*)"$/ do |code|
  fail unless @result == code
end

Then /^Mensario should raise a exception with status "(.*)"$/ do |status|
  fail unless @exception.status == status
end

Then /^the API should tell us that the message is cancelled$/ do
  fail unless @result == true
end

Then /^the API should tell us that the message can't be cancelled$/ do
  fail unless @result == false
end

Then /^Mensario should response with a sms number$/ do
  fail unless @result > 0
end
