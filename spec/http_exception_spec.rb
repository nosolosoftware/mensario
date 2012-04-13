require File.expand_path(File.join('.', 'spec_helper'), File.dirname(__FILE__))

describe Mensario do
  it "Should be configurable through class methods" do
    Mensario.username = "AnUser"
    Mensario.password = "APassword"
    Mensario.license = "ThisIsALicense"

    Mensario.username.should == "AnUser"
    Mensario.password.should == "APassword"
    Mensario.license.should == "ThisIsALicense"
  end
  
  it "Should set parameters using the method set_config" do
    Mensario::set_config do |m|
      m.username = "AnUser"
      m.password = "APassword"
      m.license = "ThisIsALicense"
    end

    Mensario.username.should == "AnUser"
    Mensario.password.should == "APassword"
    Mensario.license.should == "ThisIsALicense"
  end

  it "Should raise an exception if the network fails" do
    Net::HTTP.any_instance.stub(:request).and_raise( Exception )

    opts = {
      :sender => 'Myself',
      :text => 'My message',
      :code => 34,
      :phone => 123456789,
      :timezone => 'Europe/Madrid'
      }

    lambda { Mensario::send_message( opts ) }.should raise_error MensarioHttpException
  end

  it "Should raise an exception if the profile it is not defined" do
    lambda do 
      Mensario::config( { :config => "config/bad_config.yml" , :profile => :unexisting } )
    end.should raise_error MensarioException
  end
end
