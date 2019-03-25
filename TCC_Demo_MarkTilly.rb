#Script created 3/25/2019 by Mark Tilly for TCC

require 'watir'   

app_url = 'https://www.taxcreditco.com/'

b = Watir::Browser.new :chrome # opens a new Chrome session 
sleep(1)
b.window.maximize              # go big or go home
sleep(2)

class AutoLog                          # class for logging, error handling and screenshots
  def self.log
    if @logger.nil?
      @logger = Logger.new('C:\Users\rmtil\Documents\TCC_Demo.log', 'daily')
      @logger.level = Logger::DEBUG                      # capture low level information for developers
      @logger.datetime_format = '%Y-%m-%d %H:%M:%S '     # timestamp all logged events to the second
    end
    @logger
  end
end

                                        
def test_failed(message)                # error handling
  AutoLog.log.error message             # logs the error message
  Signal.trap('INT') {exit 0}           # trap the interrupt signal and prevent script from exiting
end


def screen_shot(b, ss)                  # gen up and log a screenshot
  FileUtils.mkdir_p('C:\Users\rmtil\Documents\Screenshots') unless File.exist?('C:\Users\rmtil\Documents\Screenshots')
  b.screenshot.save "C:\\Users\\rmtil\\Documents\\Screenshots\\/Error-#{ss}.png"
  AutoLog.log.info "Screen shot saved as: Error-#{ss}" 
rescue
  AutoLog.log.error 'Unable to save screenshot'
end

begin                                         # validate navigation to taxcreditco.com
  b.goto app_url
  Watir::Wait.until {b.a(:href => 'https://taxcreditco.com').present?}
  AutoLog.log.info "Navigated to #{app_url} successfully"
rescue
  sstime = Time.new.strftime('%Y%m%d%H%M%S')
  ss = ("#{sstime}" + ' No landing page')
  screen_shot(b,ss)
  test_failed "Unable to navigate to #{app_url}"
end

sleep(3)

begin                                         # validate navigation to Contacts page
  b.li(:id => 'menu-item-369').click          # click the Contact button
  Watir::Wait.until {b.body(:class => ['page-template page-template-pages page-template-template-contact page-template-pagestemplate-contact-php page page-id-48']).present?}
  AutoLog.log.info "Navigated to Contact form successfully"
rescue
  sstime = Time.new.strftime('%Y%m%d%H%M%S')
  ss = ("#{sstime}" + ' Unable to navigate to Contact page')
  screen_shot(b,ss)
  test_failed 'Unable to navigate to Contact page'
end

sleep(3)
                                                # fill out the form
b.text_field(:name => 'firstname').set 'test'
sleep(1)
b.text_field(:name => 'jobtitle').set 'test'
sleep(1)
b.text_field(:name => 'company').set 'test'
sleep(1)
b.text_field(:name => 'email').set 'test@test.com'
sleep(1)
b.text_field(:name => 'phone').set '333-555-4444'
sleep(1)

begin
b.input(:value => 'Submit').click                            # Submit form and validate Thank you message 
  Watir::Wait.until {b.div(:class => 'hbspt-form').present?}
  AutoLog.log.info 'Thank you message received successfully'
rescue
  sstime = Time.new.strftime('%Y%m%d%H%M%S')
  ss = ("#{sstime}" + ' Thank you message not received')
  screen_shot(b,ss)
  test_failed 'Did not receive Thank you message'
end

sleep(3)

b.close                                # close the browser


